import SwiftUI

struct ContentView: View {
    
    @AppStorage(Constants.ud_account_visible_id) var codeVisibleID = OTPCodeVisibility.all
    @ObservedObject var dataProvider = DataProvider()
    @State private var showingAddCodeSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if !dataProvider.syncedAccounts.isEmpty && (codeVisibleID != .onlyLocal) {
                        Section {
                            ForEach(dataProvider.syncedAccounts, id: \.self) { account in
                                CodeView(
                                    account: account,
                                    fromDate: $dataProvider.fromDate
                                )
                            }
                        } header: {
                            
                        } footer: {
                            Text(Texts.HomeController.account_section_footer)
                        }
                    }
                    if !dataProvider.localAccounts.isEmpty && (codeVisibleID != .onlySync) {
                        Section {
                            ForEach(dataProvider.localAccounts, id: \.self) { account in
                                CodeView(
                                    account: account,
                                    fromDate: $dataProvider.fromDate
                                )
                            }
                            .onDelete { indexSet in
                                var toDeleteAccounts: [AccountModel] = []
                                indexSet.forEach { index in
                                    if let account = dataProvider.localAccounts[safe: index] {
                                        toDeleteAccounts.append(account)
                                    }
                                }
                                KeychainStorage.delete(
                                    urls: toDeleteAccounts.map({ $0.url }),
                                    with: Constants.WatchKeychain.service
                                )
                            }
                        } header: {
                            Text(Texts.Watch.local_accounts_header)
                        } footer: {
                            Text(Texts.Watch.local_accounts_header)
                        }
                    }
                    if dataProvider.syncedAccounts.isEmpty && dataProvider.localAccounts.isEmpty && codeVisibleID == .all {
                        Section {} footer: {
                            Text(Texts.Watch.no_any_accounts)
                        }
                    }
                    if dataProvider.syncedAccounts.isEmpty && codeVisibleID == .onlySync {
                        Section {} footer: {
                            Text(Texts.Watch.no_any_sync_accounts)
                        }
                    }
                    if dataProvider.localAccounts.isEmpty && codeVisibleID == .onlyLocal {
                        Section {} footer: {
                            Text(Texts.Watch.no_any_local_accounts)
                        }
                    }
                    Section {
                        Button(action: {
                            showingAddCodeSheet.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text(Texts.HomeController.header_view_action)
                            }
                            .fontWeight(.medium)
                        })
                        .buttonStyle(.bordered)
                        .tint(.accentColor)
                    } header: {
                        
                    } footer: {
                        Text(Texts.HomeController.header_view_description)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
                    Section {
                        NavigationLink(destination: {
                            SettingsView()
                        }, label: {
                            SettingsRowView(title: Texts.HomeController.settings_button, systemName: "gear.circle.fill", backgroundIconColor: .blue)
                        })
                    }
                }
            }
            .navigationTitle(Texts.HomeController.title)
        }
        .sheet(isPresented: $showingAddCodeSheet) {
            InsertSecretView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .previewDisplayName("Main")
        InsertSecretView()
            .previewDisplayName("Insert Secret")
        SettingsView()
            .previewDisplayName("Settings")
    }
}
