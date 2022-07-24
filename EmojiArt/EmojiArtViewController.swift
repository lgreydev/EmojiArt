//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Sergey Lukaschuk on 13.06.2022.
//

import UIKit

class EmojiArtViewController: UIViewController {

    @IBOutlet weak var emojiCollectionView: UICollectionView! {
        didSet {
            emojiCollectionView.dataSource = self
            emojiCollectionView.delegate = self
        }
    }

    @IBOutlet weak var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 5.0
            scrollView.delegate = self
            scrollView.addSubview(emojiArtView)
        }
    }

    var emojiArtBackgroundImage: UIImage? {
        get {
            return emojiArtView.backgroundImage
        }

        set {
            scrollView.zoomScale = 1.0
            emojiArtView.backgroundImage = newValue
            let size = newValue?.size ?? CGSize.zero
            emojiArtView.frame = CGRect(origin: CGPoint.zero, size: size)
            scrollView.contentSize = size
            if let dropZone = dropZone, size.width > 0, size.height > 0 {
                scrollView.zoomScale = max(dropZone.bounds.size.width / size.width, dropZone.bounds.size.height / size.height)
            }
        }
    }

    var imageFetcher: ImageFetcher!

    var emojiArtView = EmojiArtView()

    var emojis = "😎🐶🐱🦅🐤🐛🐜🐦🙉🐕‍🦺🐈‍⬛🦩🦜🐄🦍🌲🎄🧞‍♂️🧑‍🎄👨🏻‍💻👩😻🎃💩🤢🤩😍".map { String($0) }

    override func viewDidLoad() {
        print(emojis)
    }

}



// MARK: - DropInteraction and ScrollView - Delegate
extension EmojiArtViewController: UIDropInteractionDelegate, UIScrollViewDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {

        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                self.emojiArtBackgroundImage = image
            }
        }

        session.loadObjects(ofClass: NSURL.self) { nsurls in
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
            }
        }

        session.loadObjects(ofClass: UIImage.self) { images in
            if let image = images.first as? UIImage {
                self.imageFetcher.backup = image
            }
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return emojiArtView
    }
}


// MARK: - CollectionView Delegate, DataSource
extension EmojiArtViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath)

        return cell
    }


}

