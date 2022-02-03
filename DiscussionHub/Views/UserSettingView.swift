//
//  UserSettingView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/02/03.
//

import SwiftUI

struct UserSettingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var displayname = UserDefaults.standard.string(forKey: "displayname") ?? ""
    @State var isUseRandomDisplayname = UserDefaults.standard.bool(forKey: "isUseRandomDisplayname")

    var body: some View {
        NavigationView {
            Form {
                
                TextField("ニックネーム", text: $displayname)
                    .disabled(!isUseRandomDisplayname)
                
                Section {
                    Toggle("ランダムなニックネームを使う", isOn: $isUseRandomDisplayname)
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
                        UserDefaults.standard.set(displayname, forKey: "displayname")
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
