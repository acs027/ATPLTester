//
//  ExamView.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import SwiftUI
import SwiftData

struct ExamView: View {
    @State var vm: ExamViewModel
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Group{
            if vm.questions.isEmpty {
                ProgressView()
            }
            else {
                VStack {
                    if !vm.exam.isDone,
                       let question = vm.getQuestion() {
                        QuestionView(question: question) { answerIndex in
                            vm.checkAnswer(userAnswer: answerIndex, question: question)
                        }
                        .id(question.id)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        .animation(.easeInOut, value: vm.questionIndex)
                    } else {
                        VStack {
                            ReviewListView(examQuestions: vm.questions, userAnswers: vm.exam.userAnswers)
                        }
                    }
                }
            }
        }
        .navigationTitle(
            !vm.exam.isDone ? Text("\(vm.questionIndex + 1) / \(vm.exam.userAnswers.count)") :
                Text("C: \(vm.exam.correctCount) F: \(vm.exam.wrongCount)")
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                questionMenu
            }
        }
        .onAppear {
            vm.getQuestions(context: modelContext)
            if let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
                print("📁 SwiftData location: \(url.path)")
            }
        }
        .onDisappear {
            vm.saveContext(context: modelContext)
        }
    }
    
    var questionMenu: some View {
        Menu("Help") {
            Button("Hide question") {
                vm.markAsHidden()
            }
            Button("Bug report") {
                
            }
        }
    }
}
