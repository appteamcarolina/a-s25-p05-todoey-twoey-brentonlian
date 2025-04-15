//
//  TodoListService.swift
//  Todoey Twoey
//
//  Created by Brenton on 4/15/25.
//

import Foundation

struct TodoListService {
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    static let baseUrl = "https://learning.appteamcarolina.com/todos"
    
    static func getTodos() async throws -> [Todo] {
            // TODO: Implement. See above for request code
            return []
    }
    
    static func create(newTodo: NewTodo) async throws -> Todo {
            // TODO: Implement
            return Todo(id: .init(), title: "Remove Me", isCompleted: false)
    }
    
    static func delete(todo: Todo) async throws {
            // TODO: Implement
    }
    
    static func updateCompletion(for todo: Todo, isCompleted: Bool) async throws {
            // TODO: Implement
    }
