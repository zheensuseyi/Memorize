//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/11/25.
//
// This is my ViewModel, it acts as a bridge between model and view, it processes data from the model and provides it in a form the View can use

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let spookyEmojis = ["👻", "🎃", "🧛🏻", "🤠", "👻", "🎃", "🧛🏻", "🤠"]
    private static let catEmojis = ["😽", "😾", "🐱", "😸", "😽", "😾", "🐱", "😸"]
    private static let flagEmojis = ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇸", "🏴‍☠️", "🏳️‍🌈", "🏳️‍⚧️", "🇺🇸", "🏴‍☠️"]
    private static var currentEmojis = spookyEmojis

    private static func createMemoryGame(_ currentEmojis: Array<String>) -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: 6) { pairIndex in
            if currentEmojis.indices.contains(pairIndex) {
                return currentEmojis[pairIndex]
            }
            else {
                return "⁉️"
            }
        }
    }
    @Published var backgroundColor: Color = .orange

    @Published private var model = createMemoryGame(currentEmojis)
    
    // FIXME: what is this
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    // MARK: -- INTENTS
    func shuffle() {
        model.shuffle()
        // FIXME: dafuq is this
        objectWillChange.send()
    }
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
    func changeTheme(to theme: String) {
            // Change the current emoji set based on the selected theme
            switch theme {
            case "Spooky":
                EmojiMemoryGame.currentEmojis = EmojiMemoryGame.spookyEmojis
                backgroundColor = .orange
            case "Cat":
                EmojiMemoryGame.currentEmojis = EmojiMemoryGame.catEmojis
                backgroundColor = .teal
            case "Flag":
                EmojiMemoryGame.currentEmojis = EmojiMemoryGame.flagEmojis
                backgroundColor = .pink
            default:
                EmojiMemoryGame.currentEmojis = EmojiMemoryGame.spookyEmojis
            }
            
            // Recreate the memory game with the new emoji set
            model = EmojiMemoryGame.createMemoryGame(EmojiMemoryGame.currentEmojis)
            
            // Update background color if needed
        }
}
