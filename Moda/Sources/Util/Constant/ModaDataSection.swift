//
//  ModaDataSection.swift
//  moda
//
//  Created by 황득연 on 2022/11/12.
//

import RxDataSources

struct TodoDataSection {
  typealias Model = AnimatableSectionModel<TodoSection, TodoItem>
  
  enum TodoSection: Int, Hashable, IdentifiableType {
    var identity: Int {
      hashValue
    }
    
    case monthly = 0
    case daily = 1
  }
  
  enum TodoItem: Hashable, IdentifiableType {
    
    var identity: String {
      switch self {
      case .monthly(let todo):
        return todo.id
      case .daily(let todo):
        return todo.id
      case .monthlyEmpty:
        return "monthlyEmpty"
      case .dailyEmpty:
        return "dailyEmpty"
      }
    }
    
    case monthly(Todo)
    case daily(Todo)
    case monthlyEmpty
    case dailyEmpty
  }
  
  static var initialSectionDatas: [TodoDataSection.Model] {
    return [
      TodoDataSection.Model(model: TodoSection.monthly, items: [TodoItem.monthlyEmpty]),
      TodoDataSection.Model(model: TodoSection.daily, items: [TodoItem.dailyEmpty])
    ]
  }
}
