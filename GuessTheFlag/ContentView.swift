//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lucas Omar on 2024-01-24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var randomCountry = Int.random(in: 0...2)
    
    @State private var showAlert = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green:0.2, blue:0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack (spacing: 20){
                Spacer()
                Text("Guess the Country")
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.bold))
                VStack (spacing: 15){
                    VStack {
                        Text("Tap the Country")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text("\(countries[randomCountry])")
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flaggedTapped(number)
                        } label : {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score is \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    func flaggedTapped(_ number: Int) {
        if number == randomCountry {
            scoreTitle = "Right Answer"
            userScore += 1
        } else {
            scoreTitle = "Wrong Answer"
            if userScore == 0 {
                userScore = 0 
            } else {
                userScore -= 1
            }
        }
        showAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        randomCountry = Int.random(in: 0...2)
    }
}



#Preview {
    ContentView()
}
