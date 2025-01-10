//
//  ContentView.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    let emoji_arr = ["👻", "😽", "📕", "🤠", "🤡", "🦄", "👽", "🦾", "🙃", "🥰", "😆"].shuffled()
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
                Spacer()
                cardCountAdjusters
            }
            .padding()
        }
    
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
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
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emoji_arr[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        .foregroundColor(.orange)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
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
