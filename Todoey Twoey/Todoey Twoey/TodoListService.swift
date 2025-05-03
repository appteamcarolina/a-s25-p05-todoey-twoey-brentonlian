//
//  TodoListService.swift
//  Todoey Twoey
//
//  Created by Brenton on 4/15/25.
//

import Foundation

enum TodoListService {
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    static let baseUrl = "https://learning.ryderklein.com/todos"
    
    static func getTodos() async throws -> [Todo] {
        // TODO: Implement. See above for request code
        guard let url = URL(string: baseUrl) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode([Todo].self, from: data)
    }
    
    static func create(newTodo: NewTodo) async throws -> Todo {
        // TODO: Implement
        guard let url = URL(string: baseUrl) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(newTodo)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(Todo.self, from: data)
    }
    
    static func delete(todo: Todo) async throws {
        // TODO: Implement
        guard let url = URL(string: "\(baseUrl)/\(todo.id.uuidString)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        _ = try await URLSession.shared.data(for: request)
    }
    
    static func updateCompletion(for todo: Todo, isCompleted: Bool) async throws {
        // TODO: Implement
        guard let url = URL(string: "\(baseUrl)/\(todo.id.uuidString)/updateCompleted?isCompleted=\(isCompleted)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        _ = try await URLSession.shared.data(for: request)
    }
}
