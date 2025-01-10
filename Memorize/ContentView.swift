 //  ContentView.swift
 //  Memorize
 //
 //  Created by Zheen Suseyi on 1/8/25.
 //

 import SwiftUI

struct ContentView: View {
    let spooky_emoji_arr = ["👻", "🎃", "🧛🏻", "🤠"]
    let cat_emoji_arr = ["😽", "🐱", "😼", "😾"]
    let flag_emoji_arr = ["🏳️‍🌈", "🇺🇸", "🇬🇧", "🏁"]
    @State var selectedColor = Color(.orange)
    @State var theme = ["👻", "🎃", "🧛🏻", "🤠", "👻", "🎃", "🧛🏻", "🤠"].shuffled()// Static initialization
    
    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView {
                cards
                    .foregroundColor(selectedColor)
            }
            Text("Themes")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack {
                Spacer() // Add spacing to distribute items evenly
                VStack {
                    Text("Cat")
                        .font(.headline) // Uniform font for labels
                    Button(action: {
                        theme = []
                        var foo = Int.random(in: 1..<cat_emoji_arr.count)
                        for index in 0..<foo {
                            theme.append(cat_emoji_arr[index])
                            theme.append(cat_emoji_arr[index])
                        }
                        theme = theme.shuffled()

                        selectedColor = Color(.blue)
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
                Spacer()
            }
        }
        .padding()
    }

     
     
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
     
     var cards: some View {
         LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
             ForEach(0..<theme.count, id: \.self) { index in
                 CardView(content: theme[index])
                     .aspectRatio(2/3, contentMode: .fit)
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




 struct CardView: View {
     var content = "👻"
     @State var isFaceUp = false
     let base = RoundedRectangle(cornerRadius: 12)
     var body: some View{
         ZStack {
             Group {
                 base
                     .fill(.white)
                 base
                     .strokeBorder(lineWidth: 2)
                 Text(content)
                     .font(.largeTitle)
             }
             .opacity(isFaceUp ? 1 : 0)
             base.fill().opacity(isFaceUp ? 0 : 1)
         }
         .onTapGesture {
             isFaceUp.toggle()
         }
     }
 }

 #Preview {
     ContentView()
 }

 // Value of optional type 'String?' must be unwrapped to a value of type 'String'
