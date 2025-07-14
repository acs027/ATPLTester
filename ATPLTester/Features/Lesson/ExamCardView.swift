//
//  ExamCardView.swift
//  ATPLTester
//
//  Created by ali cihan on 12.05.2025.
//

import SwiftUI

struct ExamCardView: View {
    @State var exam: Exam
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Question: \(exam.userAnswers.count)")
                .bold()
            Text("Correct: \(exam.correctCount)")
            Text("False: \(exam.wrongCount)")
            if exam.isDone {
                Text("Progress: Done")
            } else {
                Text("Progress: \(exam.lastSessionQuestionIndex + 1) / \(exam.userAnswers.count)")
            }
        }
    }
}

#Preview {
    let exam1 = Exam(id: UUID(), correctCount: 1, wrongCount: 1, questionTime: 1, subjectID: 1, lastSession: Date.now, isDone: false)
    let exam2 = Exam(id: UUID(), correctCount: 1, wrongCount: 1, questionTime: 1, subjectID: 1, lastSession: Date.now, isDone: true)
    VStack {
        ExamCardView(exam: exam1)
        ExamCardView(exam: exam2)
    }
    
}
