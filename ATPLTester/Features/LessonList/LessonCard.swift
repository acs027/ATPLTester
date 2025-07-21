//
//  LessonCardView.swift
//  ATPLTester
//
//  Created by Ali Cihan on 15.07.2025.
//

import SwiftUI

struct LessonCard: View {
    let lesson: Lesson
    
    var body: some View {
        HStack {
            Text(lesson.name)
                .font(.title)
                .bold()
                .tint(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 100)
                
            Text("\(lesson.rawValue)")
                .font(.system(size: 70))
                .bold()
                .foregroundStyle(.white)
                .opacity(0.5)
                .padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.blue)
        )
    }
}

#Preview {
    LessonCard(lesson: .airLaw)
}
