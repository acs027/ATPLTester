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
//           GridItem(.flexible())
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
            ForEach(Lesson.allCases, id:\.self) { lesson in
                NavigationLink {
                    LessonView(lessonID: lesson.rawValue)
                } label: {
                    HStack {
                        Text(lesson.name)
                            .font(.title)
                            .bold()
                            .tint(.primary)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 100)
                            
                        Text("\(lesson.rawValue)")
                            .font(.system(size: 70))
                            .bold()
                            .foregroundStyle(.white)
                            .opacity(0.5)
                            .padding(.horizontal)
                    }
                    .padding()
                    .background(
                            RoundedRectangle(cornerRadius: 25)
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    MainView()
}
