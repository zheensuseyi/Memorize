//
//  ContentView.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    let emoji_arr = ["👻", "😽", "📕", "🤠"].shuffled()
    var body: some View {
        var randomEmoji = emoji_arr[0]
        HStack {
            ForEach(0..<emoji_arr.count, id: \.self) { index in
                CardView(content: emoji_arr[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var content = "👻"
    @State var isFaceUp = false
    let base = RoundedRectangle(cornerRadius: 12)
    var body: some View{
        ZStack {
            if isFaceUp {
                base
                    .fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            else {
                base
                    .fill()
            }
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
