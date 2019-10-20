//
//  HomeViewController.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 20/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let homeVM = HomeViewModel()
        
// MARK: - Outlets

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var selectedDatesTextView: UITextView!
    @IBOutlet weak var addDatesButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var numberOfDaysoffLabel: UILabel!
    @IBOutlet weak var numberOfRemainingDaysLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
        
       
// MARK: - Setup
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        setupUI()
    }
    
    func setupViewModel() {
    }
    
    func setupTableView() {
       tableView.rowHeight = 50
    }
    
    func setupUI() {
        userNameLabel.text = homeVM.userFullName
        
        addDatesButton.isEnabled = false
        requestButton.isEnabled = false
        selectedDatesTextView.isEditable = false
        
        selectedDatesTextView.addBorder()
        selectedDatesTextView.rounded(radius: 5.0)
        
        requestButton.addBorder()
        requestButton.rounded(radius: 5.0)
    }
    
    

// MARK: - Actions
        
    @IBAction func calendarButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func addDatesButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func requestButtonTapped(_ sender: Any) {
        
    }

}
