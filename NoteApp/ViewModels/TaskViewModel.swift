//
//
//  Created by Maximar Yepez on 12/4/24.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    private let notesKey = "notes_key"

    init() {
        loadTasks()
    }

    // Add a new task
    func addTask(title: String, content: String) {
        let newTask = Task(title: title, content: content)
        tasks.append(newTask)
        saveTask()
    }

    // Delete task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTask()
    }

    // Update task
    func updateTasks(task: Task, title: String, content: String) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].title = title
            tasks[index].content = content
            saveTask()
        }
    }
    
    // Mark as completed
    func completeTasks(task: Task, title: String, content: String) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
            tasks[index].content = content +  tasks[index].content
            saveTask()
        }
    }

    // MARK: - Data Persistence using UserDefaults

    // Save task to UserDefaults
    private func saveTask() {
        do {
            let encodedData = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(encodedData, forKey: notesKey)
        } catch {
            print("Error encoding tasks: \(error)")
        }
    }

    // Load tasks from UserDefaults
    private func loadTasks() {
        if let savedData = UserDefaults.standard.data(forKey: notesKey) {
            do {
                tasks = try JSONDecoder().decode([Task].self, from: savedData)
            } catch {
                print("Error decoding tasks: \(error)")
                tasks = []
            }
        }
    }
}
