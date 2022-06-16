//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Sergey Lukaschuk on 13.06.2022.
//

import UIKit
import TinyConstraints

class EmojiArtViewController: UIViewController {

    private lazy var dropZone: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var emojiArtView: EmojiArtView = {
        let view = EmojiArtView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = . red

        addViews()
        setupDropZone()
    }
}


extension EmojiArtViewController {
    private func addViews() {
        view.addSubview(dropZone)
        view.addSubview(emojiArtView)
    }

    private func setupDropZone() {
        dropZone.height(100)
        dropZone.width(200)
        dropZone.topToSuperview()
        dropZone.leadingToSuperview()
        dropZone.backgroundColor = . black
    }
}
