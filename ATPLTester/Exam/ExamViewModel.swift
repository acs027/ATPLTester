//
//  ExamViewModel.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import Foundation
import SwiftData

@Observable
class ExamViewModel {
    var exam: Exam
    var questionIndex: Int
    var dataManager = DataManager.shared
    var questions: [Question] = []
    
    init(exam: Exam) {
        self.exam = exam
        self.questionIndex = exam.lastSessionQuestionIndex
    }
    
    func resetExam() {
        exam.userAnswers.shuffle()
        exam.wrongCount = 0
        exam.correctCount = 0
        exam.lastSessionQuestionIndex = 0
        questionIndex = 0
        exam.isDone = false
    }
    
    func markQuestionAsSeen() {
        exam.lastSessionQuestionIndex = questionIndex
        if questionIndex < exam.userAnswers.count {
            let questionID = exam.userAnswers[questionIndex].questionID
            if let question = questions.first(where: {$0.id == questionID}) {
                question.userHaveSeen += 1
            }
        }
    }
    
    func checkAnswer(userAnswer: Int, question: Question) {
        if question.correctAnswer == userAnswer {
            exam.correctCount += 1
        } else {
            exam.wrongCount += 1
            question.userDidFail = true
        }
        if let questionUserAnswer = exam.userAnswers.first(where: {$0.questionID == question.id}) {
            questionUserAnswer.userAnswer = userAnswer
        }
        nextQuestion()
    }
    
    func nextQuestion() {
        if questionIndex < questions.count - 1 {
            self.questionIndex += 1
            markQuestionAsSeen()
        } else {
            exam.isDone = true
            exam.lastSessionQuestionIndex = 0
        }
        
    }
    
    func saveContext(context: ModelContext) {
        dataManager.saveContext(context: context)
    }
    
    func getQuestions(context: ModelContext) {
        questions = dataManager.getQuestions(context: context, exam: exam)
    }
    
    func getQuestion() -> Question? {
        let userAnswer = exam.userAnswers[questionIndex]
        return questions.first(where: {$0.id == userAnswer.questionID})
    }
}
