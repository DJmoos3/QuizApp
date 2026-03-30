//
//  ResultView.swift
//  QuizApp
//
//  Created by Urwa Adil on 2026-03-30.
//
import SwiftUI

struct ResultView: View {
    let score: Int
    let total: Int
    @Binding var screen: Screen

    var body: some View {
        VStack(spacing: 20) {
            Text("Finished!")
                .font(.largeTitle)

            Text("Score: \(score)/\(total)")
                .font(.title)

            Button("Play Again") {
                screen = .start
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
