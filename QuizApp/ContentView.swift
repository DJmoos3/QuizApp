//
//  ContentView.swift
//  QuizApp
//
//  Created by Isaac Strandh on 2026-03-30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentScore: Int = 0
    @State private var highScore: Int = 0
    @State private var isCorrect = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Example button"){
                if isCorrect{
                    currentScore += 1
                }else{
                    highScore = currentScore
                }
            }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
