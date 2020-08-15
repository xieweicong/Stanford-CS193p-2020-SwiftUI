//
//  MemoryGame.swift
//  Memorize
//
//  Created by weicongxie on 2020/07/26.
//  Copyright © 2020 weicongxie. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Cards
    
    var point: Int = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.cardscontent.indices.filter{ cards.cardscontent[$0].isFaceUp }.Only }
        set {
            for index in cards.cardscontent.indices {
                cards.cardscontent[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) { // TODO: search mutating
        print("card chooen: \(card)")
        if let chosenIndex = cards.cardscontent.firstIndex(matching: card), !cards.cardscontent[chosenIndex].isFaceUp, !cards.cardscontent[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards.cardscontent[potentialMatchIndex].content == cards.cardscontent[chosenIndex].content {
                    cards.cardscontent[potentialMatchIndex].isMatched = true
                    cards.cardscontent[chosenIndex].isMatched = true
                    self.point += 2
                } else {
                    self.computerPoint(card1: cards.cardscontent[potentialMatchIndex], card2: cards.cardscontent[chosenIndex])
                    cards.cardscontent[chosenIndex].isWatched = true
                    cards.cardscontent[potentialMatchIndex].isWatched = true
                }
                cards.cardscontent[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> Any) {
        let ct = cardContentFactory(numberOfPairsOfCards-2)
        let color = cardContentFactory(numberOfPairsOfCards-1)
        cards = Cards(cardscontent: Array<Card>(), theme: ct as! String, color: color as! Color)
        for pairIndex in 0..<numberOfPairsOfCards-2 {
            let content = cardContentFactory(pairIndex)
            cards.cardscontent.append(Card(content: content as! CardContent, id: pairIndex*2))
            cards.cardscontent.append(Card(content: content as! CardContent, id: pairIndex*2+1))
        }
//        cardsTheme = cardContentFactory(numberOfPairsOfCards)
        cards.cardscontent = cards.cardscontent.shuffled()
    }
    
    mutating func computerPoint(card1: Card, card2: Card) {
        if card1.isWatched && card2.isWatched {
            self.point -= 2
        } else if card1.isWatched || card2.isWatched{
            self.point -= 1
        }
    }

    struct Cards {
        var cardscontent: Array<Card>
        var theme: String
        var color: Color
    }
    
    struct Card: Identifiable { // TODO: search Identifiable
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isWatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
