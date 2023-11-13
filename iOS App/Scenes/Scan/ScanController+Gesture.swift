import UIKit
import NativeUIKit
import SparrowKit

extension ScanController {
    
    @objc func swipeHandler(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            initialCenter = scanView.center
            
        case .changed:
            let translation = gesture.translation(in: view)
            
            if translation.y >= 0 {
                let absTranslationY = abs(translation.y)
                let sqrtTranslationY = (sqrt(absTranslationY))
                
                if sqrtTranslationY < 150 {
                    scanView.center = CGPoint(x: initialCenter.x,
                                              y: initialCenter.y + sqrtTranslationY * 7)
                } else {
                    scanView.center = CGPoint(x: initialCenter.x,
                                              y: initialCenter.y + 150 + sqrtTranslationY)
                }
                
                
            } else {
                let absTranslationY = abs(translation.y)
                let sqrtTranslationY = -(sqrt(absTranslationY))
                if sqrtTranslationY > -100 {
                    scanView.center = CGPoint(x: initialCenter.x,
                                              y: initialCenter.y + (sqrtTranslationY * 7))
                } else {
                    scanView.center = CGPoint(x: initialCenter.x,
                                              y: initialCenter.y - 100 + sqrtTranslationY)
                }
                
            }
            
            if scanView.center.y < initialCenter.y - 50 {
                view.backgroundColor = UIColor.black.alpha(0.6)
            } else {
                if (translation.y / scanView.center.y) < 0.6 {
                    view.backgroundColor = UIColor.black.alpha(0.6 - (translation.y / scanView.center.y))
                    if view.backgroundColor!.alpha > 0.6 {
                        view.backgroundColor = UIColor.black.alpha(0.6)
                    }
                } else {
                    if (translation.y / scanView.center.y) > 0.5 {
                        view.backgroundColor = UIColor.black.alpha(0.0)
                    } else {
                        view.backgroundColor = UIColor.black.alpha(0.6)
                    }
                    
                }
            }
            
        case .ended, .cancelled:
            
            if scanView.center.y > (initialCenter.y + 50) {
                close()
            } else {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
                    self.viewDidLayoutSubviews()
                }
            }
            
        default:
            break
        }
    }
    
}
