//
//  DateManager.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

import Foundation

struct DateManager {
  static let shared = DateManager()

  private init() {}

//  func getPreviousMonth(from date: Date) -> Int {
//    if date.toMonthFormat() == "1" { return 12 }
//    return Int(date.toMonthFormat())! - 1
//  }
//  
//  func getPreviousDates(from date: Date) -> [DateItem] {
//    let previousMonth = date.addMonth(-1)!
//    return getDates(from: previousMonth)
//  }
//  
//  func getFollowingDates(from date: Date) -> [DateItem] {
//    let followingMonth = date.addMonth(1)!
//    return getDates(from: followingMonth)
//  }
//  
  func homeDatas(from date: Date) -> [HomeDate] {
    let startDate = date.firstDayOfMonth
    let endDate = date.firstDayOfMonth.addMonth(1)
    let today = Date.today

    var dates: [HomeDate] = []
    var date = startDate

    while date < endDate {
      if date == today {
        dates.append(HomeDate(date: date, timeline: .current, hasTodo: false))
      } else if date < today {
        dates.append(HomeDate(date: date, timeline: .previous, hasTodo: false))
      } else {
        dates.append(HomeDate(date: date, timeline: .following, hasTodo: false))
      }
      date = date.addDays(1)
    }
    return dates
  }
  
  var getUniqueId: String {
    return Date.today.format(.dailyId) + String(Int(Date().timeIntervalSince1970 * 10) % 100000 )
  }
}
