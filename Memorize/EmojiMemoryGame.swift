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
    typealias CT = MemorizeGame<String>.CardTheme

    var catTheme = CT(
        name: "Cat",
        emojis: ["😽", "😾", "🐱", "😸", "🐈", "🐈‍⬛", "😺", "😼"],
        color: ".pink",
        numberOfPairsOfCards: 6
    )
    var flagTheme = CT(
        name: "Flag",
        emojis: ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇸", "🏴‍☠️", "🇻🇳", "🇨🇳", "🇯🇵", "🇸🇪"],
        color: ".teal",
        numberOfPairsOfCards: 6
    )
    var spookyTheme = CT(
        name: "Spooky",
        emojis: ["👻", "🎃", "🧛🏻", "🤠", "💀", "🤖", "👹", "🧌"],
        color: ".orange",
        numberOfPairsOfCards: 6
    )
    var natureTheme = CT(
        name: "Nature",
        emojis: ["🌳", "🌲", "🌵", "🌼", "🌺", "🌴", "🍂", "🍁"],
        color: ".green",
        numberOfPairsOfCards: 6
    )
    var spaceTheme = CT(
        name: "Space",
        emojis: ["🚀", "🪐", "🌌", "✨", "🌕", "☄️", "🌠", "🛸"],
        color: ".blue",
        numberOfPairsOfCards: 6
    )
    var foodTheme = CT(
        name: "Food",
        emojis: ["🍎", "🍔", "🍕", "🍩", "🍪", "🍇", "🍉", "🍟"],
        color: ".yellow",
        numberOfPairsOfCards: 6
    )
    var myThemes: [CT] = []
    var currentTheme: CT
    // Computed property to get the current theme
    @Published var model: MemorizeGame<String>
    @Published var name: String
    @Published var emojis: [String]
    @Published var color: String
    @Published var numberOfPairsOfCards: Int
    
    init() {
        let randomNumber = Int.random(in: 0...5)
        myThemes = [
            catTheme,
            flagTheme,
            spookyTheme,
            natureTheme,
            spaceTheme,
            foodTheme
        ]
        currentTheme = myThemes[randomNumber]
        model = EmojiMemoryGame.createMemoryGame(currentTheme)
        name = currentTheme.name
        emojis = currentTheme.emojis
        color = currentTheme.color
        numberOfPairsOfCards = currentTheme.numberOfPairsOfCards
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // what is a MemorizeGame<String> and why is it returning it
    private static func createMemoryGame(_ currentTheme: MemorizeGame<String>.CardTheme) -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: currentTheme.numberOfPairsOfCards) {
            if currentTheme.emojis.indices.contains($0) {
                return currentTheme.emojis[$0]
            }
            else {
                return "⁉️"
            }
        }
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    // FIXME: find a better use for this functionm
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
    
    // FIXME: maybe add a helper function?
    func newGame() {
        let randomNumber = Int.random(in: 0...5)
        currentTheme = myThemes[randomNumber]
        currentTheme.numberOfPairsOfCards = Int.random(in: 2...7) // Set a random number for pairs
        model = EmojiMemoryGame.createMemoryGame(currentTheme)
        // Update Published properties for the UI
        name = currentTheme.name
        emojis = currentTheme.emojis
        color = currentTheme.color
        numberOfPairsOfCards = currentTheme.numberOfPairsOfCards
    }
}
