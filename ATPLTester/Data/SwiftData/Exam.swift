//
//  Exam.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import Foundation
import SwiftData

@Model
final class Exam {
    @Attribute(.unique) var id: UUID
//    var questions: [Question]
    var correctCount: Int
    var wrongCount: Int
    var questionTime: Int
    var subjectID: Int
    var lastSession: Date
    var lastSessionQuestionIndex: Int
    var isDone: Bool
    var userAnswers: [UserAnswer] // [questionID:answerValue]
    
    init(id: UUID, correctCount: Int, wrongCount: Int, questionTime: Int, subjectID: Int, lastSession: Date,
         lastSessionQuestionIndex: Int = 0, isDone: Bool = false,
         userAnswers: [UserAnswer] = []) {
        self.id = id
//        self.questions = questions
        self.correctCount = correctCount
        self.wrongCount = wrongCount
        self.questionTime = questionTime
        self.subjectID = subjectID
        self.lastSession = lastSession
        self.lastSessionQuestionIndex = lastSessionQuestionIndex
        self.isDone = isDone
        self.userAnswers = userAnswers
    }
}

@Model
final class UserAnswer {
    var examID: UUID
    var questionID: Int
    var userAnswer: Int
    
    init(examID: UUID, questionID: Int, userAnswer: Int) {
        self.examID = examID
        self.questionID = questionID
        self.userAnswer = userAnswer
    }
}
