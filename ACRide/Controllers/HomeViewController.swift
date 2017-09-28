import UIKit
import MapKit

class HomeViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var requestButton: RoundedShadowButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate : CenterVCDelegate?

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
