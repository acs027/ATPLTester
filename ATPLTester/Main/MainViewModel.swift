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
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load JSON")
            return
        }
        do {
            let questionList = try JSONDecoder().decode(QuestionList.self, from: data)
            let batchSize = 500
            
            
            for batch in stride(from: 0, to: questionList.t_qs.count, by: batchSize) {
                let end = min(batch + batchSize, questionList.t_qs.count)
                let slice = questionList.t_qs[batch..<end]
                
                for q in slice {
                    let question = Question(id: q.id,
                                            text: q.question,
                                            optionA: q.optionA,
                                            optionB: q.optionB,
                                            optionC: q.optionC,
                                            optionD: q.optionD,
                                            correctAnswer: q.correctAnswer,
                                            source: q.source,
                                            subjectID: q.subjectID)
                    self.context.insert(question)
                }
                try? self.context.save()
            }
            print("questions loaded")
            isLoading = false
        } catch {
            self.isLoading = false
            print("❌ Decoding error:", error)
        }
        
    }
}
