//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Sergey Lukaschuk on 13.06.2022.
//

import UIKit
import TinyConstraints

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

    private var dropZone = UIView() {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }

    private lazy var emojiArtView: EmojiArtView = {
        let view = EmojiArtView()
        return view
    }()

    var imageFetcher: ImageFetcher!

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        constraintsToViews()
        emojiArtView.backgroundImage = UIImage(named: "142774")
        print(#function)
    }

    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        print(#function)
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        print(#function)
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        print(#function)
        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                self.emojiArtView.backgroundImage = image
            }
        }

        session.loadObjects(ofClass: NSURL.self) { nsurl in
            guard let url = nsurl.first as? URL else { return }
            self.imageFetcher.fetch(url)
        }

        session.loadObjects(ofClass: UIImage.self) { images in
            guard let image = images.first as? UIImage else { return }
            self.imageFetcher.backup = image
        }
    }
}


extension EmojiArtViewController {
    private func addViews() {
        view.addSubview(dropZone)
        view.addSubview(emojiArtView)
    }

    private func constraintsToViews() {
        dropZone.edgesToSuperview()
        emojiArtView.edgesToSuperview()
    }
}
