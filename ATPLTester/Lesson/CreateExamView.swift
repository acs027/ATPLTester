//
//  CreateExamView.swift
//  ATPLTester
//
//  Created by ali cihan on 7.05.2025.
//

import SwiftUI


struct CreateExamView: View {
    @Binding var questionCount: Int
    let createExam: () -> ()
    
    var body: some View {
       VStack {
           questionCountPicker
           Spacer()
           createExamButton
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
            createExam()
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
}

//#Preview {
//    CreateExamView()
//}
