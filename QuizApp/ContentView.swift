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
    
    // Stores the user's last score persistently using UserDefaults.
    // The @AppStorage property wrapper automatically reads/writes the value
    // associated with the key "lastScore" so it persists across app launches.
    @AppStorage("lastScore") private var lastScore = 0 

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.91, green: 0.85, blue: 0.96),
                    Color(red: 0.82, green: 0.74, blue: 0.92)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

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
        }
    }


#Preview {
    ContentView()
}
