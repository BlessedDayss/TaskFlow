//
//  Models.swift
//  TaskFlow
//
//  Created by Orkhan Gojayev on 10/13/24.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var details: String?
    var dueDate: Date?
    var priority: Priority
    var status: Status
    var tags: [String]
    var assignedTo: String?
    var subtasks: [Subtask]

    init(id: UUID = UUID(), title: String, details: String? = nil, dueDate: Date? = nil, priority: Priority = .medium, status: Status = .todo, tags: [String] = [], assignedTo: String? = nil, subtasks: [Subtask] = []) {
        self.id = id
        self.title = title
        self.details = details
        self.dueDate = dueDate
        self.priority = priority
        self.status = status
        self.tags = tags
        self.assignedTo = assignedTo
        self.subtasks = subtasks
    }
}

struct Subtask: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

enum Priority: String, Codable, CaseIterable {
    case low, medium, high
}

enum Status: String, Codable, CaseIterable {
    case todo = "To Do"
    case inProgress = "In Progress"
    case done = "Done"
}

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = []

    init() {
        loadTasks()
    }

    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }

    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }

    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }

    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }

    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        }
    }
}
