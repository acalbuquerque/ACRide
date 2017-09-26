//
//  RoundImageView.swift
//  ACRide
//
//  Created by Toni Albuquerque on 26/09/17.
//  Copyright © 2017 acalbuquerque. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}
