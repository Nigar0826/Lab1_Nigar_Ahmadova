//
//  ContentView.swift
//  Lab1_Nigar_Ahmadova
//
//  Created by Nigar Ahmadova on 2025-02-12.
//

import SwiftUI

struct ContentView: View {
    @State private var number = Int.random(in: 1...100)
    @State private var isAnswered = false
    @State private var score = 0
    @State private var resultMessage = ""
    @State private var totalAttempts = 0
    @State private var correctAnswers = 0
    @State private var gameOver = false
    @State private var showSummary = false
    @State private var showStartScreen = true // Toggle for the start screen

    var body: some View {
        ZStack {
            Color(.systemTeal)
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)

            if showStartScreen {
                // "Start Game" button
                Button(action: {
                    restartGame()
                }) {
                    Text("Start Game")
                        .font(.title)
                        .frame(width: 200, height: 60)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
            } else {
                // Main Game UI
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

                    Text(resultMessage)
                        .font(.title2)
                        .bold()
                        .foregroundColor(isAnswered ? (resultMessage.contains("✅") ? .green : .red) : .clear)
                        .padding()

                    HStack(spacing: 20) {
                        Button(action: { checkAnswer(isPrime: true) }) {
                            Text("Prime")
                                .font(.title)
                                .frame(width: 150, height: 60)
                                .background(isAnswered ? Color.gray.opacity(0.6) : Color.blue.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                        }
                        .disabled(isAnswered)

                        Button(action: { checkAnswer(isPrime: false) }) {
                            Text("Not Prime")
                                .font(.title)
                                .frame(width: 150, height: 60)
                                .background(isAnswered ? Color.gray.opacity(0.6) : Color.pink.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                        }
                        .disabled(isAnswered)
                    }
                    .padding(.top, 10)

                    Button(action: {
                        if totalAttempts == 10 {
                            showSummary = true
                        } else {
                            generateNewNumber()
                        }
                    }) {
                        Text(totalAttempts == 10 ? "Finish Game" : "Next Number")
                            .font(.title2)
                            .frame(width: 180, height: 50)
                            .background(Color.green.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 10)
                    .disabled(!isAnswered)
                }
            }

            // Overlay Summary Dialog
            if showSummary {
                VStack(spacing: 20) {
                    Text("⏳ Game Over!")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)

                    Text("✔️ Correct Answers: \(correctAnswers)/10")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.black)

                    Text("🏅 Final Score: \(score)")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.black)

                    Button(action: {
                        showSummary = false
                        showStartScreen = true // Navigate to start screen
                    }) {
                        Text("OK")
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 10)
                }
                .frame(width: 300, height: 250)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        }
    }

    // Prime Number Checker
    func isPrime(_ num: Int) -> Bool {
        if num < 2 { return false }
        for i in 2..<num {
            if num % i == 0 {
                return false
            }
        }
        return true
    }

    // Show last answer, then display summary
    func checkAnswer(isPrime: Bool) {
        guard totalAttempts < 10 else { return }

        let correctAnswer = self.isPrime(self.number)
        isAnswered = true
        totalAttempts += 1

        if isPrime == correctAnswer {
            score += 1
            correctAnswers += 1
            resultMessage = "✅ Correct! \(number) is \(correctAnswer ? "Prime" : "Not Prime")"
        } else {
            score -= 1
            resultMessage = "❌ Wrong! \(number) is actually \(correctAnswer ? "Prime" : "Not Prime")"
        }
    }

    // Generate a new number
    func generateNewNumber() {
        if totalAttempts < 10 {
            number = Int.random(in: 1...100)
            isAnswered = false
            resultMessage = ""
        }
    }

    // Restart game and go to start screen
    func restartGame() {
        number = Int.random(in: 1...100)
        isAnswered = false
        resultMessage = ""
        score = 0
        totalAttempts = 0
        correctAnswers = 0
        gameOver = false
        showSummary = false
        showStartScreen = false // Move user back into game
    }
}

