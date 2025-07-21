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
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Group {
            if vm.questions.isEmpty {
                ProgressView("Loading questions...")
                    .padding()
            } else {
                content
            }
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                questionMenu
            }
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }

    // MARK: - Content View

    private var content: some View {
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
                reviewView
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Review

    private var reviewView: some View {
        ReviewListView(examQuestions: vm.questions,
                       userAnswers: vm.exam.userAnswers)
    }

    // MARK: - Navigation Title

    private var navigationTitle: Text {
        if vm.exam.isDone {
            return Text("C: \(vm.exam.correctCount)  F: \(vm.exam.falseCount)")
        } else {
            return Text("\(vm.questionIndex + 1) / \(vm.exam.userAnswers.count)")
        }
    }

    // MARK: - Toolbar Menu

    private var questionMenu: some View {
        Menu {
            Button("Hide this question") {
                vm.markAsHidden()
            }
            Button("Report a bug") {
                // Placeholder for bug report logic
            }
        } label: {
            Label("Options", systemImage: "ellipsis.circle")
        }
    }

    // MARK: - Lifecycle

    private func onAppear() {
        vm.getQuestions(context: modelContext)
        #if DEBUG
        if let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            print("📁 SwiftData location: \(url.path)")
        }
        #endif
    }

    private func onDisappear() {
        vm.saveContext(context: modelContext)
    }
}
