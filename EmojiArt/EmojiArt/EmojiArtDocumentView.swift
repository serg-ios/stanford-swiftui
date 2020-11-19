//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Sergio Rodríguez Rama on 18/11/2020.
//

import SwiftUI

struct EmojiArtDocumentView: View {

    @ObservedObject var document: EmojiArtDocument

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map({ String($0) }), id: \.self) { emoji in
                        Text(emoji)
                            .font(.system(size: defaultEmojiSize))
                            .onDrag { return NSItemProvider(object: emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            GeometryReader { geometry in
                ZStack {
                    Color.white
                        .overlay(
                            Group {
                                if let image = self.document.backgroundImage {
                                    Image(uiImage: image)
                                }
                            }
                        )
                        .edgesIgnoringSafeArea([.bottom, .horizontal])
                        .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                            var location = geometry.convert(location, from: .global)
                            location = CGPoint(x: location.x - geometry.size.width / 2, y: location.y - geometry.size.height / 2)
                            return self.drop(providers: providers, at: location)
                        }
                    ForEach(document.emojis) { emoji in
                        Text(emoji.text)
                            .font(self.font(for: emoji))
                            .position(self.position(for: emoji, in: geometry.size))
                    }
                }
            }
        }
    }

    private func font(for emoji: EmojiArt.Emoji) -> Font {
        Font.system(size: emoji.fontSize)
    }

    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        CGPoint(x: emoji.location.x + size.width / 2, y: emoji.location.y + size.height / 2)
    }



    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            self.document.setBackgroundURL(url)
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size: defaultEmojiSize)
            }
        }
        return found
    }

    private let defaultEmojiSize: CGFloat = 40
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}
