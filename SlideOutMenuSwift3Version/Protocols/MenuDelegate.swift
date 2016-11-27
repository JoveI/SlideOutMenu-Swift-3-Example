//
//  MenuDelegate.swift
//  SlideOutMenuSwift3Version
//
//  Created by Jovan Ivanovski on 11/23/16.
//  Copyright © 2016 Jovan Ivanovski. All rights reserved.
//

import Foundation
import UIKit

protocol MenuDelegate {
    var centerViewControllerDelegate: CenterViewControllerDelegate? { get set }
}

extension MenuDelegate where Self: UIViewController {
    /**
     Adds a tap gesture recognizer for collapsing the menu.
     */
    func addTapGestureRecognizer(_ tapGesture: UITapGestureRecognizer) {
        let tmpTapGesture = tapGesture
        tmpTapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tmpTapGesture)
    }
    
    func toggleMenu() {
        guard centerViewControllerDelegate != nil else { return }
        centerViewControllerDelegate!.toggleLeftPanel?()
    }
}
