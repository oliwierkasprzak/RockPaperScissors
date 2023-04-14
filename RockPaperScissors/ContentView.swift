//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Oliwier Kasprzak on 14/04/2023.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✊", "✋", "✌️"]
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var showingResults = false
    @State private var questionCount = 1
    
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Computer's choice")
                    .font(.title2.bold())
                    .foregroundColor(.cyan)
                
                Text(moves[computerChoice])
                    .font(.system(size: 120))
                if shouldWin {
                    Text("Which one wins?")
                        .font(.headline)
                        .foregroundColor(.green)
                } else {
                    Text("Which one loses?")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            play(choice: number)
                        } label: {
                            Text(moves[number])
                                .font(.system(size: 80))
                        }
                    }
                }
                Spacer()
                Text("Score: \(score)")
                    .padding(5)
                    .foregroundColor(.cyan)
                    .font(.title2.bold())
                    .background(Color.white.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                Spacer()
            }
            .alert("The game is over!", isPresented: $showingResults) {
                Button("Play again?", action: restart)
            } message: {
                Text("Final score is \(score) ")
            }
        }
    }
    
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        var didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == 8 {
            showingResults = true
        } else {
            computerChoice = Int.random(in: 0..<3)
            questionCount += 1
            shouldWin.toggle()
        }
    }
    
    func restart() {
        score = 0
        questionCount = 1
        computerChoice = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
