//
//  CalendarViewModel.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 20/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import Foundation

enum DayoffType: String {
    case full_day
    case half_day
}

class CalendarViewModel {
    
    var selectedDates: [String: DayoffType] = [:]
    var daysOff: [String: DayoffType] = [:]
}
