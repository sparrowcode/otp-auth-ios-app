import UIKit
import WatchConnectivity

class WatchSync: NSObject, WCSessionDelegate {
    
    static func configure() {
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = shared
        WCSession.default.activate()
        
        NotificationCenter.default.addObserver(forName: .changedAccounts, object: nil, queue: nil) { notification in
            self.updateContext()
        }
    }
    
    static func updateContext() {
        guard WCSession.default.activationState == .activated else { return }
        var context: [String : Any] = [:]
        context["accounts"] = KeychainStorage.getAccounts().map({ $0.url.absoluteString })
        do {
            try WCSession.default.updateApplicationContext(context)
        } catch {
            print("WatchSync: \(#function) error: \(error.localizedDescription) ")
        }
    }
    
    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("WatchSync: \(#function) activationState: \(activationState.rawValue) error: \(String(describing: error?.localizedDescription)) ")
        WatchSync.updateContext()
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        // There is in the Apple's example.
        session.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Got message. All mesages its trigger for update, so just update context.
        WatchSync.updateContext()
    }
    
    // MARK: - Singltone
    
    static let shared = WatchSync()
    private override init() {}
}
