//
//  CardView.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/31/25.
//

import SwiftUI
typealias Card = MemorizeGame<String>.Card

struct CardView: View {
    let card: MemorizeGame<String>.Card
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    var body: some View{
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.leading)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.spin(duration: 1), value: card.isMatched)
                
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
    
}
extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}
#Preview {
    VStack {
        HStack {
            CardView(Card(isFaceUp: true, content:"😼", id: "test1"))
            CardView(Card(content:"X", id: "test2"))
        }
        HStack {
            CardView(Card(isFaceUp: true, content:"😼", id: "test1"))
            CardView(Card(isFaceUp: true, isMatched: true, content:"X", id: "test2"))
        }
        .padding()
        .foregroundColor(.green)
    }
}
