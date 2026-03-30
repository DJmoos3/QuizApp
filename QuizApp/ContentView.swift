//
//  ContentView.swift
//  QuizApp
//
//  Created by Isaac Strandh on 2026-03-30.
//

import SwiftUI

struct ContentView: View {
    @State private var screen: Screen = .start
    @State private var score = 0
    @State private var questionIndex = 0

    var body: some View {
        VStack {
            switch screen {
            case .start:
                StartView(screen: $screen)

            case .quiz:
                QuizView(
                    screen: $screen,
                    score: $score,
                    questionIndex: $questionIndex
                )

            case .result:
                ResultView(score: score, total: sampleQuestions.count, screen: $screen)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
