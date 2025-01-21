//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/11/25.
//
// This is my ViewModel, it acts as a bridge between model and view, it processes data from the model and provides it in a form the View can use

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var chosenNumber: Int = Int.random(in: 0...5)
    private static let catTheme = Theme(name: "Cat", emojis: ["😽", "😾", "🐱", "😸", "😽", "😾", "🐱", "😸"], color: ".pink", numberOfPairsOfCards: 4
    )
    private static let flagTheme = Theme(
        name: "Flag",
        emojis: ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇸", "🏴‍☠️", "🏳️‍🌈", "🏳️‍⚧️", "🇺🇸", "🏴‍☠️"],
        color: ".teal",
        numberOfPairsOfCards: 2
    )
    private static let spookyTheme = Theme(
        name: "Spooky",
        emojis: ["👻", "🎃", "🧛🏻", "🤠", "👻", "🎃", "🧛🏻", "🤠"],
        color: ".orange",
        numberOfPairsOfCards: 2
    )
    private static let natureTheme = Theme(
        name: "Nature",
        emojis: ["🌳", "🌲", "🌵", "🌼", "🌺", "🌴", "🍂", "🍁"],
        color: ".green",
        numberOfPairsOfCards: 2
    )
    private static let spaceTheme = Theme(
        name: "Space",
        emojis: ["🚀", "🪐", "🌌", "✨", "🌕", "☄️", "🌠", "🛸"],
        color: ".blue",
        numberOfPairsOfCards: 2
    )
    private static let foodTheme = Theme(
        name: "Food",
        emojis: ["🍎", "🍔", "🍕", "🍩", "🍪", "🍇", "🍉", "🍟"],
        color: ".yellow",
        numberOfPairsOfCards: 2
    )
    private static var currentThemes = [
        spookyTheme,
        flagTheme,
        catTheme,
        natureTheme,
        foodTheme,
        spaceTheme
    ].shuffled()
    // Computed property to get the current theme
    private var currentTheme: Theme {
        return EmojiMemoryGame.currentThemes[chosenNumber]
    }
    private static func createMemoryGame(_ currentTheme: Theme) -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: currentTheme.numberOfPairsOfCards) {
            if currentTheme.emojis.indices.contains($0) {
                return currentTheme.emojis[$0]
            }
            else {
                return "⁉️"
            }
        }
    }
    @Published private var model: MemorizeGame<String>
    @Published public var name: String
    @Published public var emojis: [String]
    @Published public var color: String
    @Published public var numberOfPairsOfCards: Int
    
    
    // Initializer
    init() {
        // Initialize with the current theme
        let theme = EmojiMemoryGame.currentThemes[Int.random(in: 0...5)]
        self.model = EmojiMemoryGame.createMemoryGame(theme)
        self.name = theme.name
        self.emojis = theme.emojis
        self.color = theme.color
        self.numberOfPairsOfCards = theme.numberOfPairsOfCards
    }
    
    
    
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
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
            // Update chosenNumber and create a new game
            chosenNumber = Int.random(in: 0...5)
            var theme = EmojiMemoryGame.currentThemes[chosenNumber]
            theme.numberOfPairsOfCards = Int.random(in: 2...7) // Set a random number for pairs
            
            model = EmojiMemoryGame.createMemoryGame(theme)
        
            // Update Published properties for the UI
            name = theme.name
            emojis = theme.emojis
            color = theme.color
            numberOfPairsOfCards = theme.numberOfPairsOfCards
           
        }
}
