//
//  LessonView.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import SwiftUI
import SwiftData

struct LessonView: View {
    @State var vm = LessonViewModel()
    @Environment(\.modelContext) var modelContext
    let lessonID: Int
    
    var body: some View {
        Button {
            createExam()
        } label: {
            Text("Create Exam")
        }
        List(vm.exams, id:\.id) { exam in
            NavigationLink {
                ExamView(vm: ExamViewModel(exam: exam))
            } label: {
                Text("\(exam.id)")
            }
        }
        .onChange(of: vm.isCreatingExam) { oldValue, newValue in
            print(newValue)
        }
        .onAppear {
            loadData()
        }
    }
    
    func createExam() {
        print(vm.questions.count)
        print(vm.exams.count)
        vm.createExam(context: modelContext, subjectID: lessonID, questionCount: 10)
    }
    
    func loadData() {
        vm.loadQuestions(context: modelContext, lessonID: lessonID)
        vm.loadExams(context: modelContext, lessonID: lessonID)
    }
}

//#Preview {
//    LessonView()
//}
