//
//  HomeDate.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation

public struct HomeDate: Hashable {
  public enum Timeline {
    case previous
    case current
    case following
  }

  public var date: Date
  public let timeline: Timeline
  public let hasTodo: Bool

  public init(date: Date, timeline: Timeline, hasTodo: Bool) {
    self.date = date
    self.timeline = timeline
    self.hasTodo = hasTodo
  }
}
