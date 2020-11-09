//
//  ContentView.swift
//  Memorize
//
//  Created by Sergio Rodríguez Rama on 05/11/2020.
//

import SwiftUI

struct ContentView: View {

    var viewModel: EmojiMemoryGame = EmojiMemoryGame()

    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
            }
        }
        .foregroundColor(.orange)
        .padding()
        .font(.largeTitle)
    }
}

struct CardView: View {

    var card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
            .preferredColorScheme(.dark)
    }
}
