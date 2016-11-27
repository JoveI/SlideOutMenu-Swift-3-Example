//
//  UIStoryboardExtension.swift
//  SlideOutMenuSwift3Version
//
//  Created by Jovan Ivanovski on 11/23/16.
//  Copyright © 2016 Jovan Ivanovski. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    @nonobjc static let main = UIStoryboard(name: "Main", bundle: Bundle.main)
    @nonobjc static let slideOutMenu = UIStoryboard(name: "SlideOutMenu", bundle: nil)
    @nonobjc static let leftMenuViewController = UIStoryboard.slideOutMenu.instantiateViewController(withIdentifier: "leftMenuTableViewController") as? LeftMenuTableViewController
    
}
