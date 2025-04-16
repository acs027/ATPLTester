//
//  ContentView.swift
//  ATPLTester
//
//  Created by ali cihan on 15.04.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @State var questions: [QuestionData] = []
    @Environment(\.modelContext) var modelContext
    @Query var questions: [Question]
    
    
    var body: some View {
        NavigationStack {
            questionCounts
            questionTime
            ForEach(Lesson.allCases, id:\.self) { lesson in
                NavigationLink {
                    LessonView(lessonID: lesson.rawValue)
                } label: {
                    Text(lesson.name)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                        )
                        .padding(.horizontal)
                }

            }
        }
        .navigationTitle("Choose")
        .onAppear {
            isDataMissing()
        }
    }
    
    var questionCounts: some View {
        HStack {
            Text("10")
            Text("20")
            Text("30")
            Text("All")
        }
    }
    
    var questionTime: some View {
        HStack {
            Text("10")
            Text("30")
            Text("60")
        }
    }
}

extension ContentView {
    func loadQuestions() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to find or load JSON")
//            return []
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
            print(questionList.t_qs.count)
//            return questionList.t_qs
            return
        } catch {
            print("Decoding error:", error)
//            return []
            return
        }
    }
//    
    func isDataMissing() {
        if questions.count < 10267 {
            loadQuestions()
        }
    }
}

#Preview {
    ContentView()
}
