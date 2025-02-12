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
        VStack {
            Text("Is this number prime?")
                .font(.title)
                .padding()
            
            Text("\(number)") // Display the random number
                .font(.system(size: 60, weight: .bold))
                .padding()
            
            HStack {
                Button("Prime") {
                    checkAnswer(isPrime: true)
                }
                .font(.title)
                .frame(width: 120, height: 50)
                .background(isAnswered ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(isAnswered) // Disable after first selection
                
                Button("Not Prime") {
                    checkAnswer(isPrime: false)
                }
                .font(.title)
                .frame(width: 120, height: 50)
                .background(isAnswered ? Color.gray : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(isAnswered) // Disable after first selection
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
