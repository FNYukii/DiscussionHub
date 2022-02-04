//
//  Crypto.swift
//  DiscussionHub
//
//  Created by Yu on 2022/02/03.
//

import Foundation

class Crypto {
    
    func toCaesarCipher(from: String, key: Int, wordCount: Int) -> String {
        let inputStr = from
        let prefixedInputStr = String(inputStr.prefix(wordCount))
        
        let charCodes = toCharCodes(from: prefixedInputStr)
        let encryptedCharCodes = toEncryptedCharCodes(from: charCodes, key: key)
        let outputStr = toString(from: encryptedCharCodes)
        return outputStr
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
        let badCharCodes01 = [58, 59, 60, 61, 62, 63, 64]
        let badCharCodes02 = [91, 92, 93, 94, 95, 96]
        var encryptedCharCodes: [Int] = []
        for index in 0..<charCodes.count {
            let charCode: Int = charCodes[index]
            
            // keyの数だけ文字コードを後ろにずらす
            var encryptedCharCode: Int = charCode + key
            
            // 文字コードが48...122の範囲に収まるように調整
            encryptedCharCode = (encryptedCharCode % 74) + 48
                
            // ;や]などの記号の文字コードだった場合も調整
            if badCharCodes01.contains(encryptedCharCode) {
                encryptedCharCode += 7
            }
            if badCharCodes02.contains(encryptedCharCode) {
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
