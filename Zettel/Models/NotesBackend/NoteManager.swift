//
//  NoteManager.swift
//  Zettel
//
//  Created by Михаил Трапезников on 31.10.2021.
//

import Foundation

protocol NoteManagerProtocol {
    func loadNotes(tag: Tag) -> [Note]
}

final class NoteManager: NoteManagerProtocol {
    let service: NotesServiceProtocol = NotesService()
    
    static let shared: NoteManagerProtocol = NoteManager()
    
    static var notes: [Note] = []
    
    private init() {
        NoteManager.notes = service.getNotes()
    }
    
    func loadNotes(tag: Tag) -> [Note] {
        return service.getNoteListByTag(tag: tag)
    }
}
