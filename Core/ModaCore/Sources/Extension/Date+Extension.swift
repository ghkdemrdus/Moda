//
//  Date+Extension.swift
//  moda
//
//  Created by 황득연 on 4/2/24.
//

import Foundation

public extension Date {
  var year: Int {
    Calendar.current.component(.year, from: self)
  }

  var month: Int {
    Calendar.current.component(.month, from: self)
  }

  var day: Int {
    Calendar.current.component(.day, from: self)
  }

  var firstDayOfMonth: Date {
    let components = Calendar.current.dateComponents([.year, .month], from: self)
    return Calendar.current.date(from: components)!
  }

  func addDays(_ count: Int) -> Date {
    Calendar.current.date(byAdding: .day, value: count, to: self)!
  }

  func addMonth(_ count: Int) -> Date {
    Calendar.current.date(byAdding: .month, value: count, to: self)!
  }

  func addYear(_ count: Int) -> Date {
    Calendar.current.date(byAdding: .year, value: count, to: self)!
  }

  static var today: Date {
    let components = Calendar.current.dateComponents([.year, .month, .day], from: .now)
    return Calendar.current.date(from: components)!
  }
}

extension Date {
  static func == (ld: Date, rd: Date) -> Bool {
    ld.year == rd.year && ld.month == rd.month && ld.day == rd.day
  }
}
