//
//  CalendarViewController.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 20/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import UIKit
import FSCalendar
import SwiftDate

protocol CalendarVCDelegate {
    func showSelectedDates(selectedDates: [String: DayoffType])
}

class CalendarViewController: BaseViewController {
    
    static let shared = CalendarViewController()
      
    /// Identifier & Storyboard
    override var storyboardName: String { "Main" }
    override var identifier: String { "calendarViewController" }
    
    var delegate: CalendarVCDelegate?
    
    /// ViewModel & Data
    var calendarVM = CalendarViewModel()
    
    @IBOutlet weak var calendar: FSCalendar!
    
// MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
    }
    
    func setUpCalendar(){
        calendar.allowsMultipleSelection = true
    }
    
    // MARK: - Actions
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        delegate?.showSelectedDates(selectedDates: calendarVM.selectedDates)
        self.dismiss(animated: true, completion: nil)
    }

}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let date = date.convertTo(region: .local).toString(.custom("dd/MM/yyyy"))
        let defaultType = DayoffType.full_day
        calendarVM.selectedDates[date] = defaultType
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let date = date.convertTo(region: .local).toString(.custom("dd/MM/yyyy"))
        calendarVM.selectedDates.removeValue(forKey: date)
        
    }
    
}
