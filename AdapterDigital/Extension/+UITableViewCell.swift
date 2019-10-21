//
//  +UITableViewCell.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 21/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import UIKit

extension UITableViewCell {

    var tableView: UITableView? {
        return superview as? UITableView
    }
 
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }

}
