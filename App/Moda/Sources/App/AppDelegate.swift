//
//  AppDelegate.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import FirebaseCore
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    if let filename = Bundle.main.googleServiceFileName,
        let path = Bundle.main.path(forResource: filename, ofType: "plist"),
        let fileopts = FirebaseOptions(contentsOfFile: path) {
      FirebaseApp.configure(options: fileopts)
    }
    return true
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    return true
  }

  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    return true
  }
}
