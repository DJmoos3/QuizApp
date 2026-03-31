//
//  name.swift
//  QuizApp
//
//  Created by Urwa Adil on 2026-03-30.
//

import SwiftUI

struct NameFieldSnippet: View {
    @State private var name = ""

    var body: some View {
        TextField("Ditt namn", text: $name)
        Text("Hej, \(name.isEmpty ? "…" : name)!")
    }
}
