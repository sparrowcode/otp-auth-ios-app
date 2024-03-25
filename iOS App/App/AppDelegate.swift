import UIKit
import AVFAudio
import SparrowKit
import NativeUIKit
import SPIndicator
import SwiftyJSON
import FirebaseWrapper
import FirebaseWrapperRemoteConfig

var processCopyOTPCode: String? = nil

enum RemoteConfig {
    
    case is_request_review_after_import_code
    
    var key: String {
        switch self {
        case .is_request_review_after_import_code:
            return "is_request_review_after_import_code"
        }
    }
    
    var bool: Bool {  FirebaseWrapper.RemoteConfig.getBool(key: key) }
}

@main
class AppDelegate: SPAppWindowDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //FirebaseApp.configure()
        FirebaseWrapper.configure()
        FirebaseWrapper.RemoteConfig.configure(defaults: [
            RemoteConfig.is_request_review_after_import_code.key : NSNumber(booleanLiteral: false)
        ])
        
        if let value = launchOptions?[.url] {
            if let url = value as? URL {
                processLaunchURL(url)
            }
        }
        
        makeKeyAndVisible(createViewControllerHandler: {
            return Settings.isPasswordEnabled ? AuthController() : RootController()
        }, tint: .systemBlue)
        
        AppearanceControlService.check()
        WatchSync.configure()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let code = processCopyOTPCode {
            AlertService.copied()
            UIPasteboard.general.string = code
            processCopyOTPCode = nil
        }
        
        NotificationCenter.default.post(name: .changedAccounts)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        processLaunchURL(url)
        return true
    }
    
    private func processLaunchURL(_ url: URL) {
        if url.absoluteString.lowercased().hasPrefix("otpauth://copycode") {
            if let code = url.valueOf("code") {
                processCopyOTPCode = code
            }
        }
    }
}
