import UIKit
import SparrowKit
import SPAlert
import SPIndicator

enum AlertService {
    
    static func copied() {
        let indicatorView = SPIndicatorView(title: Texts.Shared.copied, preset: .done)
        indicatorView.present(duration: 3)
        SoundsService.play(sound: .success)
    }
    
    static func code_added() {
        SPAlert.present(
            title: Texts.Shared.added,
            message: Texts.Alerts.code_added,
            preset: .done,
            completion: nil
        )
        SoundsService.play(sound: .success)
    }
    
    static func code_deleted() {
        SPAlert.present(
            title: Texts.Shared.deleted,
            message: Texts.Alerts.code_deleted,
            preset: .done,
            completion: nil
        )
        SoundsService.play(sound: .delete)
    }
    
    static func alertNoToken() {
        SPAlert.present(
            title: Texts.Shared.error,
            message: Texts.Alerts.no_token,
            preset: .error
        )
        SoundsService.play(sound: .error)
    }
    
    static func alertTheSameCode() {
        SPAlert.present(
            title: Texts.Shared.error,
            message: Texts.Alerts.token_exists,
            preset: .custom(Images.already_added_code)
        )
        SoundsService.play(sound: .error)
    }
    
    static func alertIncorrectURL() {
        SPAlert.present(
            title: Texts.Shared.error,
            message: Texts.Alerts.incorrect_url,
            preset: .error
        )
        SoundsService.play(sound: .error)
    }
    
    static func email_error() {
        SPAlert.present(message: Texts.Alerts.email_error, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
}
