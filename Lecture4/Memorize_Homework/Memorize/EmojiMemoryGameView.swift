//
//  ContentView.swift
//  Memorize
//
//  Created by weicongxie on 2020/07/23.
//  Copyright © 2020 weicongxie. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame // TODO: search @ObservedObject
    
    var body: some View {
        VStack {
            Text(viewModel.cards.theme).font(.largeTitle)
            Grid(viewModel.cards.cardscontent) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            .padding(5)
            }
            Text(String(viewModel.point)).font(.largeTitle)
            ButtonView().onTapGesture {
                self.viewModel.newGame()
            }
        }
        .padding()
        .foregroundColor(viewModel.cards.color)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
        } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: -Drawing Constants
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}


struct ButtonView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: geometry.size.width, height: geometry.size.width * 0.2, alignment: .center)
            Text("New Game")
                .font(Font.system(size: geometry.size.width * 0.15))
            .foregroundColor(Color.white)
            }

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
