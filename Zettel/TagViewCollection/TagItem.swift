//
//  TagItem.swift
//  Zettel
//
//  Created by Михаил Трапезников on 30.10.2021.
// создаем вида каждой ячейки

import UIKit

final class TagItem: UICollectionViewCell {

    @IBOutlet weak var TagName: UILabel!
    @IBOutlet weak var NumNotes: UILabel!
	@IBOutlet weak var SelectImage: UIImageView!
	@IBOutlet weak var BlureView: UIView!
	
	override var isHighlighted: Bool {
		didSet {
			BlureView.isHidden = !isHighlighted
			
		}
	}
	
	override var isSelected: Bool {
		didSet {
			SelectImage.isHidden = !isSelected
			BlureView.isHidden = !isSelected
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		BlureView.isHidden = true
		SelectImage.isHidden = true
        contentView.backgroundColor = .systemGray
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
    }
    // метод конфигурции ячейки с определнными данными tag
    func configure(with tag: Tag) {
        contentView.backgroundColor = ColorManager.shared.getColor()
        TagName.text = tag.name
        if TagName.text == "Without tags" {
            contentView.backgroundColor = ColorManager.specialColor.color
            contentView.layer.borderWidth = 4
            contentView.layer.borderColor = UIColor.systemGray.cgColor
        } else {
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor.black.cgColor
        }
        NumNotes.text = String(NoteManager.shared.loadNotes(tag: tag).count)
        TagName.numberOfLines = 0
    }

}
