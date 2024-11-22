import SwiftUI

struct GTAddTaskView: View {
    @ObservedObject var taskManager: GTTaskManager
    @Binding var isPresented: Bool
    @State private var taskTitle = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("任务标题", text: $taskTitle)
            }
            .navigationTitle("新建任务")
            .navigationBarItems(
                leading: Button("取消") {
                    isPresented = false
                },
                trailing: Button("保存") {
                    if !taskTitle.isEmpty {
                        taskManager.addTask(taskTitle)
                        isPresented = false
                    }
                }
            )
        }
    }
} 