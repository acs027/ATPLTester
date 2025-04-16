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
    var questions: [Question]
    var correctCount: Int
    var wrongCount: Int
    var questionTime: Int
    var subjectID: Int
    var lastSession: Date
    
    init(questions: [Question], correctCount: Int, wrongCount: Int, questionTime: Int, subjectID: Int, lastSession: Date) {
        self.id = UUID()
        self.questions = questions
        self.correctCount = correctCount
        self.wrongCount = wrongCount
        self.questionTime = questionTime
        self.subjectID = subjectID
        self.lastSession = lastSession
    }
}
