import UIKit
import SafeSFSymbols

enum Images {
    static var copy: UIImage { .system("doc.on.doc.fill", font: UIFont.systemFont(ofSize: 19, weight: .medium)) }
    static var export: UIImage { .system("checkmark.circle.fill", font: UIFont.systemFont(ofSize: 19, weight: .medium)) }
    static var scan: UIImage { .system("qrcode.viewfinder", font: UIFont.systemFont(ofSize: 19, weight: .medium)) }
    static var settings: UIImage { .generateSettingsIcon("gear", backgroundColor: .tint) ?? UIImage() }
    
    static var appeareance: UIImage { .generateSettingsIcon("lightbulb.fill", backgroundColor: .systemIndigo) ?? UIImage() }
    static var sounds: UIImage { .generateSettingsIcon("music.note", backgroundColor: .systemPink) ?? UIImage() }
    static var password: UIImage { .generateSettingsIcon("lock.fill", backgroundColor: .systemGreen) ?? UIImage() }
    static var language: UIImage { .generateSettingsIcon("globe", backgroundColor: .systemGray) ?? UIImage() }
    
    static var review: UIImage { .generateSettingsIcon("heart.fill", backgroundColor: .systemRed) ?? UIImage() }
    static var contact: UIImage { .generateSettingsIcon("envelope.fill", backgroundColor: .systemBlue) ?? UIImage() }
    
    static var website: UIImage { .init(named: "Media Icon - Website") ?? UIImage() }
    static var telegram: UIImage { .init(named: "Media Icon - Telegram") ?? UIImage() }
    static var twitter: UIImage { .init(named: "Media Icon - Twitter") ?? UIImage() }
    static var instagram: UIImage { .init(named: "Media Icon - Instagram") ?? UIImage() }
    static var github: UIImage { .init(named: "Media Icon - GitHub") ?? UIImage() }
    
    static var about: UIImage { .generateSettingsIcon("house.fill", backgroundColor: .systemMint) ?? UIImage() }
}
