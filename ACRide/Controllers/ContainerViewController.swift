import UIKit
import QuartzCore

protocol ContainerViewControllerProtocols: class {
    func toogleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}

class ContainerViewController: UIViewController {
    
    enum SlideOutState {
        case collapsed
        case leftPanelExpaned
    }
    enum ShowWichVC {
        case homeVC
        case paymentVC
    }

    var showVC: ShowWichVC = .homeVC
    var centerController:UIViewController!
    var homeVC: HomeViewController!
    var leftVC: LeftSidePanelViewController!
    var isHidden = false
    var tap: UITapGestureRecognizer!
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadow = (currentState != .collapsed)
            shouldShowShadowForCenterVC(shouldShowShadow)
        }
    }
    let centerPanelExpandedOffset: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool{
        return isHidden
    }
    
    func initCenter(screen: ShowWichVC) {
        var presentingController: UIViewController
        showVC = screen
        if homeVC == nil {
            homeVC = UIStoryboard.homeViewController()
            homeVC.delegate = self
        }
        presentingController = homeVC
        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        centerController = presentingController
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
    }
}

extension ContainerViewController: ContainerViewControllerProtocols {
    
    func toogleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpaned)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftVC!)
        }
    }

    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            setupWhiteCoverView()
            currentState = .leftPanelExpaned
            animateCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
        }
        else {
            isHidden = !isHidden
            animateStatusBar()
            hideWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: 0, completion: { (finished) in
                if finished == true {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            })
        }
    }
}

extension ContainerViewController {
    
    func addChildSidePanelViewController(_ sidePanelController: LeftSidePanelViewController) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func setupWhiteCoverView(){
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0
        whiteCoverView.backgroundColor = .white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        whiteCoverView.fadeTo(alpha: 0.75, withDuration: 0.2)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        self.centerController.view.addGestureRecognizer(tap)
    }
    
    func hideWhiteCoverView(){
        centerController.view.removeGestureRecognizer(tap)
        for subview in self.centerController.view.subviews {
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }, completion: {(finished) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
    
    func shouldShowShadowForCenterVC(_ status: Bool) {
        if true {
            centerController.view.layer.shadowOpacity = 0.6
        } else {
            centerController.view.layer.shadowOpacity = 0
        }
    }
    
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftViewController() -> LeftSidePanelViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelViewController
    }
    
    class func homeViewController() -> HomeViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
    }
}
