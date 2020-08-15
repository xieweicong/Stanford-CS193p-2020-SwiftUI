//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by weicongxie on 2020/07/26.
//  Copyright © 2020 weicongxie. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject { // TODO: search ObservableObject
    @Published private var model: MemoryGame<String> = createMemoryGame() // TODO: search @Published
    
    var point = 0
    
    func newGame() {
        objectWillChange.send()
        self.point = 0
        model = EmojiMemoryGame.createMemoryGame()
    }
    

    static func createMemoryGame() -> MemoryGame<String> {
        var emojis = [["👻","🎃","🕷", "Halloween", Color.orange] as [Any]]
        emojis.append(["😺","😻","🙀", "Cat", Color.yellow])
        emojis.append(["✊🏻","✌🏻","👏🏻", "Hand", Color.gray])
        emojis.append(["🐼", "🐔", "🦄", "Animals", Color.red])
        emojis.append(["🏀", "🏈", "⚾", "Sports", Color.blue])
        emojis.append(["😀", "😢", "😉", "Faces", Color.green])
        let thisEmojis = emojis[Int.random(in: 0..<emojis.count)]
        return MemoryGame<String>(numberOfPairsOfCards: thisEmojis.count) { pairIndex in
            return thisEmojis[pairIndex]
        }
    }
 
    
    //MARK: - Access to the Model
    
    var cards: MemoryGame<String>.Cards {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
        point = model.point
    }
}


