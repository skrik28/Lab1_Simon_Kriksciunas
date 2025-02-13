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
//                Text("Score: \(gameViewModel.correctAnswers)/\(gameViewModel.totalAttempts)")
//                    .font(.title2)
//                    .foregroundColor(.blue)
                
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
                
                
                
                // Feedback icon
                if let isCorrect = gameViewModel.lastAnswerCorrect {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(isCorrect ? .green : .red)
                        .font(.system(size: 60))
                }
                
                
                
            }
            .padding()
            
            // Results dialog
            if gameViewModel.showingResults {
                ResultsDialog(correctAnswers: gameViewModel.correctAnswers,
                              wrongAnswers: gameViewModel.totalAttempts - gameViewModel.correctAnswers,
                              isPresented: $gameViewModel.showingResults,
                              onDismiss: {gameViewModel.startNewRound()})
            }
            
        }
        .onAppear {
            gameViewModel.startGame()
        }
    }
}

struct ResultsDialog: View {
    
    let correctAnswers: Int
    let wrongAnswers: Int
    @Binding var isPresented: Bool
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20){
                Text("Round Results").font(.title).bold()
                
                Text("Correct Answers: \(correctAnswers)").font(.title2)
                
                Text("Wrong Answers: \(wrongAnswers)").font(.title2)
                
                Button("Continue") {
                    isPresented = false
                    onDismiss()
                }
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
}


class GameViewModel : ObservableObject{
    @Published var currentNumber = 0
    @Published var timeRemaining: Double = 5.0
    @Published var correctAnswers = 0
    @Published var totalAttempts = 0
    @Published var lastAnswerCorrect: Bool?
    @Published var showingResults = false
    
    private var roundLength = 10
    
    func startGame(){
        generateNewNumber()
        // start timer
    }
    
    func startNewRound() {
        correctAnswers = 0
        totalAttempts = 0
        lastAnswerCorrect = nil
        generateNewNumber()
        // start timer
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
            showingResults = true
            
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
