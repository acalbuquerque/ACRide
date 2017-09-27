//
//  UIVIew+Extension.swift
//  ACRide
//
//  Created by Toni Albuquerque on 27/09/17.
//  Copyright © 2017 acalbuquerque. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alpha: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
}
