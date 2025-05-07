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
    var exams: [Exam] = []
    let dataManager = DataManager.shared
    var questionCount = 10
    
    func fetchLessonExams(context: ModelContext, lessonID: Int) {
        exams = dataManager.fetchLessonExams(context: context, lessonID: lessonID)
    }
    
    func createExam(
        context: ModelContext,
        subjectID: Int
    ) {
        isCreatingExam = true
        dataManager.createExam(context: context, subjectID: subjectID, questionCount: questionCount) { [weak self] in
            self?.fetchLessonExams(context: context, lessonID: subjectID)
            self?.isCreatingExam = false
        }
    }
    
    func delete(at offsets: IndexSet, context: ModelContext, subjectId: Int) {
        guard let index = offsets.first else { return }
        let examID = exams[index].id
        dataManager.deleteExam(context: context, examID: examID) { [weak self] in
            self?.fetchLessonExams(context: context, lessonID: subjectId)
        }
    }
}
