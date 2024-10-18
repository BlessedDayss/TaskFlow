//
//  AddTaskView.swift
//  TaskFlow
//
//  Created by Orkhan Gojayev on 10/13/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var taskStore: TaskStore
    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: Priority = .medium

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let newTask = Task(title: title, dueDate: dueDate, priority: priority)
                        taskStore.addTask(newTask)
                        dismiss()
                    }
                }
            }
        }
    }
}
