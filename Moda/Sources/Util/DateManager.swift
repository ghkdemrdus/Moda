//
//  DateManager.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

import Foundation

struct DateManager {
  
  let wordOfMonth = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  
  func getPreviousMonth(from date: Date) -> Int {
    if date.toMonthFormat() == "1" { return 12 }
    return Int(date.toMonthFormat())! - 1
  }
  
  func getPreviousDates(from date: Date) -> [DateItem] {
    let previousMonth = date.addMonth(-1)!
    return getDates(from: previousMonth)
  }
  
  func getFollowingDates(from date: Date) -> [DateItem] {
    let followingMonth = date.addMonth(1)!
    return getDates(from: followingMonth)
  }
  
  func getDates(from date: Date = Date()) -> [DateItem] {
    let startDate = Date().firstDayOfMonth(date: date)
    let endDate = Date().firstDayOfMonth(date: date).addMonth(1)!
    let today = Date().plain()
    
    var dates: [DateItem] = []
    var tmpDate = startDate
    
    while tmpDate < endDate {
      if tmpDate == today {
        dates.append(DateItem(date: tmpDate, isCurrent: true, isPrevious: false, isSelected: true))
      } else if tmpDate < today {
        dates.append(DateItem(date: tmpDate, isCurrent: false, isPrevious: true, isSelected: false))
      } else {
        dates.append(DateItem(date: tmpDate, isCurrent: false, isPrevious: false, isSelected: false))
      }
      tmpDate = tmpDate.addDays(1)!
    }
    return dates
  }
  
  func getUniqueId() -> String {
    return Date().toDailyIdFormat() + String(Int(Date().timeIntervalSince1970 * 10) % 100000 )
  }
}
