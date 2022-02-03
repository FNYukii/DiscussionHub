//
//  Crypto.swift
//  DiscussionHub
//
//  Created by Yu on 2022/02/03.
//

import Foundation

class Crypto {
    
    func toCaesarCipher(from: String, wordCount: Int) -> String {
        let inputStr = from
        let prefixedInputStr = String(inputStr.prefix(wordCount))
        let key = dateNum()
        
        let charCodes = toCharCodes(from: prefixedInputStr)
        let encryptedCharCodes = toEncryptedCharCodes(from: charCodes, key: key)
        let outputStr = toString(from: encryptedCharCodes)
        return outputStr
    }
    
    private func dateNum() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateNum: Int = Int(dateFormatter.string(from: Date()))!
        return dateNum // 20220203
    }
    
    private func toCharCodes(from: String) -> [Int] {
        let inputStr = from
        var charCodes: [Int] = []
        for char in inputStr {
            let oneChar: String = String(char)
            let charCode: Int = Int(UnicodeScalar(oneChar)!.value)
            charCodes.append(charCode)
        }
        return charCodes // [119, 74, 81, 103, ...]
    }
    
    private func toEncryptedCharCodes(from: [Int], key: Int) -> [Int] {
        let charCodes = from
        let badNums01 = [58, 59, 60, 61, 62, 63, 64]
        let badNums02 = [91, 92, 93, 94, 95, 96]
        var encryptedCharCodes: [Int] = []
        for index in 0..<charCodes.count {
            let charCode: Int = charCodes[index]
            var encryptedCharCode: Int = ((charCode + key) % 74) + 48
            if badNums01.contains(encryptedCharCode) {
                encryptedCharCode += 7
            }
            if badNums02.contains(encryptedCharCode) {
                encryptedCharCode += 6
            }
            encryptedCharCodes.append(encryptedCharCode)
        }
        return encryptedCharCodes // [78, 56, 49, 91, ...]
    }
    
    private func toString(from: [Int]) -> String {
        let charCodes = from
        var outputStr = ""
        for index in 0..<charCodes.count {
            let charCode: Int = charCodes[index]
            let charCodeUInt32: UInt32 = UInt32(charCode)
            let charCodeScalar: UnicodeScalar = UnicodeScalar(charCodeUInt32)!
            let char: Character = Character(charCodeScalar)
            outputStr.append(char)
        }
        return outputStr // "wA4jX3mNyL"
    }
}
