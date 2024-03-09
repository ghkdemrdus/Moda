//
//  ModaWidgetBundle.swift
//  widget
//
//  Created by 황득연 on 2/27/24.
//

import WidgetKit
import SwiftUI

@main
struct ModaWidgetBundle: WidgetBundle {
  var body: some Widget {
    ModaTodoWidget()
    ModaDailyWidget()
    ModaMonthlyWidget()
  }
}
