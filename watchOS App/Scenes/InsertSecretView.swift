import SwiftUI

struct InsertSecretView: View {
    
    @State private var insertedText = ""
    @State private var saveEnabled = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            Section {
                TextField(Texts.Shared.secret_code, text: $insertedText)
                    .autocorrectionDisabled()
                    .onChange(of: insertedText) { newValue in
                        self.insertedText = newValue.trim
                        if let url = URL(string: self.insertedText) {
                            self.saveEnabled = AccountModel.getByURL(url) != nil
                        } else {
                            self.saveEnabled = false
                        }
                    }
            } header: {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 8)
                    Text(Texts.Watch.insert_secret)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 0)
                }
            } footer: {
                VStack(spacing: 16) {
                    Text(Texts.Watch.insert_secret_description)
                    VStack(spacing: 6) {
                        Button(action: {
                            guard let url = URL(string: self.insertedText) else { return }
                            KeychainStorage.add(
                                urls: [url],
                                with: Constants.WatchKeychain.service
                            )
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text(Texts.Watch.add_account)
                            }
                            .fontWeight(.medium)
                        })
                        .disabled(!saveEnabled)
                        .buttonStyle(.borderedProminent)
                        .tint(.accentColor)
                    }
                }
            }
        }
    }
}
