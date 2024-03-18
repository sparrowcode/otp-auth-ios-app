import UIKit
import AVFAudio
import SparrowKit
import NativeUIKit
import Firebase
import SPIndicator
import SwiftyJSON

var processCopyOTPCode: String? = nil
var showReviewAferAddCode: Bool = false

@main
class AppDelegate: SPAppWindowDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
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
        
        let url = URL(string: "https://otp.apps.sparrowcode.io/start")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = JSON(data)
                let state = json["flags"]["request_review_after_add_code"].bool
                showReviewAferAddCode = state ?? false
            }
        }
        task.resume()
        
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
