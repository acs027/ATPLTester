//
//  LessonView.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import SwiftUI
import SwiftData

struct ExamListView: View {
    @State private var vm = ExamListViewModel()
    @Environment(\.modelContext) private var modelContext
    @State private var isCreateViewShowing = false
    
    let lessonID: Int

    var body: some View {
        VStack(spacing: 0) {
            content
            createExamButton
        }
        .onAppear(perform: onAppear)
        .onChange(of: vm.isCreatingExam) { _, newValue in
            print("Creating exam: \(newValue)")
        }
        .sheet(isPresented: $isCreateViewShowing) {
            CreateExamView(questionCount: $vm.questionCount, createExam: createExam)
                .presentationDetents([.medium])
        }
    }

    // MARK: - Main Content

    private var content: some View {
        Group {
            if vm.isCreatingExam {
                ProgressView("Creating Exam...")
                    .padding()
            } else {
                examList
            }
        }
    }

    private var examList: some View {
        List {
            ForEach(vm.exams, id: \.id) { exam in
                NavigationLink {
                    ExamView(vm: ExamViewModel(exam: exam))
                } label: {
                    ExamCard(exam: exam)
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.insetGrouped)
    }

    // MARK: - Create Exam Button

    private var createExamButton: some View {
        Button(action: showCreateExamSheet) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.accentColor.opacity(0.2))
                .frame(height: 48)
                .overlay(
                    Text("Create Exam")
                        .font(.headline)
                        .foregroundColor(.primary)
                )
                .padding()
        }
    }

    // MARK: - Logic

    private func onAppear() {
        if vm.exams.isEmpty {
            vm.fetchLessonExams(context: modelContext, lessonID: lessonID)
        }
    }

    private func delete(at offsets: IndexSet) {
        vm.delete(at: offsets, context: modelContext, subjectId: lessonID)
    }

    private func showCreateExamSheet() {
        isCreateViewShowing = true
    }

    private func createExam(questionSource: [QuestionSource]) {
        vm.createExam(context: modelContext, subjectID: lessonID, sources: questionSource)
        isCreateViewShowing = false
    }
}


#Preview {
    ExamListView(lessonID: 21)
}
