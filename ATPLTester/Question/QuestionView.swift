//
//  SwiftUIView.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import SwiftUI

struct QuestionView: View {
    var question: Question
    let function: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .bold()
                .font(.title2)
            optionView(key: "A", text: question.optionA)
            optionView(key: "B", text: question.optionB)
            optionView(key: "C", text: question.optionC)
            optionView(key: "D", text: question.optionD)
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
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
        )
        .onTapGesture {
            function(key == "A" ? 1 : key == "B" ? 2 : key == "C" ? 3 : 4)
        }
    }
}

//#Preview {
//    QuestionView(question: Question(id: 1, text: "Lorem ipsum", optionA: "A", optionB: "B", optionC: "C", optionD: "D", correctAnswer: 1, source: "Bristol", subjectID: 21))
//}
