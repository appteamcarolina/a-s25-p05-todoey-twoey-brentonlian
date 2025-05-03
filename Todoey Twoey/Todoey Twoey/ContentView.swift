import SwiftUI

struct ContentView: View {
    @StateObject private var vm = TodoListViewModel()
    @State private var newTodoTitle: String = ""

    var body: some View {
        NavigationStack {
            List {
                Section(header:
                    Text("Create A Task")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.gray)
                ) {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Walk the dog...", text: $newTodoTitle)
                            .textFieldStyle(.automatic)
                            .onSubmit {
                                Task {
                                    await vm.createTodo(title: newTodoTitle)
                                    newTodoTitle = ""
                                }
                            }
                    }
                    .padding(.vertical, 4)
                }

                // TO-DO section
                Section(header:
                    Text("TO-DO")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.gray)
                ) {
                    todoListSection()
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Todoey")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await vm.fetchTodos()
            }
        }
        .task {
            await vm.fetchTodos()
        }
    }

    @ViewBuilder
    private func todoListSection() -> some View {
        switch vm.state {
        case .idle:
            Text("Make a request")
        case .loading:
            Text("Loading...")
        case .success(let todos):
            if todos.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "checklist.checked")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text("Nothing to do right now!")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 16)
            } else {
                ForEach(todos) { todo in
                    Button {
                        Task {
                            await vm.toggleCompletion(for: todo)
                        }
                    } label: {
                        Label(todo.title, systemImage: todo.isCompleted ? "circle.fill" : "circle")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.primary)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            Task {
                                await vm.delete(todo: todo)
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
        case .error(let message):
            Text("Error: \(message)")
        }
    }
}

#Preview {
    ContentView()
}
