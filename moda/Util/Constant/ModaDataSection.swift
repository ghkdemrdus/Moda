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
    
    var identity: Int {
      hashValue
    }
    
    case monthly(Todo)
    case daily(Todo)
  }
  
  static var initialSectionDatas: [TodoDataSection.Model] {
    return [
      TodoDataSection.Model(model: TodoSection.monthly, items: []),
      TodoDataSection.Model(model: TodoSection.daily, items: [])
    ]
  }
}
