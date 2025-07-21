//
//  Question.swift
//  ATPLTester
//
//  Created by ali cihan on 15.04.2025.
//

import Foundation

struct QuestionList: Codable {
    let t_qs: [QuestionData]
}

struct QuestionData: Codable, Identifiable {
    let id: Int                      // "Kimlik"
    let orjID: Int                   // "orjid"
    let source: String               // "src"
    let subjectID: Int              // "sbjid"
    let question: String            // "qs"
    let optionA: String             // "a"
    let optionB: String             // "b"
    let optionC: String             // "c"
    let optionD: String             // "d"
    let correctAnswer: Int          // "ans" (1-based index)
    let figure: String?               // "figure"
    let hasInfo: Bool?               // "info"
    let group: Int?                  // "grp"
    let tryCount: Int?               // "tryc"
    let correctCount: Int?           // "corc"
    let isDeleted: Bool?             // "del"
    let dontShow: Bool?              // "dontshow"
    let isFlagged: Bool?             // "flagged"
    let userInfo: Int?               // "userinfo"
    let lastAnswer: Bool?            // "lastans"
    let isHidden: Bool?            // "hide"
    
    let translatedQuestion: String?  // "tr_qs"
    let translatedA: String?         // "tr_a"
    let translatedB: String?         // "tr_b"
    let translatedC: String?         // "tr_c"
    let translatedD: String?         // "tr_d"
    
    enum CodingKeys: String, CodingKey {
        case id = "Kimlik"
        case orjID = "orjid"
        case source = "src"
        case subjectID = "sbjid"
        case question = "qs"
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
        case optionD = "d"
        case correctAnswer = "ans"
        case figure
        case hasInfo = "info"
        case group = "grp"
        case tryCount = "tryc"
        case correctCount = "corc"
        case isDeleted = "del"
        case dontShow
        case isFlagged = "flagged"
        case userInfo = "userinfo"
        case lastAnswer = "lastans"
        case isHidden = "hide"
        case translatedQuestion = "tr_qs"
        case translatedA = "tr_a"
        case translatedB = "tr_b"
        case translatedC = "tr_c"
        case translatedD = "tr_d"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Optimized string-to-int conversions with better error handling
        id = Self.safeIntConversion(try container.decode(String.self, forKey: .id))
        orjID = Self.safeIntConversion(try container.decode(String.self, forKey: .orjID))
        source = try container.decode(String.self, forKey: .source)
        subjectID = Self.safeIntConversion(try container.decode(String.self, forKey: .subjectID))
        question = try container.decode(String.self, forKey: .question)
        optionA = try container.decode(String.self, forKey: .optionA)
        optionB = try container.decode(String.self, forKey: .optionB)
        optionC = try container.decode(String.self, forKey: .optionC)
        optionD = try container.decode(String.self, forKey: .optionD)
        correctAnswer = Self.safeIntConversion(try container.decodeIfPresent(String.self, forKey: .correctAnswer) ?? "0")
        figure = try container.decodeIfPresent(String.self, forKey: .figure)
        
        // Optimized boolean conversions
        hasInfo = Self.safeBoolConversion(try container.decodeIfPresent(String.self, forKey: .hasInfo))
        group = Self.safeIntConversion(try container.decodeIfPresent(String.self, forKey: .group) ?? "0")
        tryCount = Self.safeIntConversion(try container.decodeIfPresent(String.self, forKey: .tryCount) ?? "0")
        correctCount = Self.safeIntConversion(try container.decodeIfPresent(String.self, forKey: .correctCount) ?? "0")
        isDeleted = Self.safeBoolConversion(try container.decodeIfPresent(String.self, forKey: .isDeleted))
        dontShow = Self.safeBoolConversion(try container.decodeIfPresent(String.self, forKey: .dontShow))
        isFlagged = Self.safeBoolConversion(try container.decodeIfPresent(String.self, forKey: .isFlagged))
        userInfo = Self.safeIntConversion(try container.decodeIfPresent(String.self, forKey: .userInfo) ?? "0")
        lastAnswer = Self.safeBoolConversion(try container.decodeIfPresent(String.self, forKey: .lastAnswer))
        isHidden = Self.safeBoolConversion(try container.decodeIfPresent(String.self, forKey: .isHidden))
        
        // Optional translations
        translatedQuestion = try container.decodeIfPresent(String.self, forKey: .translatedQuestion)
        translatedA = try container.decodeIfPresent(String.self, forKey: .translatedA)
        translatedB = try container.decodeIfPresent(String.self, forKey: .translatedB)
        translatedC = try container.decodeIfPresent(String.self, forKey: .translatedC)
        translatedD = try container.decodeIfPresent(String.self, forKey: .translatedD)
    }
    
    // MARK: - Performance Helper Methods
    private static func safeIntConversion(_ string: String?) -> Int {
        guard let string = string, !string.isEmpty else { return 0 }
        return Int(string) ?? 0
    }
    
    private static func safeBoolConversion(_ string: String?) -> Bool? {
        guard let string = string, !string.isEmpty else { return nil }
        return string.lowercased() == "true"
    }
}
