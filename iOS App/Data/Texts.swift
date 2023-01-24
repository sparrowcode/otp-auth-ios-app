import Foundation

enum Texts {
    
    enum Shared {
        
        static var added: String { NSLocalizedString("shared added", comment: "") }
        static var cancel: String { NSLocalizedString("shared cancel", comment: "") }
        static var close: String { NSLocalizedString("shared close", comment: "") }
        static var copied: String { NSLocalizedString("shared copied", comment: "") }
        static var delete: String { NSLocalizedString("shared delete", comment: "") }
        static var deleted: String { NSLocalizedString("shared deleted", comment: "") }
        static var error: String { NSLocalizedString("shared error", comment: "") }
        static var export: String { NSLocalizedString("shared export", comment: "") }
        static var OK: String { NSLocalizedString("shared ok", comment: "") }
        static var unknown: String { NSLocalizedString("shared unknown", comment: "") }
        static var try_again: String { NSLocalizedString("shared try again", comment: "") }
        static var secret_code: String { NSLocalizedString("shared secret code", comment: "") }
    }
    
    enum Watch {
        
        static var insert_secret: String { NSLocalizedString("watch insert secret", comment: "") }
        static var insert_secret_description: String { NSLocalizedString("watch insert secret description", comment: "") }
        static var add_account: String { NSLocalizedString("watch add account", comment: "") }
        
        static var local_accounts_header: String { NSLocalizedString("watch local accounts header", comment: "") }
        static var local_accounts_description: String { NSLocalizedString("watch local accounts description", comment: "") }
        
        static var settings_progress_title: String { NSLocalizedString("watch settings progress title", comment: "") }
        static var settings_progress_footer: String { NSLocalizedString("watch settings progress footer", comment: "") }
        
        static var settings_show_profile_title: String { NSLocalizedString("watch settings show profile title", comment: "") }
        static var settings_show_profile_footer: String { NSLocalizedString("watch settings show profile footer", comment: "") }
        
        static var settings_clean_local_accounts_title: String { NSLocalizedString("watch settings clean local accounts title", comment: "") }
        static var settings_clean_local_accounts_footer: String { NSLocalizedString("watch settings clean local accounts footer", comment: "") }
        static var settings_clean_local_accounts_action: String { NSLocalizedString("watch settings clean local accounts action", comment: "") }
        static var settings_clean_local_accounts_confirm_title: String { NSLocalizedString("watch settings clean local accounts confirm title", comment: "") }
        static var settings_clean_local_accounts_confirm_description: String { NSLocalizedString("watch settings clean local accounts confirm description", comment: "") }
        
        static var settings_accounts_visible_title: String { NSLocalizedString("watch settings accounts visible title", comment: "") }
        static var settings_accounts_visible_footer: String { NSLocalizedString("watch settings accounts visible footer", comment: "") }
        
        static var settings_accounts_show_in_complications_title: String { NSLocalizedString("watch settings accounts show in complications title", comment: "") }
        static var settings_accounts_show_in_complications_footer: String { NSLocalizedString("watch settings accounts show in complications footer", comment: "") }
        
        static var code_visible_all: String { NSLocalizedString("watch code visible all", comment: "") }
        static var code_visible_only_local: String { NSLocalizedString("watch code visible only local", comment: "") }
        static var code_visible_only_sync: String { NSLocalizedString("watch code visible only sync", comment: "") }
        
        static var no_any_local_accounts: String { NSLocalizedString("watch no any local accounts", comment: "") }
        static var no_any_sync_accounts: String { NSLocalizedString("watch no any sync accounts", comment: "") }
        static var no_any_accounts: String { NSLocalizedString("watch no any accounts", comment: "") }
    }
    
    enum Auth {
        
        static var logic_description: String { NSLocalizedString("auth login description", comment: "") }
        static var change_description: String { NSLocalizedString("auth change description", comment: "") }
        
        enum Alert {
            
            static var title: String { NSLocalizedString("auth alert fail title", comment: "") }
            static var description: String { NSLocalizedString("auth alert fail description", comment: "") }
        }
        
    }
    
    enum Alerts {
        
        static var code_added: String { NSLocalizedString("alert service code added", comment: "") }
        static var code_deleted: String { NSLocalizedString("alert service code deleted", comment: "") }
        static var no_token: String { NSLocalizedString("alert service no token", comment: "") }
        static var token_exists: String { NSLocalizedString("alert service token exists", comment: "") }
        static var incorrect_url: String { NSLocalizedString("alert service incorrect url", comment: "") }
        static var email_error: String { NSLocalizedString("alert service email error", comment: "") }
    }
    
