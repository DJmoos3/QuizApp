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
        VStack {
            Spacer()

            VStack(spacing: 16) {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 80))
                    .foregroundStyle(Color(red: 0.45, green: 0.30, blue: 0.60))

                Text("QUIZ")
                    .font(.system(size: 52, weight: .bold))
                    .foregroundStyle(Color(red: 0.45, green: 0.30, blue: 0.60))
            }

            Spacer()

            Button {
                screen = .quiz
            } label: {
                Text("START")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.62, green: 0.49, blue: 0.70))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .padding()
    }
}
