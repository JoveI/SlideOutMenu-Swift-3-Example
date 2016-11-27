//
//  FirstViewController.swift
//  SlideOutMenuSwift3Version
//
//  Created by Jovan Ivanovski on 11/23/16.
//  Copyright © 2016 Jovan Ivanovski. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, MenuDelegate {

    // MARK: - Properties
    var centerViewControllerDelegate: CenterViewControllerDelegate?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print()
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
    
    // MARK: - Actions
    
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        toggleMenu()
    }
    

}
