//
//  ATPLTesterApp.swift
//  ATPLTester
//
//  Created by ali cihan on 15.04.2025.
//

import SwiftUI
import SwiftData

@main
struct ATPLTesterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Question.self, Exam.self])
    }
}
