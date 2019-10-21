//
//  HomeViewModel.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 20/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HomeViewModelDelegate {
    func updateDaysOffAndTheRemaining(daysOff: Double, availableDays: Double)
}

class HomeViewModel {
    
    var delegate: HomeViewModelDelegate?
    
// MARK: - Values
    
    var userFullName = "นาย กลทีป์ พยุหวรรธนะ"
    
    let maxDaysOff = 10.0
    
    var daysOff: [String: DayoffType] = [:] {
        didSet {
            delegate?.updateDaysOffAndTheRemaining(daysOff: numberOfDayOffs, availableDays: availableDays)
        }
    }
    var numberOfDayOffs: Double {
        return calculateDays(daysOff)
    }
    
    var selectedDates: [String: DayoffType] = [:]
    var numberOfSelectedDays: Double { calculateDays(selectedDates) }
    
    var selectedDatesString: String {
        var totalDates = ""
        let lastDate = Array(selectedDates.keys).last
        
        for (date, _) in selectedDates {
            totalDates += "\(date)"
            totalDates += (date != lastDate) ? ", " : ""
        }
        return totalDates
    }
    
    var availableDays: Double {
        return maxDaysOff - numberOfDayOffs
    }
    
// MARK: - Functions
    
    func calculateDays(_ dates: [String: DayoffType]) -> Double {
        var totalDays = 0.0
        for type in dates.values {
            switch type {
            case .full_day:
                totalDays += 1.0
            case .half_day:
                totalDays += 0.5
            }
        }
        return totalDays
    }
    
    func canAddMoreDaysOff() -> Bool {
        if availableDays < numberOfSelectedDays { return false }
        return true
    }
    
    func confirmAdding() {
        // selectedDays => daysOff
        daysOff = daysOff.merging(selectedDates, uniquingKeysWith: { (current, _) in current })
        selectedDates.removeAll()
    }

// MARK: - Networking

    func sendDaysOffRequest() -> JSON {
        let user = ["name" : userFullName]
        var detail = [[String : String]]()
        
        for (date, type) in daysOff {
            let eachDay: [String : String] = ["date" : date,
                                             "type" : type.rawValue]
            detail.append(eachDay)
        }
        
        let json: JSON = ["name" : user, "request_leave" : detail]
        
        return json
    }
}

