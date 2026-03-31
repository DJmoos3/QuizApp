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
                Text("Vad heter du?")
                    .font(.headline)

                TextField("Skriv ditt namn här", text: $name)
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.62, green: 0.49, blue: 0.70))
                    .clipShape(Capsule())

                Button("OK") {
                    confirmedName = name
                }
                .disabled(name.isEmpty)

            } else {
                Text("Hej, \(confirmedName)!")
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .padding()
    }
}
