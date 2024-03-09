//
//  DateItem.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation

struct DateItem {
  let date: Date
  let isCurrent: Bool
  let isPrevious: Bool
  var isSelected: Bool
  
  static let `default` = DateItem(date: Date(), isCurrent: false, isPrevious: false, isSelected: false)
}
