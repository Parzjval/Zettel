//
//  TagCollectionViewCell.swift
//  Zettel
//
//  Created by Vsevolod Moiseenkov on 13.11.2021.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.tagLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        self.tagLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contentView.layer.cornerRadius = 10
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var frame = layoutAttributes.frame
//        frame.size.height = ceil(size.height)
//        layoutAttributes.frame = frame
//        return layoutAttributes
//    }

    func configure(with tag: Tag) {
        tagLabel.text = tag.name
    }
}
