//
//  MainViewModel.swift
//  ATPLTester
//
//  Created by ali cihan on 21.04.2025.
//

import Foundation
import SwiftData

@Observable
class MainViewModel {
    private var context: ModelContext
    var isLoading = false
    
    init(context: ModelContext) {
        self.context = context
        loadQuestionsIfNeeded()
    }
    
    func loadQuestionsIfNeeded() {
        let descriptor = FetchDescriptor<Question>()
        let existingQuestions = (try? context.fetch(descriptor)) ?? []
        
        guard existingQuestions.count < 10267 else {
            print("🟡 Questions already loaded")
            return
        }
        
        loadQuestions()
    }
    
    func loadQuestions() {
        isLoading = true
        
        // Use background queue for heavy processing
        Task.detached(priority: .background) { [weak self] in
            guard let self = self else { return }
            
            guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                await MainActor.run {
                    self.isLoading = false
                }
                print("Failed to load JSON")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let questionList = try decoder.decode(QuestionList.self, from: data)
                let batchSize = 1000 // Increased batch size for better performance
                
                // Process in batches to avoid memory spikes
                for batch in stride(from: 0, to: questionList.t_qs.count, by: batchSize) {
                    let end = min(batch + batchSize, questionList.t_qs.count)
                    let slice = Array(questionList.t_qs[batch..<end])
                    
                    // Create questions array for batch insert
                    let questions = slice.compactMap { q -> Question? in
                        // Skip invalid questions early
                        guard q.id > 0, !q.question.isEmpty else { return nil }
                        
                        return Question(id: q.id,
                                      text: q.question,
                                      optionA: q.optionA,
                                      optionB: q.optionB,
                                      optionC: q.optionC,
                                      optionD: q.optionD,
                                      correctAnswer: q.correctAnswer,
                                      source: q.source,
                                      subjectID: q.subjectID,
                                      figureID: q.figure ?? "nil"
                        )
                    }
                    
                    // Insert batch on main actor
                    await MainActor.run {
                        for question in questions {
                            self.context.insert(question)
                        }
                        
                        // Save less frequently for better performance
                        if batch % (batchSize * 2) == 0 || end == questionList.t_qs.count {
                            try? self.context.save()
                        }
                    }
                }
                
                await MainActor.run {
                    print("✅ \(questionList.t_qs.count) questions loaded successfully")
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    print("❌ Decoding error:", error)
                }
            }
        }
    }
}
