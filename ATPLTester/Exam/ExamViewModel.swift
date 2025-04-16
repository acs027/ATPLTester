//
//  ExamViewModel.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import Foundation

@Observable
class ExamViewModel {
    var exam: Exam
    var questionIndex = 0
    var isExamFinish = false
    
    init(exam: Exam) {
        self.exam = exam
    }
    
    func checkAnswer(userAnswer: Int) {
        if exam.questions[questionIndex].correctAnswer == userAnswer {
            exam.correctCount += 1
        } else {
            exam.wrongCount += 1
        }
    }
    
    func nextQuestion() {
        if questionIndex < exam.questions.count - 1 {
            self.questionIndex += 1
        } else {
            isExamFinish = true
        }
    }
    
    func previousQuestion() {
        if questionIndex > 0 {
            self.questionIndex -= 1
        }
    }
    
    
}
