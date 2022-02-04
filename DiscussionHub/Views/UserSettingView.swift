//
//  UserSettingView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/02/03.
//

import SwiftUI
import FirebaseAuth

struct UserSettingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var isUseHandleName = UserDefaults.standard.bool(forKey: "isUseHandleName")
    @State var handleName = UserDefaults.standard.string(forKey: "handleName") ?? ""
    let handleNameTag: String
    
    init() {
        let userId = Auth.auth().currentUser?.uid ?? ""
        let crypto = Crypto()
        self.handleNameTag = crypto.toCaesarCipher(from: userId, key: 3, wordCount: 4)
    }

    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    Toggle("固定されたハンドルネームを使用する", isOn: $isUseHandleName.animation())
                    if isUseHandleName {
                        
                        HStack {
                            TextField("ハンドルネーム", text: $handleName)
                                .submitLabel(.done)
                            Divider()
                            Text("#\(handleNameTag)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationBarTitle("ユーザー設定", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // Save settings
                        UserDefaults.standard.set(handleName, forKey: "handleName")
                        UserDefaults.standard.set(isUseHandleName, forKey: "isUseHandleName")
                        dismiss()
                    }){
                        Text("完了")
                            .fontWeight(.bold)
                    }
                    .disabled(isUseHandleName && handleName.isEmpty)
                }
            }
        }
    }
}
