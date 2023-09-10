import UIKit
import LocalAuthentication

enum AppLocalAuthentication {
    
    static var isEnable: Bool {
        let context = LAContext()
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
    }
    
    static func request(reason: String, complecton: @escaping (Bool)->()) {
        let context = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { state, error in
            DispatchQueue.main.async { complecton(state) }
        }
    }
    
    static var supportBiometryType: String? {
        let context = LAContext()
        var error: NSError?
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        let type = context.biometryType
        switch type {
        case .faceID:
            return "Face ID"
        case .touchID:
            return "Touch ID"
        case .none:
            return nil
        case .opticID:
            return "Optic ID"
        @unknown default:
            return nil
        }
    }
    
    static var currentBiometryType: String? {
        let context = LAContext()
        var error: NSError?
        let usingBiometric = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        let type = context.biometryType
        switch type {
        case .faceID:
            guard usingBiometric else { return nil }
            return "Face ID"
        case .touchID:
            guard usingBiometric else { return nil }
            return "Touch ID"
        case .none:
            return nil
        case .opticID:
            guard usingBiometric else { return nil }
            return "Optic ID"
        @unknown default:
            return nil
        }
    }
}
