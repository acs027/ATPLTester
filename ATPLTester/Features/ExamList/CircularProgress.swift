import SwiftUI

struct CircularProgress: View {
    var correct: Double
    var incorrect: Double
    var total: Double
    
    var lineWidth: CGFloat = 14
    var radius: CGFloat = 50
    
    private var progress: Double {
        min((correct + incorrect) / total, 1.0)
    }
    
    private var correctRatio: Double {
        min(correct / total, 1.0)
    }
    
    var body: some View {
        ZStack {
            backgroundCircle
            incorrectProgressArc
            correctProgressArc
            centerLabel
        }
        .frame(width: radius * 2, height: radius * 2)
    }
    
    /// Background circle with ultra-thin material and soft shadow
    private var backgroundCircle: some View {
        Circle()
            .stroke(lineWidth: lineWidth)
            .foregroundStyle(.ultraThinMaterial)
            .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
    }
    
    /// Arc for incorrect answers (below the correct arc)
    private var incorrectProgressArc: some View {
        Circle()
            .trim(from: 0.0, to: progress)
            .stroke(Color.red.opacity(0.6),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt))
            .rotationEffect(.degrees(-90))
            .animation(.easeInOut(duration: 0.6), value: progress)
    }
    
    /// Arc for correct answers (on top of incorrect arc)
    private var correctProgressArc: some View {
        Circle()
            .trim(from: 0.0, to: correctRatio)
            .stroke(AngularGradient(gradient: Gradient(colors: [
                Color.green, Color.green.opacity(0.6)
            ]), center: .center),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt))
            .rotationEffect(.degrees(-90))
            .animation(.easeInOut(duration: 0.6), value: correctRatio)
    }
    
    /// Center text label showing the percentage and optional subtitle
    private var centerLabel: some View {
        Text("\(Int(progress * 100))%")
            .font(.system(size: radius/2, weight: .semibold, design: .rounded))
    }
}

#Preview {
    CircularProgress(correct: 6, incorrect: 2, total: 10)
        .padding()
        .preferredColorScheme(.light)
}
