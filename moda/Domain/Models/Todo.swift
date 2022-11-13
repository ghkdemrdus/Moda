//
//  Todo.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation

struct Todo: Hashable {
  var content: String
  var isDone: Bool
  
  static let `default` = Todo(content: "", isDone: false)
}
