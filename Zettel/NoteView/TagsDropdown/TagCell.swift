//
//  TagCell.swift
//  Zettel
//
//  Created by Vsevolod Moiseenkov on 18.11.2021.
//

import UIKit

class TagCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.masksToBounds = true //флаг,чтоб сабвьюхи не могли выходить за пределы вьюхи
        containerView.backgroundColor = .white
    }

    func configure(with tag: Tag){
        tagLabel.text = tag.name
    }
}
