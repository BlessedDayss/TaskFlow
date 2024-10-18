//
//  KanbanBoardView.swift
//  TaskFlow
//
//  Created by Orkhan Gojayev on 10/13/24.
//
import SwiftUI

struct KanbanBoardView: View {
    @EnvironmentObject var taskStore: TaskStore
    let columns = Status.allCases

    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    ForEach(columns, id: \.self) { column in
                        KanbanColumnView(status: column)
                    }
                }
                .padding()
            }
            .navigationTitle("Board")
        }
    }
}

struct KanbanColumnView: View {
    @EnvironmentObject var taskStore: TaskStore
    let status: Status

    var tasks: [Task] {
        taskStore.tasks.filter { $0.status == status }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(status.rawValue)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 8)

            ForEach(tasks) { task in
                TaskCardView(task: task)
            }
        }
        .frame(width: 280)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct TaskCardView: View {
    let task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(task.title)
                .font(.headline)
            if let dueDate = task.dueDate {
                Text("Due: \(dueDate, formatter: itemFormatter)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Text(task.priority.rawValue.capitalized)
                .font(.caption)
                .padding(8)
                .background(priorityColor(for: task.priority))
                .cornerRadius(8)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
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
