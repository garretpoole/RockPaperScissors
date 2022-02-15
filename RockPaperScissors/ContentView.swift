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
    @State private var playerScore = 0
    @State private var totalTurns = 0
    @State private var resultTitle = ""
    @State private var showingFinalScore = false
    @State private var showingResult = false
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color.init(red: 0.7, green: 0.3, blue: 0.2), .black], center: .bottom, startRadius: 20, endRadius: 900)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("R🪨   P📜   S✂️")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 15){
                    
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
                Text("Games Played: \(totalTurns)")
                    .foregroundStyle(.secondary)
                    .font(.subheadline.weight(.heavy))
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert(resultTitle, isPresented: $showingResult){
            Button("Continue"){
                nextTurn()
            }
        } message: {
            Text("Computer chose \(possibleMoves[appChoice])")
        }

        
        .alert("Congratulations!", isPresented: $showingFinalScore){
            Button("Continue"){
                resetGame()
            }
        } message: {
            if totalTurns > 0{
                Text("You won \(100 * (playerScore / totalTurns))% of games")
            }
        }
    }
    
    func choiceTapped(_ number: Int){
        switch possibleMoves[number]{
        case "🪨":
            if appChoice == 2 {
                playerScore += 1
                resultTitle = "YOU WON"
            }
            else if appChoice == 0 {
                resultTitle = "YOU TIED"
            }
            else{
                resultTitle = "YOU LOST"
            }
        case "📜":
            if appChoice == 0 {
                playerScore += 1
                resultTitle = "YOU WON"
            }
            else if appChoice == 1 {
                resultTitle = "YOU TIED"
            }
            else{
                resultTitle = "YOU LOST"
            }
        case "✂️":
            if appChoice == 1 {
                playerScore += 1
                resultTitle = "YOU WON"
            }
            else if appChoice == 2 {
                resultTitle = "YOU TIED"
            }
            else{
                resultTitle = "YOU LOST"
            }
        default:
            return
        }
        showingResult = true
        totalTurns += 1
        if playerScore == 10{
            showingFinalScore = true
        }
    }
    
    func nextTurn(){
        appChoice = Int.random(in: 0...2)
    }
    
    func resetGame(){
        playerScore = 0
        totalTurns = 0
        appChoice = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
