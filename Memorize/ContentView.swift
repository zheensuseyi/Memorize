 //  ContentView.swift
 //  Memorize
 //
 //  Created by Zheen Suseyi on 1/8/25.
 //
// This is my View, it displays the data and interacts with the user.
import SwiftUI

struct ContentView: View {
    typealias Card = MemorizeGame<String>.Card
    // observedobject, if this thing change
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        // aligning everything in a VStack
        VStack {
            // Title with modifiers
            Text(viewModel.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Score: \(viewModel.score)")
                .animation(nil)
            // ScrollView for our cards
            ScrollView {
                // computed property that will build our game
                cards
            }
            Button(action: {
                withAnimation {
                    viewModel.newGame()
                }
            }) {
                Text("New Game")
                    .font(.title2)
            }
            .padding(spacing)
        }
        .padding()
    }
    
    @ViewBuilder
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .padding(4)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        viewModel.choose(card)
                    }
                }
        }
        .foregroundColor(Color(viewModel.changeColor(color: viewModel.color)))
    }
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}

 #Preview {
     ContentView(viewModel: EmojiMemoryGame())
 }
