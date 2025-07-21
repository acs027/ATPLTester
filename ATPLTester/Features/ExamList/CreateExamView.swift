//
//  CreateExamView.swift
//  ATPLTester
//
//  Created by ali cihan on 7.05.2025.
//
import SwiftUI
import SwiftData

struct CreateExamView: View {
    @Binding var questionCount: Int
    let createExam: ([QuestionSource]) -> ()

    @State private var questionSources: [QuestionSource] = QuestionSource.allCases

    var body: some View {
        VStack(spacing: 24) {
            questionCountPicker
            questionSourceSection
            Spacer()
            createExamButton
        }
        .padding()
    }

    // MARK: - Question Count Picker

    private var questionCountPicker: some View {
        VStack(spacing: 8) {
            Text("Question Count")
                .font(.headline)
            Picker("Question Count", selection: $questionCount) {
                ForEach([10, 20, 30, 40, 50], id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.segmented)
        }
    }

    // MARK: - Question Sources

    private var questionSourceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Question Source")
                .font(.headline)
            ForEach(QuestionSource.allCases, id: \.self) { source in
                checkButton(for: source)
            }
        }
    }

    private func checkButton(for source: QuestionSource) -> some View {
        HStack {
            Text("\(source)")
                .font(.title3)
            Spacer()
            Button {
                toggleSource(source)
            } label: {
                Image(systemName: questionSources.contains(source) ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.blue)
            }
        }
        .contentShape(Rectangle()) // makes whole row tappable
        .onTapGesture {
            toggleSource(source)
        }
    }

    // MARK: - Create Exam Button

    private var createExamButton: some View {
        Button {
            createExam(questionSources)
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.accentColor.opacity(0.2))
                .frame(height: 50)
                .overlay(
                    Text("Create Exam")
                        .font(.headline)
                        .foregroundColor(.primary)
                )
        }
        .padding(.top)
    }

    // MARK: - Logic

    private func toggleSource(_ source: QuestionSource) {
        if questionSources.contains(source) {
            questionSources.removeAll { $0 == source }
        } else {
            questionSources.append(source)
        }
    }
}
