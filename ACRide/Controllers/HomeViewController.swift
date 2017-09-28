//
//  HomeViewController.swift
//  ACRide
//
//  Created by Toni Albuquerque on 26/09/17.
//  Copyright © 2017 acalbuquerque. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var requestButton: RoundedShadowButton!
    @IBOutlet weak var mapView: MKMapView!
    var delegate : ContainerViewControllerProtocols?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    @IBAction func requestAction(_ sender: Any) {
        requestButton.animateButton(shouldLoad: true, withMessage: nil)
    }
    @IBAction func menuButtonWasPressed(_ sender: Any) {
        delegate?.toogleLeftPanel()
    }
}
