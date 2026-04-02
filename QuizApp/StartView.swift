//
//  StartView.swift
//  QuizApp
//
//  Created by Urwa Adil on 2026-03-30.
//

import SwiftUI

struct StartView: View {
    @Binding var screen: Screen
    //  bind to saved score
    @AppStorage("lastScore") private var lastScore = 0

    var body: some View {
        VStack {
            Spacer()
            NameFieldSnippet()
            

            VStack(spacing: 16) {
                
                Text("Last Score: \(lastScore)")
                    .font(.footnote.bold())
                    .foregroundStyle(.white)
                       .padding(.horizontal, 16)
                       .padding(.vertical, 8)
                       .background(Color(red: 0.62, green: 0.49, blue: 0.70))
                       .clipShape(Capsule())
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