    enum Permissions {
        
        static var denied_title: String { NSLocalizedString("permissions camera denied alert title", comment: "") }
        static var denied_subtitle: String { NSLocalizedString("permissions camera denied alert subtitle", comment: "") }
        static var denied_action: String { NSLocalizedString("permissions camera denied alert action", comment: "") }
    }
    
    enum HomeController {

        static var title: String { NSLocalizedString("root controller title", comment: "") }
        
        static var header_view_action: String { NSLocalizedString("root controller header view action", comment: "") }
        static var header_view_description: String { NSLocalizedString("root controller header view description", comment: "") }
        
        static var account_section_header: String { NSLocalizedString("root controller section account header", comment: "") }
        static var empty_cell_title: String { NSLocalizedString("root controller empty cell title", comment: "") }
        static var empty_cell_subitle: String { NSLocalizedString("root controller empty cell subtitle", comment: "") }
        static var account_section_footer: String { NSLocalizedString("root controller account section footer", comment: "") }
        
        static var settings_button: String { NSLocalizedString("root controller settings button", comment: "") }
        static var settings_section_footer: String { NSLocalizedString("root controller settings section footer", comment: "") }
        
        static var delete_alert_title: String { NSLocalizedString("settings controller delete alert title", comment: "") }
        static var delete_alert_message: String { NSLocalizedString("settings controller delete alert message", comment: "") }
    }
    
    enum ExportController {

        static var title: String { NSLocalizedString("export controller title", comment: "") }
        static var description: String { NSLocalizedString("export controller description", comment: "") }
        
        static var footer: String { NSLocalizedString("export controller footer", comment: "") }
    }
    
    enum ScanController {
        
        static var title: String { NSLocalizedString("scan controller title", comment: "") }
        static var description: String { NSLocalizedString("scan controller description", comment: "") }
        
        static var qr_detail: String { NSLocalizedString("scan controller qr detail", comment: "") }
        
        static var scan_feature_title: String { NSLocalizedString("scan controller scan feature title", comment: "") }
        static var scan_feature_description: String { NSLocalizedString("scan controller scan feature description", comment: "") }
        
        static var google_import_feature_title: String { NSLocalizedString("scan controller google import feature title", comment: "") }
        static var google_import_feature_description: String { NSLocalizedString("scan controller google import feature description", comment: "") }
    }
    
    enum SettingsController {
        
        static var title: String { NSLocalizedString("settings controller title", comment: "") }
        
        static var app_section_header: String { NSLocalizedString("setings controller app section header", comment: "") }
        static var appereance_button: String { NSLocalizedString("settings controller appereance cell", comment: "") }
        static var notification_button: String { NSLocalizedString("settings controller notification cell", comment: "") }
        static var sounds_button: String { NSLocalizedString("settings controller sounds cell", comment: "") }
        static var language_button: String { NSLocalizedString("settings controller language cell", comment: "") }
        static var app_section_footer: String { NSLocalizedString("setings controller app section footer", comment: "") }
        
        static var feedback_section_header: String { NSLocalizedString("setings controller feedback section header", comment: "") }
        static var review_button: String { NSLocalizedString("settings controller review cell", comment: "") }
        static var contact_button: String { NSLocalizedString("settings controller contact cell", comment: "") }
        static var feedback_email_body: String { NSLocalizedString("settings controller feedback email body", comment: "") }
        static var feedback_section_footer: String { NSLocalizedString("setings controller feedback section footer", comment: "") }
        
        static var media_section_header: String { NSLocalizedString("setings controller media section header", comment: "") }
        static var website_button: String { NSLocalizedString("settings controller website cell", comment: "") }
        static var telegram_button: String { NSLocalizedString("settings controller telegram cell", comment: "") }
        static var twitter_button: String { NSLocalizedString("settings controller twitter cell", comment: "") }
        static var instagram_button: String { NSLocalizedString("settings controller instagram cell", comment: "") }
        static var media_section_footer: String { NSLocalizedString("setings controller media section footer", comment: "") }
        
        static var about_button: String { NSLocalizedString("settings controller about cell", comment: "") }
        static var about_section_footer: String { NSLocalizedString("setings controller about section footer", comment: "") }
        
        enum Password {
            
            static var title: String { NSLocalizedString("settings password controller title", comment: "") }
            
