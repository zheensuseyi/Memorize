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
    private let aspectRatio: CGFloat = 2/3
    
    
    var body: some View {
        // aligning everything in a VStack
        VStack {
            // Title with modifiers
            Text(viewModel.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Score: \(viewModel.score)")
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
    
    @ViewBuilder
    private var cards: some View {
        AspectVGrid(viewModel: viewModel, items: viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(Color(viewModel.changeColor(color: viewModel.color)))
    }
}
/*func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
           let count = CGFloat(count)
           var columnCount = 1.0
           repeat {
               let width = size.width / columnCount
               let height = width / aspectRatio
               
               let rowCount = (count / columnCount).rounded(.up)
               if rowCount * height < size.height {
                   return (size.width / columnCount).rounded(.down)
               }
               columnCount += 1
           } while columnCount < count
           return min(size.width / count, size.height * aspectRatio).rounded(.down)
       }
   }
*/
    
 
// Why do we need a struct here. What does this struct even do?
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
// what is this
 #Preview {
     ContentView(viewModel: EmojiMemoryGame())
 }
