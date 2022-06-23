//
//  TagNote.swift
//  Zettel
//
//  Created by Михаил Трапезников on 31.10.2021.
//

import UIKit

final class TagNote: UITableViewCell {

    @IBOutlet weak var noteHeader: UILabel!
    @IBOutlet weak var noteContent: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
    
    var minHeight: CGFloat?
    private var d_format = DateFormatter()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //внешний вид ячейки
        noteHeader.font = .systemFont(ofSize: 18, weight: .semibold)
        noteContent.textColor = .darkGray
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 0.5
        contentView.layer.shadowOffset = .init(width: 0.5, height: 1.5)
        contentView.layer.shadowOpacity = 0.8
        contentView.backgroundColor = UIColor(named: "colorNoteCell")
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        d_format.dateFormat = "dd:MM:yyyy"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with note: Note) {
        self.noteContent.text = note.raw.text
        self.noteHeader.text = note.raw.title
        self.noteImageView.image = UIImage(named: "note")
    }
    
}
