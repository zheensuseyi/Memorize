//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/11/25.
//
// This is my ViewModel, it acts as a bridge between model and view, it processes data from the model and provides it in a form the View can use

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let catTheme = Theme(
        name: "Cat",
        emojis: ["😽", "😾", "🐱", "😸", "🐈", "🐈‍⬛", "😺", "😼"],
        color: ".pink",
        numberOfPairsOfCards: 4
    )
    private static let flagTheme = Theme(
        name: "Flag",
        emojis: ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇸", "🏴‍☠️", "🇻🇳", "🇨🇳", "🇯🇵", "🇸🇪"],
        color: ".teal",
        numberOfPairsOfCards: 3
    )
    private static let spookyTheme = Theme(
        name: "Spooky",
        emojis: ["👻", "🎃", "🧛🏻", "🤠", "💀", "🤖", "👹", "🧌"],
        color: ".orange",
        numberOfPairsOfCards: 5
    )
    private static let natureTheme = Theme(
        name: "Nature",
        emojis: ["🌳", "🌲", "🌵", "🌼", "🌺", "🌴", "🍂", "🍁"],
        color: ".green",
        numberOfPairsOfCards: 6
    )
    private static let spaceTheme = Theme(
        name: "Space",
        emojis: ["🚀", "🪐", "🌌", "✨", "🌕", "☄️", "🌠", "🛸"],
        color: ".blue",
        numberOfPairsOfCards: 4
    )
    private static let foodTheme = Theme(
        name: "Food",
        emojis: ["🍎", "🍔", "🍕", "🍩", "🍪", "🍇", "🍉", "🍟"],
        color: ".yellow",
        numberOfPairsOfCards: 7
    )
    
    private static let myThemes = [
        spookyTheme,
        flagTheme,
        catTheme,
        natureTheme,
        foodTheme,
        spaceTheme
    ]
    
    // Computed property to get the current theme
    private var currentTheme: Theme {
        return EmojiMemoryGame.myThemes[chosenNumber]
    }
    
    private var chosenNumber: Int = Int.random(in: 0...5)
    @Published var model: MemorizeGame<String>
    @Published var name: String
    @Published var emojis: [String]
    @Published var color: String
    @Published var numberOfPairsOfCards: Int
    
    // Initializer
    init() {
        // Initialize with the current theme
        let theme = EmojiMemoryGame.myThemes[chosenNumber]
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
    
    // what is a MemorizeGame<String> and why is it returning it
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
            var theme = EmojiMemoryGame.myThemes[chosenNumber]
            theme.numberOfPairsOfCards = Int.random(in: 2...7) // Set a random number for pairs
            
            model = EmojiMemoryGame.createMemoryGame(theme)
        
            // Update Published properties for the UI
            name = theme.name
            emojis = theme.emojis
            color = theme.color
            numberOfPairsOfCards = theme.numberOfPairsOfCards
    }
}
