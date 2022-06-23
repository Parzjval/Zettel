//
//  Note.swift
//  Zettel
//
//  Created by Михаил Трапезников on 31.10.2021.
//

import Foundation

struct Note {
    let identifier: String = UUID().uuidString
    let content: String
    let dateLastModified: Date
    let tag: Tag
}
