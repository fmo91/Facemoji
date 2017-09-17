//
//  EditorEmojiCollectionViewCell.swift
//  Facemoji
//
//  Created by Fernando Ortiz on 9/9/17.
//  Copyright © 2017 Fernando Ortiz. All rights reserved.
//

import UIKit

class EditorEmojiCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var emojiImageView: UIImageView!
    
    func configure(with image: UIImage) {
        self.emojiImageView.image = image
    }
}
