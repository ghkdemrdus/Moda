//
//  Todo.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation

struct TodoItem {
  var content: String
  var isDone: Bool
  
  static let `default` = TodoItem(content: "", isDone: false)
}
