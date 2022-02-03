//
//  UserSettingView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/02/03.
//

import SwiftUI

struct UserSettingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var handleName = UserDefaults.standard.string(forKey: "handleName") ?? ""
    @State var isUseHandleName = UserDefaults.standard.bool(forKey: "isUseHandleName")

    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("表示名")) {
                    Toggle("固定されたハンドルネームを使用する", isOn: $isUseHandleName.animation())
                    if isUseHandleName {
                        TextField("ハンドルネーム", text: $handleName)
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
