//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/11/25.
//

// This is my model, it represents my apps data and logic.
import Foundation
struct MemorizeGame<CardContent> where CardContent: Equatable {
    // FIXME: what does (set) mean
    // this property means that its read-only outside the struct, but within the struct it can be both read and written.
    private(set) var cards: Array<Card>
    private(set) var score: Int
    // cardContentFactory is a function that will return the CardContent
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        score = 0
        // loops through the pairs using cardContentFactory to generate the content for each pair
        // creates two card objects for each pair with unique ids
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
    }
    
    // FIXME: understand the following computed property better
    var indexOfTheOneAndOnlyFaceUpCard: Int? {

        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }

        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    
    // Game function for chosing a card, the most important function
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }
                    else {
                        if cards[chosenIndex].seen && cards[potentialMatchIndex].seen {
                            score -= 1
                        }
                        cards[chosenIndex].seen = true
                        cards[potentialMatchIndex].seen = true
                    }
                }
                else {
                    if cards[chosenIndex].seen {
                        score -= 1
                    }
                    else {
                        cards[chosenIndex].seen = true
                    }
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                // current card is now isFaceUp
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    seen = true
                }
            }
        }
        var isMatched = false
        let content: CardContent
        var id: String
        var seen = false
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? " matched" : "")"
        }
    }
    struct CardTheme {
        var name: String
        var emojis: Array<String>
        var color: String  // Store color as a string
        var numberOfPairsOfCards: Int
        init(name: String, emojis: Array<String>, color: String, numberOfPairsOfCards: Int) {
            self.name = name
            self.emojis = emojis
            self.color = color
            self.numberOfPairsOfCards = numberOfPairsOfCards
        }
    }
}
// FIXME: help understand this array.
// If the array has exactly one element, return that element
// otherwise, return nil
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
