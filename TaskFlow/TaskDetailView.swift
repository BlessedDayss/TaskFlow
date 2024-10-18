//
//  TaskDetailView.swift
//  TaskFlow
//
//  Created by Orkhan Gojayev on 10/13/24.
//

import SwiftUI

struct TaskDetailView: View {
    let task: Task

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(task.title)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.bottom, 5)
                if let dueDate = task.dueDate {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        Text("Due: \(dueDate, formatter: itemFormatter)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(priorityColor(for: task.priority))
                    Text("Priority: \(task.priority.rawValue.capitalized)")
                        .font(.headline)
                        .foregroundColor(priorityColor(for: task.priority))
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Task Details")
    }

    private func priorityColor(for priority: Priority) -> Color {
        switch priority {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .red
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
