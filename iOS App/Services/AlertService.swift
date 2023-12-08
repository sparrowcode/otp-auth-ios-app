import UIKit
import SparrowKit
import AlertKit
import SPIndicator

enum AlertService {
    
    static func copied() {
        let indicatorView = SPIndicatorView(title: Texts.Shared.copied, preset: .done)
        indicatorView.present(duration: 3)
        SoundsService.play(sound: .success)
    }
    
    static func code_added() {
        AlertKitAPI.present(title: Texts.Alerts.code_added, subtitle: nil, icon: .done, style: .iOS17AppleMusic, haptic: .success)
        SoundsService.play(sound: .success)
    }
    
    static func code_deleted() {
        AlertKitAPI.present(title: Texts.Alerts.code_deleted, subtitle: nil, icon: .done, style: .iOS17AppleMusic, haptic: .success)
        SoundsService.play(sound: .delete)
    }
    
    static func alertUndef(code: String) {
        AlertKitAPI.present(title: Texts.Alerts.no_token + "Code Error \(code).", subtitle: nil, icon: .error, style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
    static func alertNoToken() {
        AlertKitAPI.present(title: Texts.Alerts.no_token, subtitle: nil, icon: .error, style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
    static func alertTheSameCode() {
        AlertKitAPI.present(title: Texts.Alerts.token_exists, subtitle: nil, icon: .custom(Images.already_added_code), style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
    static func alertIncorrectURL() {
        AlertKitAPI.present(title: Texts.Alerts.incorrect_url, subtitle: nil, icon: .error, style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
    static func email_error() {
        AlertKitAPI.present(title: Texts.Alerts.email_error, subtitle: nil, icon: .error, style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
}
