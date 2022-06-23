//
//  TagNotesCollectionViewCell.swift
//  Zettel
//
//  Created by ArtemVolosatov on 11.12.2021.
//

import UIKit

class TagNotesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var noteNumber: UILabel!
    @IBOutlet weak var noteContetnt: UILabel!
    @IBOutlet weak var noteHeader: UILabel!
    
    @IBOutlet weak var backHeaderNote: UIView!
    @IBOutlet weak var backContentNote: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(named: "backingColor")
        backHeaderNote.layer.cornerRadius = 8
        backHeaderNote.backgroundColor = UIColor(named: "colorBackHeader")
        backContentNote.backgroundColor = UIColor(named: "colorNoteCell")
        backContentNote.layer.cornerRadius = 8
        noteHeader.font = UIFont.systemFont(ofSize: 30)
        noteContetnt.numberOfLines = 0
        noteContetnt.font = UIFont.systemFont(ofSize: 20)
    }
    
    func configure(with note: Note, and amountNumber: Int, numberOfNote: Int) {
        self.noteContetnt.text = note.raw.text
        self.noteHeader.text = note.raw.title
        self.noteNumber.text = "(\(numberOfNote+1)/\(amountNumber))"
    }

}
