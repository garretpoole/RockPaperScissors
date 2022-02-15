//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Garret Poole on 2/14/22.
//

import SwiftUI


struct ContentView: View {
    @State private var possibleMoves = ["🪨", "📜", "✂️"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    
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
                            Text(possibleMoves[number])
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 70))
                    .padding(.vertical, 20)
                    .overlay(RoundedRectangle(cornerRadius: 90)
                                .stroke(Color.brown))
                    .background(.thinMaterial)
                    .cornerRadius(90)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
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
