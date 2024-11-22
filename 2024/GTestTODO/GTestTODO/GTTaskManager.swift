import Foundation

class GTTaskManager: ObservableObject {
    @Published var tasks: [GTTask] = []
    private let tasksKey = "tasks"
    
    init() {
        loadTasks()
    }
    
    func addTask(_ title: String) {
        let task = GTTask(title: title)
        tasks.append(task)
        saveTasks()
    }
    
    func toggleTask(_ task: GTTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }
    
    func deleteTask(_ task: GTTask) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let decoded = try? JSONDecoder().decode([GTTask].self, from: data) {
            tasks = decoded
        }
    }
} 