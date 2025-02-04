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
  //  private var myThemes: [CardTheme]
    // cardContentFactory is a function that will return the CardContent
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
      /*  let catTheme = CardTheme(
            cardName: "Cat",
            cardEmojis: ["😽", "😾", "🐱", "😸", "🐈", "🐈‍⬛", "😺", "😼"],
            cardColor: ".pink",
            cardNumberOfPairsOfCards: 2
        )
        let flagTheme = CardTheme(
            cardName: "Flag",
            cardEmojis: ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇸", "🏴‍☠️", "🇻🇳", "🇨🇳", "🇯🇵", "🇸🇪"],
            cardColor: ".teal",
            cardNumberOfPairsOfCards: 2
        )
        let spookyTheme = CardTheme(
            cardName: "Spooky",
            cardEmojis: ["👻", "🎃", "🧛🏻", "🤠", "💀", "🤖", "👹", "🧌"],
            cardColor: ".orange",
            cardNumberOfPairsOfCards: 2
        )
        let natureTheme = CardTheme(
            cardName: "Nature",
            cardEmojis: ["🌳", "🌲", "🌵", "🌼", "🌺", "🌴", "🍂", "🍁"],
            cardColor: ".green",
            cardNumberOfPairsOfCards: 2
        )
        let spaceTheme = CardTheme(
            cardName: "Space",
            cardEmojis: ["🚀", "🪐", "🌌", "✨", "🌕", "☄️", "🌠", "🛸"],
            cardColor: ".blue",
            cardNumberOfPairsOfCards: 2
        )
        let foodTheme = CardTheme(
            cardName: "Food",
            cardEmojis: ["🍎", "🍔", "🍕", "🍩", "🍪", "🍇", "🍉", "🍟"],
            cardColor: ".yellow",
            cardNumberOfPairsOfCards: 2
        )
        self.myThemes = [
        catTheme,
        flagTheme,
        spookyTheme,
        natureTheme,
        spaceTheme,
        foodTheme
        ] */
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
    // this computed property has a getter that finds the index of the only face up card, if theres exactly one it returns it. Otherwise, it returns nil
    // The setter updates the cards array so that only the card at the given index is face-up, and all others are face-down.
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // The getter will find all the indices of the face up card, and if theres exactly one face up card, it returns its index
        // if theres no face-up cards or more then one, it will return nil
        get {
            // .indices gives range of all valid indices in the cards array (0..<cards.count)
            // .filter is a build in method that filters an array based on a condition, in this case a closure that states for each index in cards.indices, it will check if cards[index].isFaceup is true.
            // it will only keep the indices of cards that are face up
            // .only is an extension on Array that returns the first element of the array contains exactly one item, otherwise it will return nil
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        // The setter ensures that only the card at newValue index is face-up, and all other cards are face-down
        set {
            // .indices gives range of all valid indices in the cards array (0..<cards.count)
            // forEach is a built-in swift method that iterates over every element and performs an action for each one. in this case, it will iterate over every card index
            // $0 is the current element in the loop, and it compares (==) to newValue. if the index is the same as newValue, it sets isFaceUp to true, otherwise; false.
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    
    // Game function for chosing a card, the most important function
    mutating func choose(_ card: Card) {
        // .firstIndex is a built in swift method that finds the first index in an array where a condition is true
        // in this case, its checking if the current elements id is equal to the card id that was passed to the choose function
        // all in all, it searches for the first card in the cards array that has the same id as the card passsed in, and if found, the index is stored in chosenIndex
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            // if chosenIndex isnt isFaceUp and isnt isMatched???
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                // set potentialMatchIndex equal to our computed property, then do this if unwrapped?
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    // if the chosenIndex content is the same as the potentialMatchIndex content then isMatched on both of them will be true?
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
                // otherwise, the index of the one and only face up card will be now equal to the chosenindex?
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
