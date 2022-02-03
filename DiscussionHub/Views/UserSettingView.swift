//
//  UserSettingView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/02/03.
//

import SwiftUI

struct UserSettingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var displayname = UserDefaults.standard.string(forKey: "userDisplayname") ?? ""
    @State var isUseRandomDisplayname = UserDefaults.standard.object(forKey: "isUseRandomDisplayname") as? Bool ?? true

    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("ディスプレイネーム設定")) {
                    TextField("ディスプレイネーム", text: $displayname)
                        .disabled(isUseRandomDisplayname)
                        .foregroundColor(isUseRandomDisplayname ? .secondary : .primary)
                    Toggle("投稿ごとにランダムな文字列を使用する", isOn: $isUseRandomDisplayname)
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
                        UserDefaults.standard.set(displayname, forKey: "userDisplayname")
                        UserDefaults.standard.set(isUseRandomDisplayname, forKey: "isUseRandomDisplayname")
                        dismiss()
                    }){
                        Text("完了")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}
