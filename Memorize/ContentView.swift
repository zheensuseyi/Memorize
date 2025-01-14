 //  ContentView.swift
 //  Memorize
 //
 //  Created by Zheen Suseyi on 1/8/25.
 //
// This is my View, it displays the data and interacts with the user.
import SwiftUI

struct ContentView: View {
    // observedobject, if this thing change
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        // aligning everything in a VStack
        VStack {
            // Title with modifiers
            Text("Memorize")
                .font(.largeTitle)
                .fontWeight(.bold)
            // ScrollView for our cards
            ScrollView {
                // computed property that will build our game
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            }
            .padding()
        }

     var cards: some View {
         LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)]) {
             ForEach(viewModel.cards.indices, id: \.self) { index in
                 CardView(viewModel.cards[index])
                     .aspectRatio(2/3, contentMode: .fit)
                     .padding(4)
             }
         }
     }
 }

 struct CardView: View {
     let card: MemorizeGame<String>.Card
     init(_ card: MemorizeGame<String>.Card) {
         self.card = card
     }
     var body: some View{
         let base = RoundedRectangle(cornerRadius: 12)
         ZStack {
             Group {
                 base
                     .fill(.white)
                 base
                     .strokeBorder(lineWidth: 2)
                 Text(card.content)
                     .font(.system(size: 200))
                     .minimumScaleFactor(0.01)
                     .aspectRatio(1, contentMode: .fit)
             }
                 .opacity(card.isFaceUp ? 1 : 0)
             base.fill()
                 .opacity(card.isFaceUp ? 0 : 1)
         }
     }
 }

// what is this
 #Preview {
     ContentView(viewModel: EmojiMemoryGame())
 }
