//
//  DashboardView.swift
//  TaskFlow
//
//  Created by Orkhan Gojayev on 10/13/24.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var taskStore: TaskStore
    @State private var showingAddTask = false
    @State private var searchText: String = ""

    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return taskStore.tasks
        } else {
            return taskStore.tasks.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(filteredTasks) { task in
                        NavigationLink(destination: TaskDetailView(task: task)) {
                            TaskRowView(task: task)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                    .onDelete(perform: deleteTasks)
                }
                .padding()
            }
            .navigationTitle("Task Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddTask = true }) {
                        Label("Add Task", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView()
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }

    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            taskStore.deleteTask(taskStore.tasks[index])
        }
    }
}

struct TaskRowView: View {
    let task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(task.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text(task.priority.rawValue.capitalized)
                    .font(.caption)
                    .padding(8)
                    .background(priorityColor(for: task.priority))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            if let dueDate = task.dueDate {
                Text("Due: \(dueDate, formatter: itemFormatter)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
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
