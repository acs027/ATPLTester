//
//  DataManager.swift
//  ATPLTester
//
//  Created by ali cihan on 23.04.2025.
//

import Foundation
import SwiftData

class DataManager {
    
    static let shared = DataManager()
    
    private init() {
        
    }
    
    func fetchLessonExams(context: ModelContext, lessonID: Int) -> [Exam] {
        let examFetch = FetchDescriptor<Exam>(
            predicate: #Predicate {
                $0.subjectID == lessonID
            },
            sortBy: [SortDescriptor(\.lastSession, order: .reverse)]
        )
        print("exams loaded")
        return (try? context.fetch(examFetch)) ?? []
    }
    
    func fetchedLessonQuestions(context: ModelContext, lessonID: Int, questionCount: Int) -> [Question] {
        var questionFetch = FetchDescriptor<Question>(
            predicate: #Predicate {
                $0.subjectID == lessonID
            },
            sortBy: [SortDescriptor(\.userHaveSeen, order: .forward)]
        )
        questionFetch.fetchLimit = questionCount
        print("questions loaded")
        return (try? context.fetch(questionFetch)) ?? []
    }
    
    func createExam(
        context: ModelContext,
        subjectID: Int,
        questionCount: Int,
        completion: () -> ()
    ) {
        let questions = fetchedLessonQuestions(context: context, lessonID: subjectID, questionCount: questionCount)
        if questions.count < questionCount { return }
        let examID = UUID()
        let userAnswers = questions.map {
            UserAnswer(examID: examID, questionID: $0.id, userAnswer: -1)
        }
        let newExam = Exam(id: examID, correctCount: 0, wrongCount: 0, questionTime: 30, subjectID: subjectID, lastSession: Date.now, userAnswers: userAnswers)
        
        print(newExam)
        context.insert(newExam)
        
        saveContext(context: context)
        completion()
    }
    
    func deleteExam(context: ModelContext, examID: UUID, completion: () -> ()) {
        let examFetch = FetchDescriptor<Exam>(predicate: #Predicate {
            $0.id == examID
        })
        guard let exam = try? context.fetch(examFetch).first else { return }
        context.delete(exam)
        debugPrint("exam deleted")
        saveContext(context: context)
        completion()
    }
    
    func saveContext(context: ModelContext) {
        do {
            try context.save()
            debugPrint("saved")
        } catch {
            debugPrint("failed to save")
        }
    }
    
    func getQuestions(context: ModelContext, exam: Exam) -> [Question] {
        let questionIDs = exam.userAnswers.map { $0.questionID }
            
            let descriptor = FetchDescriptor<Question>(
                predicate: #Predicate { questionIDs.contains($0.id) }
            )
            
            return (try? context.fetch(descriptor)) ?? []
    }
}
