//
//  Reactive+Extension.swift
//  moda
//
//  Created by 황득연 on 2023/06/16.
//

import RxSwift
import RxCocoa
import UIKit
import FirebaseAnalytics

enum TouchEvent: String {
  case click_day
  case click_daily_option
  case click_monthly_option
  case click_next_month
  case click_previous_month
  case delete_daily
  case delete_monthly
  case do_daily
  case do_monthly
  case fix_daily
  case fix_monthly
  case register_daily
  case register_monthly
  case select_daily_type
  case select_monthly_type
  case show_several_monthly
  case show_all_monthly
  case undo_daily
  case undo_monthly
}

final class EventLogger {
  static let shared = EventLogger()
  
  private init() {}
  
  func log(_ event: TouchEvent) {
    Analytics.logEvent(event.rawValue, parameters: [:])
  }
  
  func logTodos(month: Int, day: Int, numberOfMonthly: Int, dailyOfMonthly: Int) {
    var param = [String: Int]()
    param["month"] = month
    param["numberOfMonthly"] = numberOfMonthly
    param["day"] = day
    param["dailyOfMonthly"] = dailyOfMonthly
    Analytics.logEvent("todos", parameters: param)
  }
}
