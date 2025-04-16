//
//  DataManager.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import Foundation
import SwiftData

@Observable
class DataManager {
    let modelContext: ModelContext
    
    init(container: ModelContainer) {
        self.modelContext = ModelContext(container)
    }
    
    func loadQuestionsIfNeeded() async {
        let fetchDescriptor = FetchDescriptor<Question>()
               let existingCount = (try? modelContext.fetch(fetchDescriptor).count) ?? 0

               if existingCount < 10267 {
                   await loadQuestions()
               }
    }
    
    private func loadQuestions() async {
            guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                print("Failed to load JSON")
                return
            }

            do {
                let questionList = try JSONDecoder().decode(QuestionList.self, from: data)

                for q in questionList.t_qs {
                    let fetchDescriptor = FetchDescriptor<Question>(
                        predicate: #Predicate { $0.id == q.id }
                    )

                    let existing = try modelContext.fetch(fetchDescriptor)
                    if existing.isEmpty {
                        let question = Question(id: q.id,
                                                text: q.question,
                                                optionA: q.optionA,
                                                optionB: q.optionB,
                                                optionC: q.optionC,
                                                optionD: q.optionD,
                                                correctAnswer: q.correctAnswer,
                                                source: q.source,
                                                subjectID: q.subjectID)
                        modelContext.insert(question)
                    }
                }

                try? modelContext.save()
                print("✅ Loaded questions into SwiftData")
            } catch {
                print("❌ Decoding error:", error)
            }
        }
}
