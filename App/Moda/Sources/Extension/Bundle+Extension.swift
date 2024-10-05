//
//  Bundle+Extension.swift
//  Moda
//
//  Created by 황득연 on 10/4/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation

extension Bundle {
  var version: String {
    return infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
  }
}
