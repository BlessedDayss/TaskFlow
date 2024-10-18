//
//  TaskStore.swift
//  TaskFlow
//
//  Created by Orkhan Gojayev on 10/13/24.
//

import Foundation

class TaskDataStore: ObservableObject {
    @Published var tasks: [TaskModel] = []

    func addTask(_ task: TaskModel) {
        tasks.append(task)
    }

    func deleteTask(_ task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
}


struct TaskModel: Identifiable {
    let id = UUID()
    let title: String
    let dueDate: Date?
}
