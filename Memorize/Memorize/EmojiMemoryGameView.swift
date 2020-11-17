//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Sergio Rodríguez Rama on 05/11/2020.
//

import SwiftUI

struct EmojiMemoryGameView: View {

    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()

    var body: some View {
        Grid(items: viewModel.cards) { card in
            CardView(card: card)
                .onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(5)
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {

    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader(content: { geometry in
            body(for: geometry.size)
        })
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110 - 90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }

    // MARK: - Drawing constants
    
    private let fontScaleFactor: CGFloat = 0.75

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        game.choose(card: game.cards[2])
        return EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
