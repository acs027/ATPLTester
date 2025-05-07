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
    let figure: Int?                 // "figure"
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

            id = Int(try container.decode(String.self, forKey: .id)) ?? 0
            orjID = Int(try container.decode(String.self, forKey: .orjID)) ?? 0
            source = try container.decode(String.self, forKey: .source)
            subjectID = Int(try container.decode(String.self, forKey: .subjectID)) ?? 0
            question = try container.decode(String.self, forKey: .question)
            optionA = try container.decode(String.self, forKey: .optionA)
            optionB = try container.decode(String.self, forKey: .optionB)
            optionC = try container.decode(String.self, forKey: .optionC)
            optionD = try container.decode(String.self, forKey: .optionD)
        correctAnswer = Int(try container.decodeIfPresent(String.self, forKey: .correctAnswer) ?? "0") ?? 0
            figure = Int(try container.decode(String.self, forKey: .figure)) ?? 0
            hasInfo = try container.decode(String.self, forKey: .hasInfo).uppercased() == "True"
        group = Int(try container.decodeIfPresent(String.self, forKey: .group) ?? "0") ?? 0
            tryCount = Int(try container.decode(String.self, forKey: .tryCount)) ?? 0
            correctCount = Int(try container.decode(String.self, forKey: .correctCount)) ?? 0
            isDeleted = try container.decode(String.self, forKey: .isDeleted).uppercased() == "TRUE"
        dontShow = try container.decodeIfPresent(String.self, forKey: .dontShow)?.uppercased() == "TRUE"
            isFlagged = try container.decode(String.self, forKey: .isFlagged).uppercased() == "TRUE"
            userInfo = Int(try container.decode(String.self, forKey: .userInfo)) ?? 0
            lastAnswer = try container.decode(String.self, forKey: .lastAnswer).uppercased() == "TRUE"
            isHidden = try container.decode(String.self, forKey: .isHidden).uppercased() == "TRUE"
            translatedQuestion = try container.decode(String.self, forKey: .translatedQuestion)
            translatedA = try container.decode(String.self, forKey: .translatedA)
            translatedB = try container.decode(String.self, forKey: .translatedB)
            translatedC = try container.decode(String.self, forKey: .translatedC)
            translatedD = try container.decode(String.self, forKey: .translatedD)
        }
}
