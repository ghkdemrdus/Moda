//
//  Todo.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation
import RxDataSources

struct Todo: Hashable {
  
  let id: String
  let content: String
  let isDone: Bool
  
  static let `default` = Todo(id: "", content: "", isDone: false)
}
