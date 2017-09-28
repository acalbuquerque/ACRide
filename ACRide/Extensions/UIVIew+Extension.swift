import UIKit

extension UIView {
    func fadeTo(alpha: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
}
