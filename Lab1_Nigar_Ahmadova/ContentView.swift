//
//  ContentView.swift
//  Lab1_Nigar_Ahmadova
//
//  Created by Nigar Ahmadova on 2025-02-12.
//

import SwiftUI

struct ContentView: View {
    @State private var number = Int.random(in: 1...100) // Generate a random number

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
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Not Prime") {
                    checkAnswer(isPrime: false)
                }
                .font(.title)
                .frame(width: 120, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }

    // ✅ Prime Number Checker Function
    func isPrime(_ num: Int) -> Bool {
        if num < 2 { return false }
        for i in 2..<num {
            if num % i == 0 {
                return false
            }
        }
        return true
    }

    // ✅ Now checkAnswer() explicitly refers to self.isPrime(number)
    func checkAnswer(isPrime: Bool) {
        let correctAnswer = self.isPrime(self.number)  // Fixed the function call

        if isPrime == correctAnswer {
            print("✅ Correct! \(number) is \(isPrime ? "Prime" : "Not Prime").")
        } else {
            print("❌ Wrong! \(number) is actually \(correctAnswer ? "Prime" : "Not Prime").")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
