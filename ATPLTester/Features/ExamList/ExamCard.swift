//
//  ExamCardView.swift
//  ATPLTester
//
//  Created by ali cihan on 12.05.2025.
//

import SwiftUI

struct ExamCard: View {
    @State var exam: Exam

    var body: some View {
        HStack {
            examInfo
            Spacer()
            CircularProgress(correct: Double(exam.correctCount),
                             incorrect: Double(exam.falseCount),
                             total: Double(exam.userAnswers.count),
                             radius: 32)
        }
        .padding()
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    // MARK: - Subviews

    private var examInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Questions: \(exam.userAnswers.count)")
                .fontWeight(.semibold)

            Text("Correct: \(exam.correctCount)")
                .foregroundStyle(.green)

            Text("False: \(exam.falseCount)")
                .foregroundStyle(.red)

            Text(examProgressText)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var examProgressText: String {
        exam.isDone
            ? "Progress: Done"
            : "Progress: \(exam.lastSessionQuestionIndex + 1) / \(exam.userAnswers.count)"
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color(.systemBackground))
            .opacity(0.9)
    }
}


#Preview {
    let exam1 = Exam(id: UUID(), correctCount: 1, falseCount: 1, questionTime: 1, subjectID: 1, lastSession: Date.now, isDone: false)
    let exam2 = Exam(id: UUID(), correctCount: 1, falseCount: 1, questionTime: 1, subjectID: 1, lastSession: Date.now, isDone: true)
    VStack {
        ExamCard(exam: exam1)
        ExamCard(exam: exam2)
    }
    
}
