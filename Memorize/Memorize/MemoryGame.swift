//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sergio Rodríguez Rama on 09/11/2020.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]

    mutating func choose(card: Card) {
        let chosenIndex: Int = self.index(of: card)
        let wasFaceUp = cards[chosenIndex].isFaceUp
        cards[chosenIndex].isFaceUp = !wasFaceUp
    }

    func index(of card: Card) -> Int {
        cards.enumerated().first(where: { $0.element.id == card.id })?.offset ?? 0 // TODO: bogus!
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let cardContent = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: cardContent))
            cards.append(Card(id: pairIndex * 2 + 1, content: cardContent))
        }
    }

    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
