//
//  TodoStorage.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import Foundation
import RealmSwift
import WidgetKit
//import ModaCore

public final class TodoStorage {
  public static let shared: TodoStorage = .init()
  let realm: Realm

  private init() {
    let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.pinto.moda")?.appendingPathComponent("todo.realm")
    let config = Realm.Configuration(fileURL: path, schemaVersion: 2)

    self.realm = try! Realm(configuration: config)
    migrationIfNeeded()
  }

  private func migrationIfNeeded() {
    let didMigrate = UserDefaults.standard.bool(forKey: "didMigrate")
    guard !didMigrate else { return }

    let oldRealm = try! Realm()
    let dailyTodos = oldRealm.objects(DailyTodosEntity.self)
    let monthlyTodos = oldRealm.objects(MonthlyTodosEntity.self)

    for dailyTodo in dailyTodos {
      let date = dailyTodo.date
      for todo in dailyTodo.asDomain() {
        self.addDailyTodo(date: date, todo: todo)
      }
    }

    for monthlyTodo in monthlyTodos {
      let date = monthlyTodo.date
      for todo in monthlyTodo.asDomain() {
        self.addMonthlyTodo(date: date, todo: todo)
      }
    }

    UserDefaults.standard.set(true, forKey: "didMigrate")
  }

  public func fetchMonthlyTodos(date: Date) -> [Todo] {
    let currentDate = date.format(.monthlyId)
    let todos = realm.objects(MonthlyTodosEntity.self).filter("date == '\(currentDate)'").map { $0.asDomain() }.first
    return todos ?? []
  }

  public func fetchDailyTodos(date: Date) -> [Todo] {
    let currentDate = date.format(.dailyId)
    let todos = realm.objects(DailyTodosEntity.self).filter("date == '\(currentDate)'").map { $0.asDomain() }.first
    return todos ?? []
  }
  
  public func addMonthlyTodo(date: Date, todo: Todo) {
    let currentMonth = date.format(.monthlyId)
    self.addMonthlyTodo(date: currentMonth, todo: todo)
  }

  public func addMonthlyTodo(date: String, todo: Todo) {
    let todos = realm.objects(MonthlyTodosEntity.self).filter( "date == '\(date)'").first

    try! realm.write {
      guard let todos = todos else {
        let monthlyEntity = MonthlyTodosEntity()
        monthlyEntity.date = date
        monthlyEntity.monthlyTodos.append(objectsIn: [todo.toEntity()])
        self.realm.add(monthlyEntity)
        return
      }
      todos.monthlyTodos.append(objectsIn: [todo.toEntity()])
      self.realm.add(todos, update: .modified)
      WidgetCenter.shared.reloadAllTimelines()
    }
  }

  public func addDailyTodo(date: String, todo: Todo) {
    let todos = realm.objects(DailyTodosEntity.self).filter( "date == '\(date)'").first

    try! realm.write {
      guard let todos = todos else {
        let dailyEntity = DailyTodosEntity()
        dailyEntity.date = date
        dailyEntity.dailyTodos.append(objectsIn: [todo.toEntity()])
        self.realm.add(dailyEntity)
        return
      }
      todos.dailyTodos.append(objectsIn: [todo.toEntity()])
      self.realm.add(todos, update: .modified)
      WidgetCenter.shared.reloadAllTimelines()
    }
  }

  public func addDailyTodo(date: Date, todo: Todo) {
    let currentDate = date.format(.dailyId)
    self.addDailyTodo(date: currentDate, todo: todo)
  }
  
  public func updateTodo(todo: Todo) {
    let previousTodo = realm.objects(TodoEntity.self).filter( "todoId == '\(todo.id)'").first
    
    guard let previousTodo = previousTodo else { return }
    let updatedTodo = TodoEntity(todoId: todo.id, content: todo.content, isDone: todo.isDone)
    updatedTodo.id = previousTodo.id
    try! self.realm.write {
      self.realm.add(updatedTodo, update: .modified)
      WidgetCenter.shared.reloadAllTimelines()
    }
  }
  
  public func deleteTodo(todo: Todo) {
    let previousTodo = realm.objects(TodoEntity.self).filter( "todoId == '\(todo.id)'").first
    guard let previousTodo = previousTodo else { return }
    try! self.realm.write {
      self.realm.delete(previousTodo)
      WidgetCenter.shared.reloadAllTimelines()
    }
  }
}
