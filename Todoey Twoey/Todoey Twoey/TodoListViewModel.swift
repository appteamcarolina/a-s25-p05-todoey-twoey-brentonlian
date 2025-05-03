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
        case idle
        case loading
        case success([Todo])
        case error(String)
}

@MainActor
class TodoListViewModel: ObservableObject {
    @Published var state: TodoListLoadingState = .idle
    
    func fetchTodos() async {
        state = .loading
        do {
            let todos = try await TodoListService.getTodos()
            state = .success(todos)
            // TODO: Set state to success
        } catch {
            // TODO: Set state to error
            state = .error("Failed to load todos: \(error.localizedDescription)")
        }
    }

    func createTodo(title: String) async {
                // TODO: Implement createTodo using TodoListService.create() (see fetchTodos)
        guard !title.isEmpty else { return }
                do {
                    _ = try await TodoListService.create(newTodo: NewTodo(title: title))
                    await fetchTodos()
                } catch {
                    state = .error("Failed to create todo: \(error.localizedDescription)")
                }
    }

    func delete(todo: Todo) async {
                // TODO: Implement delete
        do {
                    try await TodoListService.delete(todo: todo)
                    await fetchTodos()
                } catch {
                    state = .error("Failed to delete todo: \(error.localizedDescription)")
                }
    }

    func toggleCompletion(for todo: Todo) async {
                // TODO: Implement toggleCompletion
        do {
                    try await TodoListService.updateCompletion(for: todo, isCompleted: !todo.isCompleted)
                    await fetchTodos() // Refresh list after update
                } catch {
                    state = .error("Failed to update completion: \(error.localizedDescription)")
                }
            }
    }

