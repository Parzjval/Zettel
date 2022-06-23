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
    
    static let shared: NoteManagerProtocol = NoteManager()
    
    static var notes: [Note] = []
    
    private init() {
        setNotes()
    }
    
    func loadNotes(tag: Tag) -> [Note] {
        var notes: [Note] = []
        
        for el in NoteManager.notes {
            if el.tag == tag  {
                notes.append(el)
            }
        }
        
        return notes
    }
    
    func setNotes() {
        NoteManager.notes = [
            Note(content: "Check1", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check2", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check3", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check4", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check5", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check6", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check7", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check8", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check9", dateLastModified: Date(), tag: Tag(name: "MyBlog")),
            Note(content: "Check10", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check11", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check12", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check13", dateLastModified: Date(), tag: Tag(name: "VCS")),
            Note(content: "Check14", dateLastModified: Date(), tag: Tag(name: "Productivity")),
            
        ]
    }
    
}
