//
//  Question.swift
//  QuizApp
//
//  Created by Isaac Strandh on 2026-03-30.
//

import Foundation

/// Represents a single quiz question with multiple-choice answers.
struct Question: Identifiable {
    let id: Int
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int

    /// Returns the correct answer string safely.
    var correctAnswer: String? {
        answers.indices.contains(correctAnswerIndex) ? answers[correctAnswerIndex] : nil
    }
}
