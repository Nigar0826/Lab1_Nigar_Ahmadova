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

    var body: some View {
        ZStack {
            Color(.systemTeal)
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text("Is this number prime?")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 5)
                
                // Number display inside a rounded card
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 220, height: 120)
                    .overlay(
                        Text("\(number)")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color(.systemIndigo))
                    )
                    .shadow(radius: 10)
                
                HStack(spacing: 20) {
                    Button(action: {
                        checkAnswer(isPrime: true)
                    }) {
                        Text("Prime")
                            .font(.title)
                            .frame(width: 150, height: 60)
                            .background(isAnswered ? Color.gray.opacity(0.6) : Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                    .disabled(isAnswered)
                    
                    Button(action: {
                        checkAnswer(isPrime: false)
                    }) {
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
                .padding(.top, 20)

                // New round button
                Button(action: {
                    generateNewNumber()
                }) {
                    Text("Next Number")
                        .font(.title2)
                        .frame(width: 180, height: 50)
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
                .padding(.top, 10)
                .disabled(!isAnswered) // Only enable after answering
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

    // Check user answer and disable buttons after first choice
    func checkAnswer(isPrime: Bool) {
        let correctAnswer = self.isPrime(self.number)
        isAnswered = true // Disable buttons after answering

        if isPrime == correctAnswer {
            print("Correct! \(number) is \(correctAnswer ? "Prime" : "Not Prime").")
        } else {
            print("Wrong! \(number) is actually \(correctAnswer ? "Prime" : "Not Prime").")
        }
    }

    // Generate a new number and reset state
    func generateNewNumber() {
        number = Int.random(in: 1...100) // Generate a new number
        isAnswered = false // Reset button state
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
