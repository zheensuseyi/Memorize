//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Zheen Suseyi on 1/20/25.
//

import SwiftUI

// dont really understand this entire struct, and why it has to be in its own file
struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: viewModel.numberOfPairsOfCards, size: geometry.size, atAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) {
                    item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height <= size.height {
                return width.rounded(.down)
            }
            columnCount += 1
        } while columnCount <= count // Ensure columnCount doesn't exceed count
        return (size.width / count)
    }
    /*
     reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
         return s1 > s2
     })
     reversedNames = names.sorted(by: { $0 > $1 } )
     */
}

