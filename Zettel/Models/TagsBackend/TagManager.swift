//
//  TagManager.swift
//  Zettel
//
//  Created by Михаил Трапезников on 30.10.2021.
//

import Foundation

protocol TagManagerProtocol {
    //метод который отдает массив тэгов
    func loadTags() -> [Tag]
//    func getTag(tag: Tag) -> Tag?
}

final class TagManager: TagManagerProtocol {
    let service: NotesServiceProtocol = NotesService()
    static var tagList: [Tag]  = []
    //класс синглтон создается в одном экземпляре 
    static let shared: TagManagerProtocol = TagManager()
    
    private init() {
        //для тестирования сервиса
//        service.createNewNote()
//        service.addTagToNote(cellNumberOfTag: nil, cellNumberOfNote: nil, tagName: "firstTag")
//        service.saveNewNote(title: "oneNote", text: "alfa")
//
//        service.createNewNote()
//        service.addTagToNote(cellNumberOfTag: nil, cellNumberOfNote: nil, tagName: "1")
//        service.addTagToNote(cellNumberOfTag: nil, cellNumberOfNote: nil, tagName: "s")
//        service.saveNewNote(title: "twoNote", text: "beta")
////        let id = service.findNote(cellNumberOfTag: 0, cellNumberOfNote: 0).id!
//        service.addTagToNote(cellNumberOfTag: 2, cellNumberOfNote: 0, tagName: "1")
//        
//        let id = service.findNote(cellNumberOfTag: 0, cellNumberOfNote: 0).id!
//        service.saveChangesToNote(id: id, title: "newTitle", text: "psi")
        
//        service.createNewNote()
//        service.saveNewNote(title: nil, text: "teta")
//
//        service.addTagToNote(cellNumberOfTag: 1, cellNumberOfNote: 1, tagName: "AddedTag")

        TagManager.tagList = service.getTags()
    }
    
    func loadTags() -> [Tag] {
        return service.getTags()
    }
    
//    func getTag(tag: Tag) -> Tag? {
//        for el in TagManager.tagList {
//            if el == tag {
//                return el
//            }
//        }
//        return nil
//    }
}
