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
    
    // initalizing arrays
   /* let spooky_emoji_arr = ["👻", "🎃", "🧛🏻", "🤠"]
    let cat_emoji_arr = ["😽", "🐱", "😼", "😾"]
    let flag_emoji_arr = ["🏳️‍🌈", "🇺🇸", "🇬🇧", "🏁"] */
    // selected color variable (Color) which will get changed
    @State var selectedColor = Color(.orange)
    // theme variable (array of strings) which will get changed
    @State var theme = ["👻", "🎃", "🧛🏻", "🤠", "👻", "🎃", "🧛🏻", "🤠"].shuffled()// Static initialization
    
    
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
                // modifier with a state var attached to it that changes depending on theme selected
                    .foregroundColor(selectedColor)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            
            // Title for theme buttons
          /*  Text("Themes")
                .font(.largeTitle)
                .fontWeight(.bold)
            // Aligning all of our theme buttons in an HStack
            HStack {
                Spacer() // Add spacing to distribute items evenly
                VStack {
                    Text("Cat")
                        .font(.headline) // Uniform font for labels
                    // Cat Theme Button
                       Button(action: {
                     // Set theme to empty Arr
                     theme = []
                     // temp variable for random number between 1 and length of arr
                     var foo = Int.random(in: 1..<cat_emoji_arr.count)
                     // iterate through the arr and append it to theme
                     for index in 0..<foo {
                     theme.append(cat_emoji_arr[index])
                     theme.append(cat_emoji_arr[index])
                     }
                     // shuffle arr, theme will now be displayed
                     theme = theme.shuffled()
                     // change foreground color
                     selectedColor = Color(.blue)
                     // label for the button, its an image
                     }, label: {
                     Image(systemName: "cat.fill")
                     .font(.largeTitle) // Adjust icon size
                     })
                     .padding(.bottom, 5) // Add space between the button and text
                     
                     }
                     Spacer()
                     VStack {
                     Text("Flag")
                     .font(.headline) // Uniform font for labels
                     Button(action: {
                     theme = []
                     var foo = Int.random(in: 1..<flag_emoji_arr.count)
                     for index in 0..<foo {
                     theme.append(flag_emoji_arr[index])
                     theme.append(flag_emoji_arr[index])
                     }
                     theme = theme.shuffled()
                     selectedColor = Color(.red)
                     }, label: {
                     Image(systemName: "flag.fill")
                     .font(.largeTitle)
                     })
                     .padding(.bottom, 5)
                     
                     }
                     Spacer()
                     VStack {
                     Text("Spooky")
                     .font(.headline) // Uniform font for labels
                     Button(action: {
                     theme = []
                     var foo = Int.random(in: 1..<spooky_emoji_arr.count)
                     for index in 0..<foo {
                     theme.append(spooky_emoji_arr[index])
                     theme.append(spooky_emoji_arr[index])
                     }
                     theme = theme.shuffled()
                     selectedColor = Color(.orange)
                     
                     }, label: {
                     Image(systemName: "tree.fill")
                     .font(.largeTitle)
                     })
                     .padding(.bottom, 5)
                     
                     }
                     Spacer()*/
               // }
            }
            .padding()
        }
  //  }

     
     
    /* func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
         Button(action: {
             cardCount += offset
         }, label: {
             Image(systemName: symbol)
         })
         .disabled(cardCount + offset < 1 || cardCount + offset > emoji_arr.count)
     }
     var cardCountAdjusters: some View {
         HStack {
             cardRemover
             Spacer()
             cardAdder
         }
         .font(.largeTitle)
     }*/
     // Computed property which aderes to some View
     var cards: some View {
         // builds a grid
         LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)]) {
             // looping thru theme and displaying each item in the Grid
             ForEach(viewModel.cards.indices, id: \.self) { index in
                 CardView(viewModel.cards[index])
                 // modifier for size of each card
                     .aspectRatio(2/3, contentMode: .fit)
                     .padding(4)
             }
         }
     }
     
     
     
     /*var cardRemover: some View {
         cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
     }
     
     var cardAdder: some View {
         cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
     }*/
 }



// CardView Struct for see
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

 #Preview {
     ContentView(viewModel: EmojiMemoryGame())
 }

 // Value of optional type 'String?' must be unwrapped to a value of type 'String'
