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
    @State var isCreateViewShowing = false
    var lessonID: Int
    
    var body: some View {
        VStack{
            if vm.isCreatingExam {
                ProgressView()
            } else {
                examList
            }
            showSheetButton
        }
        .onChange(of: vm.isCreatingExam) { oldValue, newValue in
            print(newValue)
        }
        .onAppear {
            if vm.exams.isEmpty {
                fetchExams()
            }
        }
        .sheet(isPresented: $isCreateViewShowing) {
            CreateExamView(questionCount: $vm.questionCount, createExam: createExam)
                .presentationDetents([.medium])
        }
    }
    
    private var showSheetButton: some View {
        Button {
            showSheet()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.gray)
                .frame(height: 50)
                .overlay {
                    Text("Create Exam")
                        .bold()
                        .font(.headline)
                        .tint(.primary)
                }
                .padding()
        }
    }
    
    private var examList: some View {
        List {
            ForEach(vm.exams, id: \.id) { exam in
                NavigationLink {
                    ExamView(vm: ExamViewModel(exam: exam))
                } label: {
                    VStack(alignment: .leading) {
                        Text("\(exam.userAnswers.count): Question")
                            .bold()
                        Text("Correct: \(exam.correctCount)")
                        Text("False: \(exam.wrongCount)")
                        Text("Progress: \(exam.lastSessionQuestionIndex + 1) / \(exam.userAnswers.count)")
                    }
                }
            }
            .onDelete { indexSet in
                print(indexSet)
                delete(at: indexSet)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        vm.delete(at: offsets, context: modelContext, subjectId: lessonID)
    }
    
    private func showSheet() {
        isCreateViewShowing = true
    }
    
    private func createExam() {
        vm.createExam(context: modelContext, subjectID: lessonID)
        isCreateViewShowing = false
    }
    
    private func fetchExams() {
        vm.fetchLessonExams(context: modelContext, lessonID: lessonID)
    }
}

//#Preview {
//    LessonView()
//}
