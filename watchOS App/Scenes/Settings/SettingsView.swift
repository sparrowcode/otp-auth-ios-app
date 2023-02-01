import SwiftUI

struct SettingsView: View {
    
    @AppStorage(Constants.ud_progress_show_key) var enabledProgress = true
    @AppStorage(Constants.ud_show_profile) var enabledProfile = false
    @AppStorage(Constants.ud_account_visible_id) var codeVisibleID = OTPCodeVisibility.all
    
    @State private var showCleanKeychainAlert = false
    
    var body: some View {
        List {
            Section {
                NavigationLink {
                    AuthSettingsView()
                } label: {
                    SettingsRowView(title: Texts.SettingsController.Password.cell, systemName: "lock.circle.fill", backgroundIconColor: .green)
                }
            } header: {
                
            } footer: {
                Text(Texts.Watch.settings_accounts_show_in_complications_footer)
            }
            Section {
                Picker(selection: $codeVisibleID) {
                    ForEach(OTPCodeVisibility.allCases, id: \.self) {
                        Text($0.localized)
                    }
                } label: {
                    Text(Texts.Watch.settings_accounts_visible_title)
                }
            } header: {
                
            } footer: {
                Text(Texts.Watch.settings_accounts_visible_footer)
            }
            Section {
                HStack {
                    Toggle(Texts.Watch.settings_progress_title, isOn: $enabledProgress)
                }
            } header: {
                
            } footer: {
                Text(Texts.Watch.settings_progress_footer)
            }
            Section {
                HStack {
                    Toggle(Texts.Watch.settings_show_profile_title, isOn: $enabledProfile)
                }
            } header: {
                
            } footer: {
                Text(Texts.Watch.settings_show_profile_footer)
            }
            Section {
                Button {
                    showCleanKeychainAlert = true
                } label: {
                    SettingsRowView(title: Texts.Watch.settings_clean_local_accounts_title, systemName: "trash.circle.fill", backgroundIconColor: .red)
                }
                .alert(Texts.Watch.settings_clean_local_accounts_confirm_title, isPresented: $showCleanKeychainAlert, actions: {
                    Button(Texts.Watch.settings_clean_local_accounts_action, role: .destructive, action: {
                        let keychain = Constants.WatchKeychain.service
                        let urls = KeychainStorage.getAccounts(with: keychain).map({ $0.url })
                        KeychainStorage.delete(urls: urls, with: keychain)
                        showCleanKeychainAlert = false
                    })
                    Button(Texts.Shared.cancel, role: .cancel, action: {
                        showCleanKeychainAlert = false
                    })
                }) {
                    Text(Texts.Watch.settings_clean_local_accounts_confirm_description)
                }

            } header: {
                
            } footer: {
                Text(Texts.Watch.settings_clean_local_accounts_footer)
            }
        }
        .navigationTitle(Texts.SettingsController.title)
    }
}
