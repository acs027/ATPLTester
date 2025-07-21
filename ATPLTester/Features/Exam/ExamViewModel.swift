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
        
        exam.falseCount = 0
        exam.correctCount = 0
        exam.lastSessionQuestionIndex = 0
        questionIndex = 0
        exam.isDone = false
        
        synchronizeQuestionOrder()
    }
    
    private func synchronizeQuestionOrder() {
        let questionDict = Dictionary(uniqueKeysWithValues: questions.map { ($0.id, $0)})
        questions = exam.userAnswers.compactMap({ userAnswer in
            questionDict[userAnswer.questionID]
        })
    }
    
    func markQuestionAsSeen() {
        exam.lastSessionQuestionIndex = questionIndex
        if questionIndex < questions.count {
            questions[questionIndex].userHaveSeen += 1
        }
    }
    
    func checkAnswer(userAnswer: Int, question: Question) {
        // Update exam statistics
        if question.correctAnswer == userAnswer {
            exam.correctCount += 1
        } else {
            exam.falseCount += 1
            question.userDidFail = true
        }
        
        if let index = exam.userAnswers.firstIndex(where: { $0.questionID == question.id }) {
            exam.userAnswers[index].userAnswer = userAnswer
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
    
    func markAsHidden() {
//        let questionID = exam.userAnswers[questionIndex].questionID
//        // More efficient lookup using index instead of first(where:)
//        if let index = questions.firstIndex(where: { $0.id == questionID }) {
//            questions[index].isHidden = true
//        }
        if questionIndex < questions.count {
            questions[questionIndex].isHidden = true
        }
    }
    
    func saveContext(context: ModelContext) {
        dataManager.saveContext(context: context)
    }
    
    func getQuestions(context: ModelContext) {
        questions = dataManager.getQuestions(context: context, exam: exam)
        
        synchronizeQuestionOrder()
    }
    
    func getQuestion() -> Question? {
//        let userAnswer = exam.userAnswers[questionIndex]
//        return questions.first(where: {$0.id == userAnswer.questionID})
        
        guard questionIndex < questions.count else { return nil }
        return questions[questionIndex]
    }
}
