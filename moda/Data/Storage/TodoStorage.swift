//
//  TodoStorage.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import Foundation
import RxSwift
import RealmSwift

final class TodoStorage {
  let realm = try! Realm()
  
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
    let todos = realm.objects(MonthlyTodoInfoEntity.self).filter( "date == '\(currentMonth)'").first
    
    try! realm.write {
      guard let todos = todos else {
        let monthlyEntity = MonthlyTodoInfoEntity()
        monthlyEntity.date = currentMonth
        monthlyEntity.monthlyTodos.append(objectsIn: [todo.toEntity()])
        self.realm.add(monthlyEntity)
        return
      }
      todos.monthlyTodos.append(objectsIn: [todo.toEntity()])
      self.realm.add(todos, update: .modified)
    }
  }
  
  func addDailyTodo(date: Date, todo: Todo) {
    let currentDate = date.toDailyIdFormat()
    let todos = realm.objects(DailyTodoInfoEntity.self).filter( "date == '\(currentDate)'").first
    
    try! realm.write {
      guard let todos = todos else {
        let dailyEntity = DailyTodoInfoEntity()
        dailyEntity.date = currentDate
        dailyEntity.dailyTodos.append(objectsIn: [todo.toEntity()])
        self.realm.add(dailyEntity)
        return
      }
      todos.dailyTodos.append(objectsIn: [todo.toEntity()])
      self.realm.add(todos, update: .modified)
    }
  }
  
  func updateTodo(todo: Todo) {
    let previousTodo = realm.objects(TodoEntity.self).filter( "todoId == '\(todo.id)'").first
    
    guard let previousTodo = previousTodo else { return }
    let updatedTodo = TodoEntity(todoId: todo.id, content: todo.content, isDone: todo.isDone)
    updatedTodo.id = previousTodo.id
    try! self.realm.write {
      self.realm.add(updatedTodo, update: .modified)
    }
  }
  
  func deleteTodo(todo: Todo) {
    let previousTodo = realm.objects(TodoEntity.self).filter( "todoId == '\(todo.id)'").first
    guard let previousTodo = previousTodo else { return }
    try! self.realm.write {
      self.realm.delete(previousTodo)
    }
  }
}