            static var header: String { NSLocalizedString("setings password controller section header", comment: "") }
            static var cell: String { NSLocalizedString("settings password controller cell", comment: "") }
            static var footer: String { NSLocalizedString("setings password controller section footer", comment: "") }
            
            static var allow_widget: String { NSLocalizedString("settings password controller allow widget", comment: "") }
            static var allow_widget_footer: String { NSLocalizedString("setings password controller section allow_widget footer", comment: "") }
        }
        
        enum Appearance {
            
            static var title: String { NSLocalizedString("settings appearance controller title", comment: "") }
            
            static var appearance_header: String { NSLocalizedString("settings appearance controller table header", comment: "") }
            static var automatic_footer: String { NSLocalizedString("settings appearance controller table automatic footer", comment: "") }
            static var manually_footer: String { NSLocalizedString("settings appearance controller table manually footer", comment: "") }
            
            static var automatic_cell: String { NSLocalizedString("settings appearance controller automatic cell", comment: "") }
            static var light_cell: String { NSLocalizedString("settings appearance controller light cell", comment: "") }
            static var dark_cell: String { NSLocalizedString("settings appearance controller dark cell", comment: "") }
            
            static var colors_header: String { NSLocalizedString("settings appearance controller colors table header", comment: "") }
            static var colors_footer: String { NSLocalizedString("settings appearance controller colors table footer", comment: "") }
            
            static var red_color: String { NSLocalizedString("settings appearance controller red color cell", comment: "") }
            static var pink_color: String { NSLocalizedString("settings appearance controller pink color cell", comment: "") }
            static var orange_color: String { NSLocalizedString("settings appearance controller orange color cell", comment: "") }
            static var yellow_color: String { NSLocalizedString("settings appearance controller yellow color cell", comment: "") }
            static var green_color: String { NSLocalizedString("settings appearance controller green color cell", comment: "") }
            static var blue_color: String { NSLocalizedString("settings appearance controller blue color cell", comment: "") }
            static var purple_color: String { NSLocalizedString("settings appearance controller purple color cell", comment: "") }
            static var gray_color: String { NSLocalizedString("settings appearance controller gray color cell", comment: "") }
        }
        
        enum Sounds {
            
            static var title: String { NSLocalizedString("settings sounds controller title", comment: "") }
            
            static var header: String { NSLocalizedString("settings sounds controller table header", comment: "") }
            static var footer: String { NSLocalizedString("settings sounds controller table footer", comment: "") }
            
            static var enabled: String { NSLocalizedString("settings sounds controller enabled cell", comment: "") }
            static var disabled: String { NSLocalizedString("settings sounds controller disabled cell", comment: "") }
            static var during_day: String { NSLocalizedString("settings sounds controller during day cell", comment: "") }
        }
        
        enum Languages {
            
            static var title: String { NSLocalizedString("settings languages controller title", comment: "") }
            
            static var header: String { NSLocalizedString("settings languages controller header", comment: "") }
            static var footer: String { NSLocalizedString("settings languages controller footer", comment: "") }
            
            static var russian: String { NSLocalizedString("settings languages controller cell russian", comment: "") }
            static var english: String { NSLocalizedString("settings languages controller cell english", comment: "") }
            static var german: String { NSLocalizedString("settings languages controller cell german", comment: "") }
            static var french: String { NSLocalizedString("settings languages controller cell french", comment: "") }
            static var ukrainian: String { NSLocalizedString("settings languages controller cell ukrainian", comment: "") }
        }
        
        enum AboutApp {
            
            static var title: String { NSLocalizedString("settings about app controller title", comment: "") }
            
            static var version_header: String { NSLocalizedString("settings about app controller version header", comment: "") }
            static var version_cell_title: String { NSLocalizedString("settings about app controller version cell title", comment: "") }
            static var version_cell_detail: String { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? Texts.Shared.unknown }
            static var version_footer: String { NSLocalizedString("settings about app controller version footer", comment: "") }
            
            static var openSource_header: String { NSLocalizedString("settings about app controller open source header", comment: "") }
            static var openSource_cell_title: String { NSLocalizedString("settings about app controller open source cell title", comment: "") }
            static var openSource_footer: String { NSLocalizedString("settings about app controller open source footer", comment: "") }
            
            static var package_header: String { NSLocalizedString("settings about app controller package header", comment: "") }
            static var package_cell: String { NSLocalizedString("settings about app controller package cell", comment: "") }
            static var package_footer: String { NSLocalizedString("settings about app controller package footer", comment: "") }
        }
        
    }
}
