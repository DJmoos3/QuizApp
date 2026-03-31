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

    private let cardColor = Color(red: 0.62, green: 0.49, blue: 0.70)
    private let darkPurple = Color(red: 0.45, green: 0.30, blue: 0.60)

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 20) {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(darkPurple)

                Text("Finished!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(darkPurple)

                Text("\(score) / \(total)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            Spacer()

            Button {
                screen = .start
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
        }
        .padding()
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
