//
//  RoundedShadowView.swift
//  ACRide
//
//  Created by Toni Albuquerque on 26/09/17.
//  Copyright © 2017 acalbuquerque. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        self.setupView()
    }
    func setupView() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.cornerRadius = 5.0
    }
}
