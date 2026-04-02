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
    @State private var slideOffset: CGFloat = 0
    @State private var cardOpacity: Double = 1

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
                     .animation(.easeInOut(duration: 0.4), value: questionIndex)

                 HStack {
                     Text("\(questionIndex + 1)/\(sampleQuestions.count)")
                         .font(.subheadline.bold())
                         .foregroundStyle(darkPurple.opacity(0.7))

                     Spacer()

                     Text("Score: \(score)")
                         .font(.subheadline.bold())
                         .foregroundStyle(darkPurple)
                 }
             }
             .padding(.horizontal, 40)

            // Question card + answers
            VStack(spacing: 24) {
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
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedAnswer = option
                            }
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
                        .disabled(answered)
                        .scaleEffect(selectedAnswer == option ? 1.03 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedAnswer)
                    }
                }
                .padding(.horizontal, 30)
            }
            .offset(x: slideOffset)
            .opacity(cardOpacity)

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
                    .background(selectedAnswer == nil || answered ? cardColor.opacity(0.4) : cardColor)
                    .clipShape(Capsule())
            }
            .disabled(selectedAnswer == nil || answered)
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
        .padding(.top, 20)
    }

    func checkAnswer(question: Question) {
        guard !answered else { return }
        answered = true

        let isCorrect = selectedAnswer == question.correctAnswer
        let isLastQuestion = questionIndex >= sampleQuestions.count - 1

        Task { @MainActor in
            // Show green/red for 0.8s
            try? await Task.sleep(for: .milliseconds(800))

            if isCorrect {
                score += 1
            }

            // Slide out to the left
            withAnimation(.easeIn(duration: 0.25)) {
                slideOffset = -400
                cardOpacity = 0
            }

            try? await Task.sleep(for: .milliseconds(300))

            // Reset state for next question
            selectedAnswer = nil
            answered = false

            // Advance to next question or result
            if isLastQuestion {
                slideOffset = 0
                cardOpacity = 1
                withAnimation(.easeInOut(duration: 0.35)) {
                    screen = .result
                }
            } else {
                questionIndex += 1

                // Position off-screen right (no animation)
                slideOffset = 400
                cardOpacity = 0

                // Small delay so SwiftUI registers the new position
                try? await Task.sleep(for: .milliseconds(50))

                // Slide in from the right
                withAnimation(.easeOut(duration: 0.3)) {
                    slideOffset = 0
                    cardOpacity = 1
                }
            }
        }
    }
    
    func buttonColor(for option: String, question: Question) -> Color {
        guard selectedAnswer == option else {
            return pillColor.opacity(0.5)
        }
        if !answered {
            return cardColor.opacity(0.7)
        }
        return option == question.correctAnswer ? Color.green.opacity(0.7) : Color.red.opacity(0.7)
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
