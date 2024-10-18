//
//  SettingsView.swift
//  TaskFlow
//
//  Created by Orkhan Gojayev on 10/13/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()
            Toggle("Dark Mode", isOn: .constant(true))
                .padding()
            Button("Sync with Cloud") {
                // Add functionality for syncing with cloud storage here
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
