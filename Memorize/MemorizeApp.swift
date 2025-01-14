//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/8/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        @StateObject var game = EmojiMemoryGame()
        
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
