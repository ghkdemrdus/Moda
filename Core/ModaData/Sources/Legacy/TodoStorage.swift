//
//  TodoStorage.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import Foundation
import RealmSwift
import WidgetKit

public final class TodoStorage {
  public static let shared: TodoStorage = .init()
  private let realm: Realm

  private init() {
    let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.pinto.moda")?.appendingPathComponent("todo.realm")
    let config = Realm.Configuration(fileURL: path, schemaVersion: 2)

    self.realm = try! Realm(configuration: config)
  }

  public func fetchMonthlyTodos() -> [MonthlyTodosEntity] {
    return Array(realm.objects(MonthlyTodosEntity.self))
  }

  public func fetchDailyTodos() -> [DailyTodosEntity] {
    return Array(realm.objects(DailyTodosEntity.self))
  }
}
