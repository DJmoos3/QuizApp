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
    
    var onRestart: (() -> Void)? = nil

    @State private var showTrophy = false
    @State private var showScore = false
    @State private var showButton = false

    private let cardColor = Color(red: 0.62, green: 0.49, blue: 0.70)
    private let darkPurple = Color(red: 0.45, green: 0.30, blue: 0.60)

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 20) {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(darkPurple)
                    .scaleEffect(showTrophy ? 1.0 : 0.3)
                    .opacity(showTrophy ? 1.0 : 0.0)

                Text("Finished!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(darkPurple)
                    .opacity(showTrophy ? 1.0 : 0.0)

                Text("\(score) / \(total)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .scaleEffect(showScore ? 1.0 : 0.5)
                    .opacity(showScore ? 1.0 : 0.0)
            }

            Spacer()

            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onRestart?()
                    screen = .start
                }
            } label: {
                Text("PLAY AGAIN")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(cardColor)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
            .offset(y: showButton ? 0 : 60)
            .opacity(showButton ? 1.0 : 0.0)
        }
        .padding()
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.1)) {
                showTrophy = true
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.4)) {
                showScore = true
            }
            withAnimation(.easeOut(duration: 0.4).delay(0.7)) {
                showButton = true
            }
        }
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

        ResultView(score: 6, total: 8, screen: .constant(.result))
    }
}
