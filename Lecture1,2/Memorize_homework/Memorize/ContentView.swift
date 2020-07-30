//
//  ContentView.swift
//  Memorize
//
//  Created by weicongxie on 2020/07/23.
//  Copyright © 2020 weicongxie. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(Font.largeTitle)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: 10.0).fill(Color.white).frame(height: geometry.size.width*4/3)
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3).frame(height: geometry.size.width*4/3)
                    Text(self.card.content)
                } else {
                    RoundedRectangle(cornerRadius: 10.0).fill().frame(height: 60)
                }
            }
        }
    }

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
