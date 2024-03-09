//
//  TodoStorage.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import Foundation
import RxSwift
import RealmSwift
import WidgetKit

final class TodoStorage {
  static let shared: TodoStorage = .init()
  let realm: Realm

  private init() {
    let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.pinto.moda")?.appendingPathComponent("todo.realm")
    let config = Realm.Configuration(fileURL: path, schemaVersion: 2)

    self.realm = try! Realm(configuration: config)
//    migration()
  }

  private func migration() {
    let oldRealm = try! Realm()
    let dailyTodos = oldRealm.objects(DailyTodoInfoEntity.self)
    let monthlyTodos = oldRealm.objects(MonthlyTodoInfoEntity.self)

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
  }

  func fetchMonthlyTodos(date: Date) -> Observable<[Todo]?> {
    let currentDate = date.toMonthlyIdFormat()
    let todos = realm.objects(MonthlyTodoInfoEntity.self).filter( "date == '\(currentDate)'").map { $0.asDomain() }.first
    
    return Observable.create { observer in
      observer.onNext(todos)
      return Disposables.create()
    }
  }

  func fetchDailyTodos(date: Date) -> Observable<[Todo]?> {
    let currentDate = date.toDailyIdFormat()
    let todoInfo = realm.objects(DailyTodoInfoEntity.self).filter( "date == '\(currentDate)'").map { $0.asDomain() }.first
    
    return Observable.create { observer in
      observer.onNext(todoInfo)
      return Disposables.create()
    }
  }
  
  func addMonthlyTodo(date: Date, todo: Todo) {
    let currentMonth = date.toMonthlyIdFormat()
    self.addMonthlyTodo(date: currentMonth, todo: todo)
  }

  func addMonthlyTodo(date: String, todo: Todo) {
    let todos = realm.objects(MonthlyTodoInfoEntity.self).filter( "date == '\(date)'").first

    try! realm.write {
      guard let todos = todos else {
        let monthlyEntity = MonthlyTodoInfoEntity()
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

  func addDailyTodo(date: String, todo: Todo) {
    let todos = realm.objects(DailyTodoInfoEntity.self).filter( "date == '\(date)'").first

    try! realm.write {
      guard let todos = todos else {
        let dailyEntity = DailyTodoInfoEntity()
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

  func addDailyTodo(date: Date, todo: Todo) {
    let currentDate = date.toDailyIdFormat()
    self.addDailyTodo(date: currentDate, todo: todo)
  }
  
  func updateTodo(todo: Todo) {
    let previousTodo = realm.objects(TodoEntity.self).filter( "todoId == '\(todo.id)'").first
    
    guard let previousTodo = previousTodo else { return }
    let updatedTodo = TodoEntity(todoId: todo.id, content: todo.content, isDone: todo.isDone)
    updatedTodo.id = previousTodo.id
    try! self.realm.write {
      self.realm.add(updatedTodo, update: .modified)
      WidgetCenter.shared.reloadAllTimelines()
    }
  }
  
  func deleteTodo(todo: Todo) {
    let previousTodo = realm.objects(TodoEntity.self).filter( "todoId == '\(todo.id)'").first
    guard let previousTodo = previousTodo else { return }
    try! self.realm.write {
      self.realm.delete(previousTodo)
      WidgetCenter.shared.reloadAllTimelines()
    }
  }

  func fetchDailyTodosForWidget(date: Date) -> [Todo] {
    let currentDate = date.toDailyIdFormat()
    let todos = realm.objects(DailyTodoInfoEntity.self).filter( "date == '\(currentDate)'").map { $0.asDomain() }.first
    return todos ?? []
  }

  func fetchMonthlyTodosForWidget(date: Date) -> [Todo] {
    let currentDate = date.toMonthlyIdFormat()
    let todos = realm.objects(MonthlyTodoInfoEntity.self).filter( "date == '\(currentDate)'").map { $0.asDomain() }.first
    return todos ?? []
  }
}
