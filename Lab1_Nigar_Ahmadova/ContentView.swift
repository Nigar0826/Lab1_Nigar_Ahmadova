//
//  ContentView.swift
//  Lab1_Nigar_Ahmadova
//
//  Created by Nigar Ahmadova on 2025-02-12.
//

import SwiftUI

struct ContentView: View {
    @State private var number = Int.random(in: 1...100) // Generate a random number
    @State private var isAnswered = false // Track if the user already selected an answer
    @State private var score = 0 // User score
    @State private var resultMessage = "" // Message to display result
    @State private var totalAttempts = 0 // Total number of attempts
    @State private var correctAnswers = 0 // Count of correct answers
    @State private var gameOver = false // Track game state

    var body: some View {
        ZStack {
            Color(.systemTeal)
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                HStack {
                    Text("Score: \(score)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    Text("Attempts: \(totalAttempts)/10")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                }
                .padding(.horizontal, 30)

                Text("Is this number prime?")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 5)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 220, height: 120)
                    .overlay(
                        Text("\(number)")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color(.systemIndigo))
                    )
                    .shadow(radius: 10)

                // Display result message
                Text(resultMessage)
                    .font(.title2)
                    .bold()
                    .foregroundColor(isAnswered ? (resultMessage.contains("✅") ? .green : .red) : .clear)
                    .padding()
                
                HStack(spacing: 20) {
                    Button(action: {
                        checkAnswer(isPrime: true)
                    }) {
                        Text("Prime")
                            .font(.title)
                            .frame(width: 150, height: 60)
                            .background(isAnswered || gameOver ? Color.gray.opacity(0.6) : Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                    .disabled(isAnswered || gameOver)
                    
                    Button(action: {
                        checkAnswer(isPrime: false)
                    }) {
                        Text("Not Prime")
                            .font(.title)
                            .frame(width: 150, height: 60)
                            .background(isAnswered || gameOver ? Color.gray.opacity(0.6) : Color.pink.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                    .disabled(isAnswered || gameOver)
                }
                .padding(.top, 10)

                Button(action: {
                    generateNewNumber()
                }) {
                    Text("Next Number")
                        .font(.title2)
                        .frame(width: 180, height: 50)
                        .background(gameOver ? Color.gray.opacity(0.6) : Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
                .padding(.top, 10)
                .disabled(!isAnswered || gameOver) // Disabled if game is over
            }
            .padding()
        }
    }

    // Prime Number Checker Function
    func isPrime(_ num: Int) -> Bool {
        if num < 2 { return false }
        for i in 2..<num {
            if num % i == 0 {
                return false
            }
        }
        return true
    }

    // Check user answer, update score, and track attempts
    func checkAnswer(isPrime: Bool) {
        guard totalAttempts < 10 else { return } // Prevent extra attempts

        let correctAnswer = self.isPrime(self.number)
        isAnswered = true
        totalAttempts += 1

        if isPrime == correctAnswer {
            score += 1
            correctAnswers += 1
            resultMessage = "✅ \(correctAnswer ? "Prime" : "Not Prime")"
        } else {
            score -= 1
            resultMessage = "❌ \(correctAnswer ? "Prime" : "Not Prime")"
        }

        // ✅ Stop game after 10 attempts
        if totalAttempts == 10 {
            gameOver = true
            print("Game Over! Total Attempts: \(totalAttempts), Correct Answers: \(correctAnswers)")
        }
    }

    // Generate a new number and reset state
    func generateNewNumber() {
        if totalAttempts < 10 {
            number = Int.random(in: 1...100) // Generate a new number
            isAnswered = false
            resultMessage = ""
        }
    }
}
