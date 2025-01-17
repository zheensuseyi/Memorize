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
            Text(viewModel.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            // ScrollView for our cards
            ScrollView {
                // computed property that will build our game
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button(action: {
                viewModel.newGame()
            }) {
                Text("New Game")
                    .font(.title2)
            }
            .padding()
        }
        .padding()
    }

     var cards: some View {
         LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)]) {
             ForEach(viewModel.cards) { card in
                 CardView(card)
                     .aspectRatio(2/3, contentMode: .fit)
                     .padding(4)
                     .onTapGesture {
                         viewModel.choose(card)
                     }
             }
             .foregroundColor(Color(themeColor: viewModel.color))
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
         .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
     }
 }

extension Color {
    init(themeColor: String) {
        switch themeColor {
        case ".pink": self = .pink
        case ".teal": self = .teal
        case ".blue": self = .blue
        case ".orange": self = .orange
        case ".green": self = .green
        case ".yellow": self = .yellow
        default: self = .gray
        }
    }
}
// what is this
 #Preview {
     ContentView(viewModel: EmojiMemoryGame())
 }
