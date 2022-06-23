//
//  Note.swift
//  Zettel
//
//  Created by Михаил Трапезников on 31.10.2021.
//

import Foundation

//struct Note {
//    let identifier: String = UUID().uuidString
//    let content: String
//    let tag: Tag
//}

struct RawNote: Codable {
    var title: String?
    var text: String?
    var tagListThisNote: Set<Tag> = []
}

final class Note: Codable {
    var id: Int?
    var raw: RawNote
    init (raw: RawNote) {
        self.raw = raw
    }
    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
    
}




