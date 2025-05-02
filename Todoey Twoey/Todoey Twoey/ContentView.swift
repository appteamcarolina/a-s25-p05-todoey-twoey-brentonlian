import SwiftUI

struct ContentView: View {
    @StateObject private var vm = TodoListViewModel()
    @State private var newTodoTitle: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                // CREATE A TASK section
                VStack(alignment: .leading, spacing: 8) {
                    Text("CREATE A TASK")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.gray)
                    
                    TextField("Title", text: $newTodoTitle)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            Task {
                                await vm.createTodo(title: newTodoTitle)
                                newTodoTitle = ""
                            }
                        }
                }
                .padding(.vertical, 4)
                
                // TO-DO Header
                Text("TO-DO")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.top)

                // TO-DO List Items
                todoListSection()
            }
            .listStyle(.plain)
            .navigationTitle("Todoey")
            .navigationBarTitleDisplayMode(.inline)
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
            ForEach(todos) { todo in
                Button {
                    Task {
                        await vm.toggleCompletion(for: todo)
                    }
                } label: {
                    Label(todo.title, systemImage: todo.completed ? "circle.fill" : "circle")
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
        case .error(let message):
            Text("Error: \(message)")
        }
    }
}

#Preview{
    ContentView()
}
