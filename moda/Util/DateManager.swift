//
//  DateManager.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

import Foundation

struct DateManager {
  func initialDates() -> [DateItem] {
    var dates: [DateItem] = []
    let startDate = Date().firstDayOfMonth()
    let endDate = Date().firstDayOfMonth().addMonth(1)!
    let currentDate = Date().today()
    var tmpDate = startDate
    
    while tmpDate < endDate {
      if tmpDate == currentDate {
        dates.append(DateItem(date: tmpDate, isCurrent: true, isPrevious: false, isSelected: true))
      } else if tmpDate < currentDate {
        dates.append(DateItem(date: tmpDate, isCurrent: false, isPrevious: true, isSelected: false))
      } else {
        dates.append(DateItem(date: tmpDate, isCurrent: false, isPrevious: false, isSelected: false))
      }
      tmpDate = tmpDate.addDays(1)!
    }
    return dates
  }
}
