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
        
        do {
            let exams = try context.fetch(examFetch)
            print("✅ \(exams.count) exams loaded for lesson \(lessonID)")
            return exams
        } catch {
            print("❌ Failed to fetch exams: \(error)")
            return []
        }
    }
    
    func fetchedLessonQuestions(context: ModelContext, lessonID: Int, questionCount: Int) -> [Question] {
        var questionFetch = FetchDescriptor<Question>(
            predicate: #Predicate {
                $0.subjectID == lessonID &&
                $0.isHidden == false
            },
            sortBy: [SortDescriptor(\.userHaveSeen, order: .forward)]
        )
        questionFetch.fetchLimit = questionCount
        
        do {
            let questions = try context.fetch(questionFetch)
            print("✅ \(questions.count) questions loaded for lesson \(lessonID)")
            return questions
        } catch {
            print("❌ Failed to fetch questions: \(error)")
            return []
        }
    }
    
    func createExam(
        context: ModelContext,
        subjectID: Int,
        questionCount: Int,
        questionSource: [QuestionSource],
        completion: @escaping () -> ()
    ) {
        let questions = fetchedLessonQuestions(context: context, lessonID: subjectID, questionCount: questionCount)
        
        guard questions.count >= questionCount else {
            print("❌ Insufficient questions: \(questions.count)/\(questionCount)")
            completion()
            return
        }
        
        let examID = UUID()
        
        // Use more efficient array creation
        let userAnswers = questions.prefix(questionCount).map {
            UserAnswer(examID: examID, questionID: $0.id, userAnswer: -1)
        }
        
        let newExam = Exam(
            id: examID,
            correctCount: 0,
            falseCount: 0,
            questionTime: 30,
            subjectID: subjectID,
            lastSession: Date.now,
            userAnswers: Array(userAnswers)
        )
        
        context.insert(newExam)
        
        do {
            try context.save()
            print("✅ Exam created with \(userAnswers.count) questions")
            completion()
        } catch {
            print("❌ Failed to create exam: \(error)")
            completion()
        }
    }
    
    func deleteExam(context: ModelContext, examID: UUID, completion: @escaping () -> ()) {
        let examFetch = FetchDescriptor<Exam>(predicate: #Predicate {
            $0.id == examID
        })
        
        do {
            guard let exam = try context.fetch(examFetch).first else {
                print("❌ Exam not found for deletion: \(examID)")
                completion()
                return
            }
            
            context.delete(exam)
            try context.save()
            print("✅ Exam deleted successfully")
            completion()
        } catch {
            print("❌ Failed to delete exam: \(error)")
            completion()
        }
    }
    
    func saveContext(context: ModelContext) {
        do {
            try context.save()
            print("✅ Context saved successfully")
        } catch {
            print("❌ Failed to save context: \(error)")
        }
    }
    
    func getQuestions(context: ModelContext, exam: Exam) -> [Question] {
        let questionIDs = exam.userAnswers.map { $0.questionID }
        let descriptor = FetchDescriptor<Question>(
            predicate: #Predicate { questionIDs.contains($0.id) }
        )
        
        do {
            let questions = try context.fetch(descriptor)
            print("✅ \(questions.count) questions loaded for exam")
            return questions
        } catch {
            print("❌ Failed to fetch exam questions: \(error)")
            return []
        }
    }
    
    func getLessonQuestionCount(context: ModelContext, lessonID: Int) -> Int {
        let descriptor = FetchDescriptor<Question>(
            predicate: #Predicate { $0.subjectID == lessonID }
        )
        
        do {
            let questionsCount = try context.fetchCount(descriptor)
            return questionsCount
        } catch {
            return 0
        }
    }
    
    func getLessonUnseenQuestionCount(context: ModelContext, lessonID: Int) -> Int {
        let descriptor = FetchDescriptor<Question>(
            predicate: #Predicate { $0.subjectID == lessonID && $0.userHaveSeen == 0 }
        )
        
        do {
            let questionsCount = try context.fetchCount(descriptor)
            return questionsCount
        } catch {
            return 0
        }
    }
}
