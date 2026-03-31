//
//  StartView.swift
//  QuizApp
//
//  Created by Urwa Adil on 2026-03-30.
//

import SwiftUI

struct StartView: View {
    @Binding var screen: Screen

    var body: some View {
        VStack(spacing: 20) {
            Text("Quiz App")
                .font(.largeTitle)
                .bold()

            Button("Start Quiz") {
                screen = .quiz
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
