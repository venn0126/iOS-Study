import SwiftUI

struct GTContentView: View {
    @StateObject private var taskManager = GTTaskManager()
    @State private var showingAddTask = false
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.tasks) { task in
                    GTTaskRow(task: task, onToggle: {
                        taskManager.toggleTask(task)
                    })
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        taskManager.deleteTask(taskManager.tasks[index])
                    }
                }
            }
            .navigationTitle("待办事项")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                GTAddTaskView(taskManager: taskManager, isPresented: $showingAddTask)
            }
        }
    }
}

struct GTTaskRow: View {
    let task: GTTask
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .green : .gray)
                .onTapGesture(perform: onToggle)
            
            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .gray : .primary)
        }
    }
}

#Preview {
    GTContentView()
} 