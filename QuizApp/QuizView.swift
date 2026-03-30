//
//  QuizView.swift
//  QuizApp
//
//  Created by Urwa Adil on 2026-03-30.
//
import SwiftUI

struct QuizView: View {
    @Binding var screen: Screen
    @Binding var score: Int
    @Binding var questionIndex: Int

    @State private var selectedAnswer: String? = nil

    var body: some View {
        let question = sampleQuestions[questionIndex]

        VStack(spacing: 20) {
            Text("Question \(questionIndex + 1)")
                .font(.headline)

            Text(question.text)
                .font(.title3)

            ForEach(question.answers, id: \.self) { option in
                Button(option) {
                    selectedAnswer = option
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedAnswer == option ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                .cornerRadius(10)
            }

            Button("Next") {
                checkAnswer(question: question)
            }
            .disabled(selectedAnswer == nil)

            Text("Score: \(score)")
                .font(.body)
        }
    }

    func checkAnswer(question: Question) {
        if selectedAnswer == question.correctAnswer {
            score += 1
        }

        selectedAnswer = nil

        if questionIndex < sampleQuestions.count - 1 {
            questionIndex += 1
        } else {
            screen = .result
        }
    }
}
