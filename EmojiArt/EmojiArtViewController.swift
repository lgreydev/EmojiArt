//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Sergey Lukaschuk on 13.06.2022.
//

import UIKit
import TinyConstraints

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

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
        constraintsToViews()
    }
}


extension EmojiArtViewController {
    private func addViews() {
        view.addSubview(dropZone)
        view.addSubview(emojiArtView)
    }

    private func constraintsToViews() {
        dropZone.height(100)
        dropZone.width(200)
        dropZone.topToSuperview()
        dropZone.leadingToSuperview()
        dropZone.backgroundColor = . black
    }

    private func setupDropZone() {
        dropZone.addInteraction(UIDropInteraction(delegate: self))
    }

    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
}
