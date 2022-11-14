//
//  Date+Extension.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation

extension Date {
  func today() -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: Date())
    return calendar.date(from: components)!
  }
  
  func plain(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return calendar.date(from: components)!
  }
  
  func firstDayOfMonth(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!
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
  
  func getWeedDay() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEEE"
    return dateFormatter.string(from: self)
  }
  
  func getDay() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d"
    return dateFormatter.string(from: self)
  }
  
  func getMonth() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M"
    return dateFormatter.string(from: self)
  }
  
  func getWordOfMonth() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    return dateFormatter.string(from: self)
  }
  
  /// Monthly Todo 를 불러오기 위한 포맷
  func getCurrentMonth() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yy-MM"
    return dateFormatter.string(from: self)
  }
  
  /// Daily Todo 를 불러오기 위한 포맷
  func getCurrentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yy-MM-dd"
    return dateFormatter.string(from: self)
  }
  
  
}
