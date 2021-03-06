//
//  HomeViewController.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 20/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    static let shared = HomeViewController()
    
    /// Overide these properties in subclasses
    override var storyboardName: String { "Main" }
    override var identifier: String { "homeViewController" }

// MARK: - ViewModel & Data
    
    let homeVM = HomeViewModel()
        
// MARK: - Outlets

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var selectedDatesTextView: UITextView!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var addDatesButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var numberOfDaysOffLabel: UILabel!
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
        homeVM.delegate = self
    }
    
    func setupTableView() {
       tableView.rowHeight = 50
    }
    
    func setupUI() {
        userNameLabel.text = homeVM.userFullName
        
        addDatesButton.isEnabled = false
        requestButton.isEnabled = false
        selectedDatesTextView.isEditable = false
        
        calendarButton.imageView?.image = UIImage(named: "calendar")
        
        selectedDatesTextView.addBorder()
        selectedDatesTextView.rounded(radius: 5.0)
        
        requestButton.addBorder()
        requestButton.rounded(radius: 5.0)
    }

// MARK: - Actions
        
    @IBAction func calendarButtonTapped(_ sender: Any) {
        let calendarVC = CalendarViewController.shared.initiateView() as! CalendarViewController
        calendarVC.calendarVM.daysOff = homeVM.daysOff
        calendarVC.delegate = self
        self.present(calendarVC, animated: true, completion: nil)
    }
    
    @IBAction func addDatesButtonTapped(_ sender: Any) {
        guard homeVM.canAddMoreDaysOff() else {
            let alert = Alert.error(title: "ลองใหม่อีกครั้ง", message: "วันลาคงเหลือไม่เพียงพอ", button: "ตกลง")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        homeVM.confirmAdding()
        tableView.reloadData()
        
        selectedDatesTextView.text = ""
        addDatesButton.isEnabled = false
    }
    
    @IBAction func requestButtonTapped(_ sender: Any) {
        let json = homeVM.sendDaysOffRequest()
        let alert = Alert.error(title: "JSON Request", message: json.description, button: "Done")
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - TableView

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.daysOff.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateTableViewCell", for: indexPath) as! DateTableViewCell
        
        let date = Array(homeVM.daysOff.keys)[indexPath.row]
        let type = homeVM.daysOff[date]?.rawValue == "full_day" ? "เต็มวัน" : "ครึ่งวัน"
        
        cell.dateLabel.text = date
        cell.dropDownView.setTitle(type, for: .normal)
        cell.delegate = self
        
        return cell
    }
    
}

// MARK: - TableView Cell

extension HomeViewController: DateTableViewCellDelegate {
    
    func changeDayOffType(date: String, type: DayoffType) {
        switch type {
        case .full_day:
            guard homeVM.availableDays >= 0.5 else {
                let alert = Alert.error(title: "ลองใหม่อีกครั้ง", message: "วันลาคงเหลือไม่เพียงพอ", button: "ตกลง")
                self.present(alert, animated: true, completion: nil)
                return
            }
        default:
            break
        }
        homeVM.daysOff[date] = type
        tableView.reloadData()
    }
    
    func deleteButtonTapped(date: String, indexPath: IndexPath) {
        let confirmPopup = Alert.delete(title: "ยืนยันการลบ",
                                        message: "คุณต้องการลบวันที่ขอลา\nวันที่ \(date)\nใช่หรือไม่",
                                        confirmBTText: "ใช่",
                                        cancelBTText: "ไม่") {
            self.homeVM.daysOff.removeValue(forKey: date)
            self.tableView.deleteRows(at: [indexPath], with: .middle)
        }
        self.present(confirmPopup, animated: true, completion: nil)
    }
    
}

// MARK: - Calendar delegate

extension HomeViewController: CalendarVCDelegate {
    
    func showSelectedDates(selectedDates: [String : DayoffType]) {
        homeVM.selectedDates = selectedDates
        let text = homeVM.selectedDatesString
        selectedDatesTextView.text = text
        addDatesButton.isEnabled = text == "" ? false : true
    }
    
}

// MARK: - ViewModel delegate

extension HomeViewController: HomeViewModelDelegate {
    
    func updateDaysOffAndTheRemaining(daysOff: Double, availableDays: Double) {
        numberOfDaysOffLabel.text = "\(daysOff) วัน"
        numberOfRemainingDaysLabel.text = "\(availableDays) วัน"
        
        requestButton.isEnabled = daysOff == 0 ? false : true
    }
    
}
