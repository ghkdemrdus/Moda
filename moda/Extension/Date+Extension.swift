//
//  Date+Extension.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation

extension Date {
  
  func toKST() -> Date {
    let time = TimeInterval(TimeZone(abbreviation: "KST")!.secondsFromGMT() - TimeZone(abbreviation: "UTC")!.secondsFromGMT())
    return addingTimeInterval(time)
  }
  
  func plain() -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: self)
    return calendar.date(from: components)!.toKST()
  }
  
  func firstDayOfMonth(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!.toKST()
  }
  
  func addDays(_ days: Int) -> Date? {
    let dayComponenet = NSDateComponents()
    dayComponenet.day = days
    let theCalendar = NSCalendar.current
    let nextDate = theCalendar.date(byAdding: dayComponenet as DateComponents, to: self)
    return nextDate
  }
  
  func addMonth(_ month: Int) -> Date? {
    let dayComponenet = NSDateComponents()
    dayComponenet.month = month
    let theCalendar = NSCalendar.current
    let nextDate = theCalendar.date(byAdding: dayComponenet as DateComponents, to: self)
    return nextDate
  }
  
  func toMonthFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M"
    return dateFormatter.string(from: self)
  }
  
  func toDayFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d"
    return dateFormatter.string(from: self)
  }
  
  func toWeedDayFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEEE"
    return dateFormatter.string(from: self)
  }
  
  func toWordOfMonthFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    return dateFormatter.string(from: self)
  }
  
  /// Monthly Todo 를 불러오기 위한 포맷
  func toMonthlyIdFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyMM"
    return dateFormatter.string(from: self)
  }
  
  /// Daily Todo 를 불러오기 위한 포맷
  func toDailyIdFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyMMdd"
    return dateFormatter.string(from: self)
  }
  
  
}
