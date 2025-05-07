//
//  QuestionSwiftData.swift
//  ATPLTester
//
//  Created by ali cihan on 15.04.2025.
//

import Foundation
import SwiftData

@Model
final class Question {
    @Attribute(.unique) var id: Int
    var text: String
    var optionA: String
    var optionB: String
    var optionC: String
    var optionD: String
    var correctAnswer: Int
    var source: String
    var subjectID: Int
    var figureID: String // "nil" for question without figures
    var userDidFail: Bool
    var userHaveSeen: Int
    var hide: Bool
    
    init(id: Int,
         text: String,
         optionA: String,
         optionB: String,
         optionC: String,
         optionD: String,
         correctAnswer: Int,
         source: String,
         subjectID: Int,
         figureID: String = "nil",
         userDidFail: Bool = false,
         userHaveSeen: Int = 0,
         hide: Bool = false
    ) {
        self.id = id
        self.text = text
        self.optionA = optionA
        self.optionB = optionB
        self.optionC = optionC
        self.optionD = optionD
        self.correctAnswer = correctAnswer
        self.figureID = figureID
        self.source = source
        self.subjectID = subjectID
        self.userDidFail = userDidFail
        self.userHaveSeen = userHaveSeen
        self.hide = hide
    }
}
