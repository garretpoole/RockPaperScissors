//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Garret Poole on 2/14/22.
//

import SwiftUI
struct ChoiceImage: View{
    var choice: String
    
    var body: some View{
        Text(choice)
            .frame(maxWidth: .infinity)
            .font(.system(size: 70))
            .padding(.vertical, 10)
            .overlay(RoundedRectangle(cornerRadius: 90)
                        .stroke(Color.brown))
            .background(.thinMaterial)
            .cornerRadius(90)
    }
}

struct ContentView: View {
    @State private var possibleMoves = ["🪨", "📜", "✂️"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var totalTurns = 0
    @State private var showingFinalScore = false
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [.green, .black], center: .center, startRadius: 50, endRadius: 500)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("R🪨P📜S✂️")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 15){
                    if shouldWin{
                        Text("WIN: \(possibleMoves[appChoice])")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }
                    else{
                        Text("LOSE: \(possibleMoves[appChoice])")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }
                    ForEach(0..<3) { number in
                        Button {
                            choiceTapped(number)
                        } label: {
                            ChoiceImage(choice: possibleMoves[number])
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("SCORE: \(playerScore)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert("Congratulations!", isPresented: $showingFinalScore){
            Button("Continue"){
                resetGame()
            }
        } message: {
            Text("You won 10/\(totalTurns) games")
        }
    }
    
    func choiceTapped(_ number: Int){
        switch possibleMoves[number]{
        case "🪨":
            if appChoice == 2 && shouldWin || appChoice == 1 && !shouldWin{
                playerScore += 1
            }
        case "📜":
            if appChoice == 0 && shouldWin || appChoice == 2 && !shouldWin{
                playerScore += 1
            }
        case "✂️":
            if appChoice == 1 && shouldWin || appChoice == 0 && !shouldWin{
                playerScore += 1
            }
        default:
            return
        }
        totalTurns += 1
        appChoice = Int.random(in: 0...2)
        shouldWin.toggle()
        if playerScore == 10{
            showingFinalScore = true
        }
    }
    
    func resetGame(){
        playerScore = 0
        totalTurns = 0
        appChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
