    //
    //  TaskManagerApp.swift
    //  TaskFlow
    //
    //  Created by Orkhan Gojayev on 10/13/24.
    //

import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject private var taskStore = TaskStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskStore)
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "square.grid.2x2")
                }

            KanbanBoardView()
                .tabItem {
                    Label("Kanban", systemImage: "square.grid.3x3")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
