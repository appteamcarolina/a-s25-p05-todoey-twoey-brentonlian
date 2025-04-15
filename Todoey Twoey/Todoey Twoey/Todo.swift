//
//  Todo.swift
//  Todoey Twoey
//
//  Created by Brenton on 4/10/25.
//

import Foundation

struct NewTodo: Codable {
    let title: String
}

struct Todo: Identifiable, Codable {
    let id: UUID
    let title: String
    var isCompleted: Bool
}
