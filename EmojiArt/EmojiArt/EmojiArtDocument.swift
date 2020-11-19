//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Sergio Rodríguez Rama on 18/11/2020.
//

import SwiftUI
import Foundation

class EmojiArtDocument: ObservableObject {
    static let palette: String = "😀😃😄😁😆😅😂🤣☺️😊😇🙂🙃😉😌😍"

    @Published private var emojiArt: EmojiArt = EmojiArt()

    @Published private(set) var backgroundImage: UIImage?

    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }

    // MARK: - Intent(s)

    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }

    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }

    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }

    func setBackgroundURL(_ url: URL?) {
        emojiArt.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }

    private func fetchBackgroundImageData() {
        backgroundImage = nil
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = self.emojiArt.backgroundURL, let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    if url == self?.emojiArt.backgroundURL {
                        self?.backgroundImage = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
