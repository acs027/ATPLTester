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
            List {
                ForEach(Array(userAnswers.enumerated()), id:\.element.id) { index, userAnswer in
                    if let question = findQuestion(questionID: userAnswer.questionID) {
                        NavigationLink {
                            ReviewQuestionView(question: question, userAnswer: userAnswer.userAnswer)
                        } label: {
                            HStack {
                                Text("\(index + 1)")
                                question.correctAnswer == userAnswer.userAnswer ? Text("Correct") : Text("False")
                            }
                        }
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



//#Preview {
//    ReviewListView()
//}
