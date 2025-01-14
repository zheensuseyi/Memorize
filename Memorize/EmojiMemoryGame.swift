//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/11/25.
//
// This is my ViewModel, it acts as a bridge between model and view, it processes data from the model and provides it in a form the View can use

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🧛🏻", "🤠", "👻", "🎃", "🧛🏻", "🤠"]

    private static func createMemoryGame() -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            else {
                return "⁉️"
            }
        }
    }
    @Published private var model = createMemoryGame()
    
    // what is this
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    // MARK: -- INTENTS
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
}
