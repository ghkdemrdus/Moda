//
//  UIColor+Extension.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

import UIKit

extension UIColor {
  static var bg: UIColor { named("Bg") }
  static var dailyDivider: UIColor { named("DailyDivider") }
  static var dailyEmpty: UIColor { named("DailyEmpty") }
  static var followingDay: UIColor { named("FollowingDay") }
  static var followingDayBg: UIColor { named("FollowingDayBg") }
  static var inputBg: UIColor { named("InputBg") }
  static var inputDivider: UIColor { named("InputDivider") }
  static var month: UIColor { named("Month") }
  static var monthlyBg: UIColor { named("MonthlyBg") }
  static var monthlyEmpty: UIColor { named("MonthlyEmpty") }
  static var optionActive: UIColor { named("OptionActive") }
  static var optionBg: UIColor { named("OptionBg") }
  static var optionInactive: UIColor { named("OptionInactive") }
  static var previousDay: UIColor { named("PreviousDay") }
  static var previousDayBg: UIColor { named("PreviousDayBg") }
  static var today: UIColor { named("Today") }
  static var todayBg: UIColor { named("TodayBg") }
  static var todo: UIColor { named("Todo") }
  static var todoTitle: UIColor { named("TodoTitle") }

  private static func named(_ name: String) -> UIColor {
    return UIColor(named: name) ?? .white
  }
}
