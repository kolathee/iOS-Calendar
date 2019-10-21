//
//  BaseViewController.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 20/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    /// Overide these properties in subclasses
    var identifier: String { "" }
    var storyboardName: String { "" }
    // static let shared = ViewController()
    
// MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
// MARK: - Functions
    
    func initiateView() -> UIViewController {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: identifier)
    }
    
}
