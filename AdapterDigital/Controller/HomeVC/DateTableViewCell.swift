//
//  DateTableViewCell.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 20/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import UIKit
import DropDown

protocol DateTableViewCellDelegate {
    func deleteButtonTapped(date: String, indexPath: IndexPath)
    func changeDayOffType(date: String, type: DayoffType)
}

class DateTableViewCell: UITableViewCell {
    
    var delegate: DateTableViewCellDelegate?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dropDownView: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var dropDown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDropDown()
        setupDeleteButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func dropViewButton(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.deleteButtonTapped(date: dateLabel.text!, indexPath: self.indexPath!)
    }
   
    func setupDeleteButton() {
        deleteButton.addBorder()
        deleteButton.rounded(radius: 5.0)
    }
    
    func setupDropDown() {
        dropDownView.imageView?.tintColor = UIColor.black
        
        dropDownView.layer.cornerRadius = 5
        dropDownView.layer.borderWidth = 1
        dropDownView.layer.borderColor = UIColor.darkGray.cgColor
        
        DropDown.startListeningToKeyboard()
        
        dropDown.anchorView = dropDownView
        dropDown.dataSource = ["เต็มวัน", "ครึ่งวัน"]
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { (index: Int, item: String) in
            let dayOffType = item == "เต็มวัน" ? DayoffType.full_day: DayoffType.half_day
            self.delegate?.changeDayOffType(date: self.dateLabel.text!, type: dayOffType)
        }
    }

}
