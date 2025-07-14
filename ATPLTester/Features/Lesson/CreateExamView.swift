//
//  CreateExamView.swift
//  ATPLTester
//
//  Created by ali cihan on 7.05.2025.
//

import SwiftUI
import SwiftData

enum QuestionSource: CaseIterable {
    case bristolV2, bristolV3, cat, lucia
}

struct CreateExamView: View {
    @Binding var questionCount: Int
    let createExam: ([QuestionSource]) -> ()
    @State var questionSources: [QuestionSource] = QuestionSource.allCases
    
    var body: some View {
       VStack {
           questionCountPicker
           questionSource
           Spacer()
           createExamButton
          
       }
    }
    
    private var questionSource: some View {
        VStack {
            Text("Question Source:")
                .bold()
            Group {
                bristolV2CheckButton
                bristolV3CheckButton
                luciaCheckButton
                catCheckButton
            }
            .font(.title3)
        }
        .padding()
    }
    
    private var bristolV2CheckButton: some View {
        HStack {
            Text("Bristol V2")
            Spacer()
            Button {
                checkButtonHandler(for: .bristolV2)
            } label: {
                checkMarkImage(for: .bristolV2)
            }
        }
    }
    
    private var bristolV3CheckButton: some View {
        HStack {
            Text("Bristol V3")
            Spacer()
            Button {
                checkButtonHandler(for: .bristolV3)
            } label: {
                checkMarkImage(for: .bristolV3)
            }
        }
    }
    
    private var luciaCheckButton: some View {
        HStack {
            Text("Lucia")
            Spacer()
            Button {
                checkButtonHandler(for: .lucia)
            } label: {
                checkMarkImage(for: .lucia)
            }
        }
    }
    
    private var catCheckButton: some View {
        HStack {
            Text("Cat")
            Spacer()
            Button {
                checkButtonHandler(for: .cat)
            } label: {
                checkMarkImage(for: .cat)
            }
        }
    }
    
    private var questionCountPicker: some View {
        VStack{
            Text("Question Count")
                .bold()
            Picker("Question Count", selection: $questionCount) {
                ForEach([10,20,30,40,50], id: \.self) { value in
                    Text("\(value)")
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }
    
    private var createExamButton: some View {
        Button {
            createExam(questionSources)
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.gray)
                .frame(height: 50)
                .overlay {
                    Text("Create Exam")
                        .bold()
                        .font(.headline)
                        .tint(.primary)
                }
                .padding()
        }
    }
    
    private func checkButtonHandler(for questionSource: QuestionSource) {
        questionSources.contains(questionSource) ? questionSources.removeAll(where: {$0 == questionSource}) : questionSources.append(questionSource)
    }
    
    private func checkMarkImage(for questionSource: QuestionSource) -> some View {
        Image(systemName: !questionSources.contains(questionSource) ? "square" : "checkmark.square.fill")
            .resizable()
            .frame(width: 40, height: 40)
    }
}

//#Preview {
//    CreateExamView()
//}
