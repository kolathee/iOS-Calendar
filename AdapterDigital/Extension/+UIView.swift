//
//  +UIView.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 20/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import UIKit

extension UIView {
    
    func addBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func rounded(radius: Double){
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
    
}
