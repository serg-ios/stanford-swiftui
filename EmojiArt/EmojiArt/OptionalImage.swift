//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Sergio Rodríguez Rama on 25/11/20.
//

import SwiftUI

struct OptionalImage: View {

    var uiImage: UIImage?

    var body: some View {
        Group {
            if let image = uiImage {
                Image(uiImage: image)
            }
        }
    }
}

