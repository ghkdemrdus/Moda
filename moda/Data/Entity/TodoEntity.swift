////
////  TodoEntity.swift
////  moda
////
////  Created by 황득연 on 2022/11/14.
////
//
////import RealmSwift
//
//class TodoEntity: Object {
//  @Persisted var id: String
//  @Persisted var content: String
//  @Persisted var isDone: Bool
//  
//  convenience init(id: String, content: String, isDone: Bool) {
//    self.init()
//    
//    self.id = id
//    self.content = content
//    self.isDone = isDone
//  }
//}
//
//extension TodoEntity {
//  func asDomain() -> Todo {
//    return Todo(
//      id: id,
//      content: content,
//      isDone: isDone
//    )
//  }
//}
//
