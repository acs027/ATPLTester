//
//  FigureView.swift
//  ATPLTester
//
//  Created by ali cihan on 12.05.2025.
//

import SwiftUI

struct FigureView: View {
    let figureID: String

    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @GestureState private var gestureScale: CGFloat = 1.0
    @GestureState private var dragOffset: CGSize = .zero

    var body: some View {
        Image(figureID)
            .resizable()
            .scaledToFit()
            .scaleEffect(scale * gestureScale)
            .offset(x: offset.width + dragOffset.width, y: offset.height + dragOffset.height)
            .gesture(
                SimultaneousGesture(
                    MagnificationGesture()
                        .updating($gestureScale) { currentState, gestureState, _ in
                            gestureState = currentState
                        }
                        .onEnded { finalScale in
                            scale *= finalScale
                        },
                    DragGesture()
                        .updating($dragOffset) { current, gestureState, _ in
                            gestureState = current.translation
                        }
                        .onEnded { finalOffset in
                            offset.width += finalOffset.translation.width
                            offset.height += finalOffset.translation.height
                        }
                )
            )
            .animation(.easeInOut(duration: 0.2), value: scale)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.8))
            .edgesIgnoringSafeArea(.all)
    }
}
