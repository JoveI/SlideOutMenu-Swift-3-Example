//
//  CenterViewControllerDelegate.swift
//  SlideOutMenuSwift3Version
//
//  Created by Jovan Ivanovski on 11/23/16.
//  Copyright © 2016 Jovan Ivanovski. All rights reserved.
//

import Foundation


@objc
protocol CenterViewControllerDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func collapseLeftPanel()
    @objc optional func isMenuExpanded() -> Bool
}
