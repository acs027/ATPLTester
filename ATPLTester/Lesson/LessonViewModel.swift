//
//  LessonViewModel.swift
//  ATPLTester
//
//  Created by ali cihan on 16.04.2025.
//

import Foundation
import SwiftData

@Observable
class LessonViewModel {
    var isCreatingExam: Bool = false
    var questions: [Question] = []
    var exams: [Exam] = []
    
    func loadQuestions(context: ModelContext, lessonID: Int) {
           let questionFetch = FetchDescriptor<Question>(predicate: #Predicate {
               $0.subjectID == lessonID
           })

           questions = (try? context.fetch(questionFetch)) ?? []
       }
    
    func loadExams(context: ModelContext, lessonID: Int) {
        let examFetch = FetchDescriptor<Exam>(predicate: #Predicate {
            $0.subjectID == lessonID
        })
        exams = (try? context.fetch(examFetch)) ?? []
    }
    
    func createExam(
          context: ModelContext,
          subjectID: Int,
          questionCount: Int
      ) {
          isCreatingExam = true
          let selected = questions.shuffled().prefix(questionCount)
          let examQuestions = selected.map { $0 }
          print(examQuestions.count)
          let newExam = Exam(questions: examQuestions, correctCount: 0, wrongCount: 0, questionTime: 30, subjectID: subjectID, lastSession: Date.now)

          print(newExam)
          context.insert(newExam)
          
          do {
              try context.save()
              print("saved ")
          }
          catch {
              print("not saved")
          }
          loadExams(context: context, lessonID: subjectID)
          isCreatingExam = false
      }
}
