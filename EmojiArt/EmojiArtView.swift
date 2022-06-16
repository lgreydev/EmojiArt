//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Sergey Lukaschuk on 16.06.2022.
//

import UIKit

class EmojiArtView: UIView {

    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
}
