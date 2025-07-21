//
//  ReviewView.swift
//  ATPLTester
//
//  Created by ali cihan on 21.04.2025.
//

import SwiftUI

struct ReviewView: View {
    @State var examQuestions: [Question]
    @State var userAnswers: [UserAnswer]
    var body: some View {
            List {
                ForEach(userAnswers, id:\.id) { userAnswer in
                    if let question = findQuestion(questionID: userAnswer.questionID) {
                        ReviewQuestionView(question: question, userAnswer: userAnswer.userAnswer)
                    }
                }
            }
        .onAppear {
            print(userAnswers)
        }
    }
    
    func findQuestion(questionID: Int) -> Question? {
        examQuestions.first(where: {$0.id == questionID})
    }
}

#Preview {
    let question = [Question(id: 1, text: "a", optionA: "a", optionB: "b", optionC: "c", optionD: "d", correctAnswer: 1, source: "a", subjectID: 1)]
    let userAnswer = [UserAnswer(examID: UUID(), questionID: 1, userAnswer: 1)]
    ReviewView(examQuestions: question, userAnswers: userAnswer)
}
