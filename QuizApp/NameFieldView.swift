//
//  name.swift
//  QuizApp
//
//  Created by Urwa Adil on 2026-03-30.
//

import SwiftUI

struct NameFieldSnippet: View {
    @State private var name = ""
    @State private var confirmedName = ""

    var body: some View {
        VStack(spacing: 16) {

            if confirmedName.isEmpty {
                Text("What should we call you?")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color(red: 0.45, green: 0.30, blue: 0.60))

                TextField("Enter your name here...", text: $name, prompt: Text("Enter your name here...").foregroundStyle(.white.opacity(0.7)))
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 24)
                    .background(Color(red: 0.62, green: 0.49, blue: 0.70))
                    .clipShape(Capsule())

                Button {
                    confirmedName = name
                } label: {
                    Text("OK")
                        .font(.body.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color(red: 0.62, green: 0.49, blue: 0.70))
                        .clipShape(Capsule())
                }
                .disabled(name.isEmpty)
                .opacity(name.isEmpty ? 0.5 : 1.0)

            } else {
                Text("Hello,\(confirmedName)! Good Luck!")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color(red: 0.45, green: 0.30, blue: 0.60))
            }
        }
        .padding()
    }
}
