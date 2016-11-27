//
//  ContainerViewController.swift
//  SlideOutMenuSwift3Version
//
//  Created by Jovan Ivanovski on 11/23/16.
//  Copyright © 2016 Jovan Ivanovski. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    // MARK: - Properties
    fileprivate var centerNavigationController: UINavigationController!
    fileprivate var centerViewController: MenuDelegate!
    fileprivate var leftMenuViewController: LeftMenuTableViewController!
    fileprivate let centerPanelExpandedOffset: CGFloat = 60
    fileprivate var currentState: SlideOutState = SlideOutState.collapsed {
        didSet {
            let shouldShowShadow = currentState != .collapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setCenterViewControllerWithIdentifier(Identifiers.firstViewControllerStoryboardID)
        addCenterViewControllerToContainer()
        
        // Add left and right swipe
        addLeftSwipeGestureRecognizer()
        addRightSwipeGestureRecognizer()
        
        // Add tap gesture recognizer
        addTapGestureRecognizer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Selectors
    
    func leftSwipeGestureAction(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        guard currentState == .expanded else { return }
        toggleLeftPanel()
    }
    
    func rightSwipeGestureAction(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        guard currentState == .collapsed else { return }
        toggleLeftPanel()
    }
    
    func tapGestureAction(_ tapGestureRecognizer: UITapGestureRecognizer) {
        guard currentState == .expanded else { return }
        toggleLeftPanel()
    }
    
    // MARK: - Helper functions
    
    /**
     Sets the view controller which has the given identifier as a center view controller.
     */
    fileprivate func setCenterViewControllerWithIdentifier(_ identifier: String) {
        switch identifier {
        case Identifiers.firstViewControllerStoryboardID:
            centerViewController = UIStoryboard.main.instantiateViewController(withIdentifier: identifier) as? FirstViewController
            centerNavigationController = UINavigationController(rootViewController: (centerViewController as? FirstViewController)!)
        case Identifiers.secondViewControllerStoryboardID:
            centerViewController = UIStoryboard.main.instantiateViewController(withIdentifier: identifier) as? SecondViewController
            centerNavigationController = UINavigationController(rootViewController: (centerViewController as? SecondViewController)!)
        default:
            break
        }
        guard centerNavigationController != nil && centerViewController != nil else { return }
        centerNavigationController.navigationBar.barTintColor = UIColor.black
        centerNavigationController.navigationBar.tintColor = UIColor.white
        centerViewController.centerViewControllerDelegate = self
    }
    
    /**
     Function that changes the shadow of the centered view controller acordingly to the SlideOutState
     */
    fileprivate func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow == true {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        }
        else {
            centerNavigationController.view.layer.shadowOpacity = 0
        }
    }
    
    /**
     Adds the menu view controller as a child to the container view controller.
     */
    fileprivate func addLeftPanelViewController() {
        // Added only if it doesn't exists
        guard leftMenuViewController == nil else { return }
        leftMenuViewController = UIStoryboard.leftMenuViewController
        leftMenuViewController.sidePanelViewControllerDelegate = self
        self.view.insertSubview(leftMenuViewController.view, at: 0)
        addChildViewController(leftMenuViewController)
        leftMenuViewController.didMove(toParentViewController: self)
    }
    
    /**
     Animates the expanding of the menu view controller.
     - parameter shouldExpand - Boolean variable which indeicates whether the menu view controller is already expanded or not.
     */
    fileprivate func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand == false {
            animateCenterPanel(toXPosition: 0) { finished in
                self.currentState = .collapsed
                self.leftMenuViewController.view.removeFromSuperview()
                self.leftMenuViewController = nil
            }
        }
        else {
            self.currentState = .expanded
            animateCenterPanel(toXPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
        }
    }
    
    /**
     Animates the center view controller x position when the menu view controller expands.
     - parameter targetPosition - The new x position of the center view controller.
     */
    fileprivate func animateCenterPanel(toXPosition targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        let options = UIViewAnimationOptions()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: options, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    

    /**
     Adds the center ViewController to the ContainerViewController.
     */
    fileprivate func addCenterViewControllerToContainer() {
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMove(toParentViewController: self)
        currentState = .collapsed
    }
    
    /**
     Adds a left swipe gesture recognizer.
    */
    fileprivate func addLeftSwipeGestureRecognizer() {
        guard centerNavigationController != nil else { return }
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeGestureAction(_:)))
        leftSwipe.direction = .left
        centerNavigationController.view.addGestureRecognizer(leftSwipe)
    }
    
    /**
     Adds a right swipe gesture recognizer.
    */
    fileprivate func addRightSwipeGestureRecognizer() {
        guard centerNavigationController != nil else { return }
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeGestureAction(_:)))
        rightSwipe.direction = .right
        centerNavigationController.view.addGestureRecognizer(rightSwipe)
    }
    
    /**
     Adds a tap gesture recognizer.
    */
    fileprivate func addTapGestureRecognizer() {
        guard centerNavigationController != nil else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(_:)))
        tapGesture.numberOfTapsRequired = 1
        centerNavigationController.view.addGestureRecognizer(tapGesture)
    }
    
}

// MARK: - CenterViewControllerDelegate methods
extension ContainerViewController: CenterViewControllerDelegate {
    
    /**
     Toggles the menu view controller.
     */
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .expanded)
        if notAlreadyExpanded == true {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    /**
     Returns true or false depending whether the menu is collapsed or expanded.
     */
    func isMenuExpanded() -> Bool {
        if currentState == .expanded {
            return true
        }
        else {
            return false
        }
    }
    
    /**
     Function that colpases the menu view controller if it's expanded.
     */
    func collapseLeftPanel() {
        switch currentState {
        case .expanded:
            toggleLeftPanel()
        default:
            break
        }
    }

}

// MARK: - SidePanelViewControllerDelegate methods
extension ContainerViewController: SidePanelViewControllerDelegate {
    func selectMenuItem(with identifier: String) {
        centerNavigationController.view.removeFromSuperview()
        centerNavigationController = nil
        setCenterViewControllerWithIdentifier(identifier)
        collapseLeftPanel()
        addCenterViewControllerToContainer()
    }
}
