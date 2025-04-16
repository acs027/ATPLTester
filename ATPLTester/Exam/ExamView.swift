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
    
    var body: some View {
        if !vm.isExamFinish {
            QuestionView(question: vm.exam.questions[vm.questionIndex]) { answerIndex in
                vm.checkAnswer(userAnswer: answerIndex)
                vm.nextQuestion()
            }
        } else {
            Text("\(vm.exam.correctCount) \(vm.exam.wrongCount)")
        }
        
    }
}
