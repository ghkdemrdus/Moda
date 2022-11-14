////
////  TodoStorage.swift
////  moda
////
////  Created by 황득연 on 2022/11/13.
////
//
//import Foundation
//import RxSwift
////import RealmSwift
//
//final class TodoStorage {
//  let realm = try! Realm()
//  let disposeBag = DisposeBag()
//  
//  func fetchMonthlyTodos(date: Date) -> Observable<[Todo]?> {
//    let currentDate = date.getCurrentMonth()
//    let todos = realm.objects(MonthlyTodoInfoEntity.self).filter( "date == '\(currentDate)'").map { $0.asDomain() }.first
//
//    return Observable.create { observer in
//      observer.onNext(todos)
//      return Disposables.create()
//    }
//  }
//
//  func fetchDailyTodos(date: Date) -> Observable<[Todo]?> {
//    let currentDate = date.getCurrentDate()
//    let todoInfo = realm.objects(DailyTodoInfoEntity.self).filter( "date == '\(currentDate)'").map { $0.asDomain() }.first
//
//    return Observable.create { observer in
//      observer.onNext(todoInfo)
//      return Disposables.create()
//    }
//  }
//
//  func addMonthlyTodo(date: Date, todo: Todo) {
//    let currentMonth = date.getCurrentMonth()
//    let todos = realm.objects(MonthlyTodoInfoEntity.self).filter( "date == '\(currentMonth)'").first
//
//    try! realm.write {
//      guard let todos = todos else {
//        let monthlyEntity = MonthlyTodoInfoEntity()
//        monthlyEntity.date = currentMonth
//        monthlyEntity.monthlyTodos.append(objectsIn: [todo.toEntity()])
//        self.realm.add(monthlyEntity)
//        return
//      }
//      todos.monthlyTodos.append(objectsIn: [todo.toEntity()])
//      self.realm.add(todos, update: .modified)
//    }
//  }
//
//  func addDailyTodo(date: Date, todo: Todo) {
//    let currentDate = date.getCurrentDate()
//    let todos = realm.objects(DailyTodoInfoEntity.self).filter( "date == '\(currentDate)'").first
//
//    try! realm.write {
//      guard let todos = todos else {
//        let dailyEntity = DailyTodoInfoEntity()
//        dailyEntity.date = currentDate
//        dailyEntity.dailyTodos.append(objectsIn: [todo.toEntity()])
//        self.realm.add(dailyEntity)
//        return
//      }
//      todos.dailyTodos.append(objectsIn: [todo.toEntity()])
//      self.realm.add(todos, update: .modified)
//    }
//  }
//
//
//  //    print("Log: \(todoInfo)")
//  //    Observable.collection(from: todoInfo)
//  //      .map { $0 }
//  //      .subscribe { todoInfo in
//  //        Log(todoInfo.count)
//  //      }
//  //      .disposed(by: disposeBag)
//  //
//  //    return Observable.create { observer in
//  //
//  //    }
//
//  //    return todoInfo
//  //    return todoInfo
//  //    return Observable.create { observer in
//  //      observer.onNext(todosMapped)
//  //      observer.onCompleted()
//  //    }
//  //  }
//  //
//  //  func addTodoInfo(date: Date, monthlyTodos: [Todo], dailyTodos: [Todo]) {
//  //    let rm = RMTodos()
//  //    rm.date = date.getToday()
//  //    rm.monthlyTodos.append(objectsIn: monthlyTodos.map { RMTodo(id: $0.id, content: $0.content, isDone: $0.isDone)})
//  //    rm.dailyTodos.append(objectsIn: dailyTodos.map { RMTodo(id: $0.id, content: $0.content, isDone: $0.isDone)})
//  //    print(rm)
//  //    print(rm.monthlyTodos)
//  //    try! realm.write{
//  //      realm.add(rm)
//  //
//  //    }
//  //  }
//
//  func deleteTodoInfo() {
//    //    let a = fetchTodoInfo(date: Date())
//    //    try! realm.write {
//    //      realm.delete(a)
//    //    }
//  }
//}
