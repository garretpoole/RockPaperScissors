//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Garret Poole on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    @State private var possibleMoves = ["🪨", "📜", "✂️"]
    @State private var winningMoves = ["📜", "✂️", "🪨"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [.green, .black], center: .center, startRadius: 50, endRadius: 500)
                .ignoresSafeArea()
            VStack{
                Spacer()
                VStack{
                    HStack{
                        Spacer()
                        Text("🪨ROCK🪨")
                            .font(.largeTitle)
                        Spacer()
                        Text("📜PAPER📜")
                            .font(.largeTitle)
                        Spacer()
                    }
                    Text("✂️SCISSORS✂️")
                        .font(.largeTitle)
                }
                Spacer()
                Text("Opponent: \(possibleMoves[appChoice])")
                    .font(.largeTitle)
                if shouldWin{
                    Text("WIN")
                        .font(.largeTitle)
                }
                else{
                    Text("LOSE")
                        .font(.largeTitle)
                }
                Spacer()
                HStack{
                    ForEach(0..<3) { number in
                        Button {
                            choiceTapped(number)
                        } label: {
                            Text(possibleMoves[number])
                                .font(.system(size: 60))
                        }
                        .clipShape(Capsule())
                        .background(.thinMaterial)
                        .padding()
                    }
                    
                }
                Text("SCORE: \(playerScore)")
                    .font(.title.bold())
                Spacer()
                Spacer()
            }
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
        appChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
