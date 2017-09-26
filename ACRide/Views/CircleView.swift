//
//  CircleView.swift
//  ACRide
//
//  Created by Toni Albuquerque on 26/09/17.
//  Copyright © 2017 acalbuquerque. All rights reserved.
//

import UIKit

class CircleView: UIView {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor?.cgColor
    }
}
