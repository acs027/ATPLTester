//
//  ReviewQuestionView.swift
//  ATPLTester
//
//  Created by ali cihan on 7.05.2025.
//

import SwiftUI

struct ReviewQuestionView: View {
    var question: Question
    var userAnswer: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .bold()
                .font(.title2)
                .minimumScaleFactor(0.7)
            optionView(key: "A", text: question.optionA).highlightAnswer(for: 1, userAnswer: userAnswer, correctAnswer: question.correctAnswer)
            optionView(key: "B", text: question.optionB).highlightAnswer(for: 2, userAnswer: userAnswer, correctAnswer: question.correctAnswer)
            optionView(key: "C", text: question.optionC).highlightAnswer(for: 3, userAnswer: userAnswer, correctAnswer: question.correctAnswer)
            optionView(key: "D", text: question.optionD).highlightAnswer(for: 4, userAnswer: userAnswer, correctAnswer: question.correctAnswer)
            Text("Fail? \(question.userDidFail) Seen? \(question.userHaveSeen)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
    
    func optionView(key: String, text: String) -> some View {
        HStack() {
            Text("\(key).")
                .bold()
            Text(text)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
        )
    }
}

extension View {
    func highlightAnswer(for option: Int, userAnswer: Int?, correctAnswer: Int) -> some View {
        guard let userAnswer = userAnswer else {
            return AnyView(self)
        }
        if option == correctAnswer {
            return AnyView(self
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.green)
                ))
        } else if option == userAnswer && option != correctAnswer {
            return AnyView(self
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.red)
                ))
        }
        return AnyView(self)
    }
}
