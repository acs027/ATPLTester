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
                        .id(vm.questionIndex)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        .animation(.easeInOut, value: vm.questionIndex)
                    } else {
                        VStack {
//                            ReviewView(examQuestions: vm.questions, userAnswers: vm.exam.userAnswers)
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
                Button("Restart") {
                    vm.resetExam()
                }
            }
        }
        .onAppear {
            vm.getQuestions(context: modelContext)
        }
        .onDisappear {
            vm.saveContext(context: modelContext)
        }
    }
}
