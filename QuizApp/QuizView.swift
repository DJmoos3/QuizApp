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
    @State private var answered = false

    private let letters = ["A", "B", "C", "D"]
    private let cardColor = Color(red: 0.62, green: 0.49, blue: 0.70)
    private let pillColor = Color(red: 0.72, green: 0.62, blue: 0.80)
    private let darkPurple = Color(red: 0.45, green: 0.30, blue: 0.60)

    var body: some View {
        let question = sampleQuestions[questionIndex]

        VStack(spacing: 24) {
            
            VStack(spacing: 8) {
                 ProgressView(value: Double(questionIndex + 1), total: Double(sampleQuestions.count))
                     .tint(darkPurple)

                 Text("Score: \(score)")
                     .font(.subheadline.bold())
                     .foregroundStyle(darkPurple)
             }
             .padding(.horizontal, 40)
            // Question card
            VStack(spacing: 12) {
                Text("Fråga \(questionIndex + 1) av \(sampleQuestions.count)")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white.opacity(0.8))

                Text(question.text)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
            }
            .padding(.vertical, 28)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(cardColor)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding(.horizontal, 20)

            // Answer options
            VStack(spacing: 12) {
                ForEach(Array(question.answers.enumerated()), id: \.offset) { index, option in
                    Button {
                        selectedAnswer = option
                    } label: {
                        HStack(spacing: 14) {
                            Text(letters[index])
                                .font(.callout.bold())
                                .foregroundStyle(darkPurple)
                                .frame(width: 32, height: 32)
                                .background(Color.white)
                                .clipShape(Circle())

                            Text(option)
                                .font(.body)
                                .foregroundStyle(darkPurple)

                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(buttonColor(for: option, question: question))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(selectedAnswer == option ? Color.white : Color.clear, lineWidth: 2)
                        )
                    }
                }
            }
            .padding(.horizontal, 30)

            Spacer()

            // Next button
            Button {
                checkAnswer(question: question)
            } label: {
                Text("Next")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(selectedAnswer == nil ? cardColor.opacity(0.4) : cardColor)
                    .clipShape(Capsule())
            }
            .disabled(selectedAnswer == nil)
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
        .padding(.top, 20)
    }

    func checkAnswer(question: Question) {
        answered = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {  // creates a delay before changing screen so you can see the colour change
            if selectedAnswer == question.correctAnswer {
                score += 1
            }

            selectedAnswer = nil
            answered = false

            if questionIndex < sampleQuestions.count - 1 {
                questionIndex += 1
            } else {
                screen = .result
            }
        }
    }
    
    func buttonColor(for option: String, question: Question) -> Color {
        guard selectedAnswer == option else {
            return pillColor.opacity(0.5)  // Colour stays the same if not selected
        }
        if !answered {
            return cardColor.opacity(0.7)  // Colour change after being selected
        }
        return option == question.correctAnswer ? Color.green.opacity(0.7) : Color.red.opacity(0.7) // This changes the colour into red or green depending on whether the answer is correct or not
    }
}

#Preview {
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

        QuizView(screen: .constant(.quiz), score: .constant(0), questionIndex: .constant(0))
    }
}
