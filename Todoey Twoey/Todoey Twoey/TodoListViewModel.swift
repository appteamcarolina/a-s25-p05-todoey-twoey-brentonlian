//
//  TodoListViewModel.swift
//  Todoey Twoey
//
//  Created by Brenton on 4/15/25.
//

import Foundation

enum TodoListLoadingState {
        // TODO: Implement TodoListLoadingState
        // with success, error, loading, and idle states
}

@MainActor
class TodoListViewModel: ObservableObject {
    @Published var state: TodoListLoadingState = .idle
    
    func fetchTodos() async {
        do {
            let todos = try await TodoListService.getTodos()
            // TODO: Set state to success
        } catch {
            // TODO: Set state to error
        }
    }

    func createTodo(title: String) async {
                // TODO: Implement createTodo using TodoListService.create() (see fetchTodos)
    }

    func delete(todo: Todo) async {
                // TODO: Implement delete
    }

    func toggleCompletion(for todo: Todo) async {
                // TODO: Implement toggleCompletion
    }
}
