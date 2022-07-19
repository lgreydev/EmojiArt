//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Sergey Lukaschuk on 13.06.2022.
//

import UIKit
import TinyConstraints

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

    @IBOutlet weak var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }

    @IBOutlet weak var emojiArtView: EmojiArtView!

    var imageFetcher: ImageFetcher!

}


extension EmojiArtViewController {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {

        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                self.emojiArtView.backgroundImage = image
            }
        }

        session.loadObjects(ofClass: NSURL.self) { nsurls in
            guard let url = nsurls.first as? URL else { return }
            self.imageFetcher.fetch(url)
        }

        session.loadObjects(ofClass: UIImage.self) { images in
            guard let image = images.first as? UIImage else { return }
            self.imageFetcher.backup = image
        }
    }
}

