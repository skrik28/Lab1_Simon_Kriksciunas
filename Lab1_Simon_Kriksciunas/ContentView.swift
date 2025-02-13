//
//  ContentView.swift
//  Lab1_Simon_Kriksciunas
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var gameViewModel = GameViewModel()
    
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                
                // Score display
                Text("Score: \(gameViewModel.correctAnswers)/\(gameViewModel.totalAttempts)")
                    .font(.title2)
                    .foregroundColor(.blue)
                
                // Number display
                Text("\(gameViewModel.currentNumber)")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(.black)
                
                // Answer buttons
                HStack(spacing: 40){
                    
                    // Is Prime button
                    Button(action: {gameViewModel.checkAnswer(isPrime: true)}){
                        Text("Prime")
                    }
                    
                    // Is Not Prime button
                    Button(action: {gameViewModel.checkAnswer(isPrime: false)}){
                        Text("Not Prime")
                    }
                    
                    
                }
                
                // Timer display
                
                
                
            }
            
        }
        .padding()
        
        // Results dialog
    }
}


class GameViewModel : ObservableObject{
    @Published var currentNumber = 0
    @Published var timeRemaining: Double = 5.0
    @Published var correctAnswers = 0
    @Published var totalAttempts = 0
    @Published var lastAnswerCorrect: Bool?
    
    private var roundLength = 10
    
    func startGame(){
        
    }
    
    private func generateNewNumber(){
        currentNumber = Int.random(in: 2...100)
        timeRemaining = 5.0
    }
    
    
    
    func checkAnswer(isPrime: Bool){
        let isActuallyPrime = isPrimeNumber(currentNumber)
        lastAnswerCorrect = isPrime == isActuallyPrime
        
        if lastAnswerCorrect == true {
            correctAnswers += 1
        }
        
        totalAttempts += 1
        
        if totalAttempts == roundLength{
            
            // show results
            
        } else {
            generateNewNumber()
        }
        
    }
    
    private func isPrimeNumber(_ number: Int) -> Bool {
        if number <= 1 {return false}
        if number <= 3 {return true}
        
        for i in 2...Int(Double(number).squareRoot()){
            if number % i == 0 {
                return false
            }
        }
        return true
    }
}

#Preview {
    ContentView()
}
