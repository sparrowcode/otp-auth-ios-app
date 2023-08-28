import Intents

class IntentHandler: INExtension, SelectAccountIntentHandling {
    
    func provideAccountOptionsCollection(for intent: SelectAccountIntent, with completion: @escaping (INObjectCollection<IntentAccount>?, Error?) -> Void) {
        let accounts: [IntentAccount] = KeychainStorage.getAccounts().map { account in
            return convertToIntentAccount(account)
        }
        let collection = INObjectCollection(items: accounts)
        completion(collection, nil)
    }
    
    func defaultAccount(for intent: SelectAccountIntent) -> IntentAccount? {
        guard let account = KeychainStorage.getAccounts().first else { return nil }
        return convertToIntentAccount(account)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    private func convertToIntentAccount(_ account: AccountModel) -> IntentAccount {
        let intentAccount = IntentAccount(
            identifier: account.url.absoluteString,
            display: account.issuer + " (\(account.login))"
        )
        intentAccount.login = account.login
        intentAccount.issuer = account.issuer
        intentAccount.secret = account.secret
        return intentAccount
    }
}
