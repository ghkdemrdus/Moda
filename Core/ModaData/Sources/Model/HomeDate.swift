//
//  HomeDate.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import SwiftUI

public struct HomeDate {
  public enum Timeline {
    case previous
    case current
    case following
  }

  public let date: Date
  public let timeline: Timeline
  public let hasTodo: Bool

  public init(date: Date, timeline: Timeline, hasTodo: Bool) {
    self.date = date
    self.timeline = timeline
    self.hasTodo = hasTodo
  }
}
