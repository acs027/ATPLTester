//
//  ReviewListView.swift
//  ATPLTester
//
//  Created by ali cihan on 7.05.2025.
//

import SwiftUI

struct ReviewListView: View {
    @State var examQuestions: [Question]
    @State var userAnswers: [UserAnswer]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 16) {
                ForEach(Array(userAnswers.enumerated()), id: \.element.id) { index, userAnswer in
                    if let question = findQuestion(questionID: userAnswer.questionID) {
                        navigationLink(for: index, question: question, userAnswer: userAnswer)
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: - Layout
    
    var gridColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 70), spacing: 16)]
    }
    
    func navigationLink(for index: Int, question: Question, userAnswer: UserAnswer) -> some View {
        NavigationLink {
            ReviewQuestionView(question: question, userAnswer: userAnswer.userAnswer)
        } label: {
            reviewCard(index: index, question: question, userAnswer: userAnswer)
        }
        .buttonStyle(.plain)
    }
    
    func reviewCard(index: Int, question: Question, userAnswer: UserAnswer) -> some View {
        VStack(spacing: 8) {
            Text("\(index + 1)")
                .font(.headline)
                .foregroundColor(.primary)

            statusMark(userAnswer: userAnswer.userAnswer, questionAnswer: question.correctAnswer)
        }
        .frame(width: 70, height: 70)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 2)
                .foregroundStyle(userAnswer.userAnswer == question.correctAnswer ? .green : .red)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    func statusMark(userAnswer: Int, questionAnswer: Int) -> some View {
        Image(systemName: userAnswer == questionAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
            .font(.title3)
            .foregroundStyle(userAnswer == questionAnswer ? .green : .red)
    }
    
    func findQuestion(questionID: Int) -> Question? {
        examQuestions.first { $0.id == questionID }
    }
}






#Preview {
    let question = [Question(id: 1, text: "a", optionA: "a", optionB: "b", optionC: "c", optionD: "d", correctAnswer: 1, source: "a", subjectID: 1)]
    let userAnswer = [UserAnswer(examID: UUID(), questionID: 1, userAnswer: 1)]
    ReviewListView(examQuestions: question, userAnswers: userAnswer)
}
