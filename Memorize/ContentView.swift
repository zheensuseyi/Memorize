//
//  ContentView.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View{
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("🔥")
                    .font(.largeTitle)
            }
            else {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.orange)
            }
        }
    }
}

#Preview {
    ContentView()
}
