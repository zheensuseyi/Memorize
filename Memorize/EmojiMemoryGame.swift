//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/11/25.
//
// This is my ViewModel, it acts as a bridge between model and view, it processes data from the model and provides it in a form the View can use

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemorizeGame<String>.Card
    // Computed property to get the current theme
    var model: MemorizeGame<String> = createMemoryGame(<#T##currentTheme: MemorizeGame<String>.CardTheme##MemorizeGame<String>.CardTheme#>)
    @Published var name: String
    @Published var emojis: [String]
    @Published var color: String
    @Published var numberOfPairsOfCards: Int
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    var currentTheme: MemorizeGame<String> {
        return MemorizeGame<String>.
    }
    
    // what is a MemorizeGame<String> and why is it returning it
    private static func createMemoryGame() -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: currentTheme.cardNumberOfPairsOfCards) {
            if currentTheme.cardEmojis.indices.contains($0) {
                return currentTheme.cardEmojis[$0]
            }
            else {
                return "⁉️"
            }
        }
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
  
    func changeColor(color: String) -> Color {
        switch color {
        case ".teal":
            return Color.teal
        case ".yellow":
            return Color.yellow
        case ".pink":
            return Color.pink
        case ".orange":
            return Color.orange
        case ".blue":
            return Color.blue
        case ".green":
            return Color.green
        default:
            return Color.gray // Return nil if the color isn't recognized
        }
    }

    
    func newGame() {
            var currentTheme = myThemes[0]
            currentTheme.cardNumberOfPairsOfCards = Int.random(in: 2...7) // Set a random number for pairs
            model = EmojiMemoryGame.createMemoryGame(currentTheme)
            // Update Published properties for the UI
            name = currentTheme.cardName
            emojis = currentTheme.cardEmojis
            color = currentTheme.cardColor
            numberOfPairsOfCards = currentTheme.cardNumberOfPairsOfCards
    }
}
