//
//  ContentView.swift
//  ATPLTester
//
//  Created by ali cihan on 15.04.2025.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) var modelContext
    @State private var vm: MainViewModel?
    let columns = [
           GridItem(.flexible())
       ]
    
    var body: some View {
        NavigationStack {
            ScrollView{
            if let vm = vm {
                if vm.isLoading {
                    ProgressView()
                } else {
                    lessonList
                }
            }
        }}
        .navigationTitle("Choose")
        .onAppear {
            if vm == nil {
                vm = MainViewModel(context: modelContext)
            }
        }
    }
    
    private var lessonList: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(Lesson.allCases, id: \.rawValue) { lesson in
                NavigationLink(value: lesson.rawValue) {
                    LessonCard(lesson: lesson)
                }
                .buttonStyle(PlainButtonStyle()) // Better performance for navigation links
            }
        }
        .padding()
        .navigationDestination(for: Int.self) { lessonID in
            ExamListView(lessonID: lessonID)
        }
    }
}

#Preview {
    MainView()
}
