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
        AlertKitAPI.present(title: Texts.Shared.added, subtitle: Texts.Alerts.code_added, icon: .done, style: .iOS17AppleMusic, haptic: .success)
        SoundsService.play(sound: .success)
    }
    
    static func code_deleted() {
        AlertKitAPI.present(title: Texts.Shared.deleted, subtitle: Texts.Alerts.code_deleted, icon: .done, style: .iOS17AppleMusic, haptic: .success)
        SoundsService.play(sound: .delete)
    }
    
    static func alertNoToken() {
        AlertKitAPI.present(title: Texts.Shared.error, subtitle: Texts.Alerts.no_token, icon: .error, style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
    static func alertTheSameCode() {
        AlertKitAPI.present(title: Texts.Shared.error, subtitle: Texts.Alerts.token_exists, icon: .custom(Images.already_added_code), style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
    static func alertIncorrectURL() {
        AlertKitAPI.present(title: Texts.Shared.error, subtitle: Texts.Alerts.incorrect_url, icon: .error, style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
    static func email_error() {
        AlertKitAPI.present(title: Texts.Alerts.email_error, subtitle: nil, icon: .error, style: .iOS17AppleMusic, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
}
