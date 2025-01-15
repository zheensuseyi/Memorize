//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/11/25.
//

// This is my model, it represents my apps data and logic.
import Foundation

struct MemorizeGame<CardContent> {
    private(set) var cards: Array<Card>
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards * 2
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
        
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
