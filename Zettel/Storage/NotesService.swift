//
//  NotesService.swift
//  Zettel
//
//  Created by ArtemVolosatov on 24.10.2021.
//
import Foundation
import UIKit


//  Сохранение заметок
//  Сохранение связей
//  Сохранение в виде базы данных(тег, связь, заметка)
//  Операции создания
//  Операции обновления (удалить/добавить)
//  Настроить отношения многие ко многим: один тег многим заметкам, одна заметка к многим тегам

protocol NotesServiceProtocol {
    //создания места для новой заметки, вызывается когда переходим в раздел создания новой замекти
    func createNewNote()
    //
    func removePlaceForCreatedNote()
    //добавление тэга к заметке как и уже существующей так и новой, так же можно добавить новый тэг,котороый до этого не существовал
    func addTagToNote(cellNumberOfTag: Int?, cellNumberOfNote: Int?, tagName: String)
    //сохранение новой заметки
    func saveNewNote(title: String?, text: String?)
    //получения списка всех тэгов
    func getTags() -> [Tag]
    //получения земеток с таким тэгом
    func getNoteListByTag(tag: Tag) -> [Note]
    //получения тегов заметки
    func getTagListByNote(note: Note) -> Set<Tag>
    //получение всех заметок(вдруг понадобится)
    func getNotes() -> [Note]
    //возвращает заметку, лежащую в ячейке cellNumberOfTag в коллекции тэгов и в ячейке cellNumberOfNote в таблице заметок этого тэга
    func findNote(cellNumberOfTag: Int, cellNumberOfNote: Int) -> Note
    //сохраняет изменения в тексте и заголовке уже существующей заметки
    func saveChangesToNote(editedNote: Note, title: String?, text: String?)
    //
    func deleteNote(cellNumberOfTag: Int?, cellNumberOfNote: Int?)
    func addNewTagInTagList(tag: Tag)
	
	// remove tags from tagList
	func deleteTags(tags: [Tag])
    //
    func getTagListByNewNote() -> Set<Tag>
    //
    func deleteAllTagsByNote(cellNumberOfTag: Int?, cellNumberOfNote: Int?)
    //
    func returnNoteForFuncAddTagToNote() -> Note?
}


final class NotesService: NotesServiceProtocol {
    
    //let defaults = UserDefaults
    private static var noteForFuncAddTagToNote: Note?
    private static var noteList: [Note] = SaveWithUserDefaults.shared.loadNoteList()
    private static var tagStorage:[Tag: [Note]] = SaveWithUserDefaults.shared.loadTagStorage()
    private static var tagList: [Tag] = SaveWithUserDefaults.shared.loadTagList()
    
    func createNewNote() {
        let id = NotesService.noteList.count
        let emptyNote = Note(raw: RawNote(title: nil, text: nil, tagListThisNote: []))
        emptyNote.id = id
        NotesService.noteList.append(emptyNote)
        print (NotesService.noteList.count)
    }
    
    func addTagToNote(cellNumberOfTag: Int?, cellNumberOfNote: Int?, tagName: String) {
        print (NotesService.noteList.count)
        let tag = Tag(name: tagName)
        guard NotesService.tagList.contains(tag) else {return}
        if let nofTag = cellNumberOfTag, let nofNote = cellNumberOfNote {
            let note: Note = NotesService.noteForFuncAddTagToNote!
//            let note = findNote(cellNumberOfTag: nofTag, cellNumberOfNote: nofNote)
            note.raw.tagListThisNote.insert(tag)
            NotesService.tagStorage[tag]?.append(note)
//            if note.raw.tagListThisNote.contains(tag) {
//                return
//            } else {
//                note.raw.tagListThisNote.insert(tag)
//                NotesService.tagStorage[tag]?.append(note)
//            }
        } else {
            let id:Int
            id = NotesService.noteList.count - 1
            NotesService.noteList[id].raw.tagListThisNote.insert(tag)
            NotesService.tagStorage[tag]?.append(NotesService.noteList[id])
        }
    }
    
    func returnNoteForFuncAddTagToNote() -> Note? {
        return NotesService.noteForFuncAddTagToNote
    }
    
    func addNewTagInTagList(tag: Tag) {
        NotesService.tagList.append(tag)
        NotesService.tagStorage[tag] = []
        SaveWithUserDefaults.shared.saveTagStorage(newValue: NotesService.tagStorage)
        SaveWithUserDefaults.shared.saveTagList(newValue: NotesService.tagList)
    }
    
    func removePlaceForCreatedNote(){
        NotesService.noteList.remove(at: NotesService.noteList.count - 1)
        return
    }
    
    func saveNewNote(title: String?, text: String?) {
        if title != "" {
            NotesService.noteList.last?.raw.title = title
            NotesService.noteList.last?.raw.text = text
            if NotesService.noteList.last!.raw.tagListThisNote.isEmpty {
                NotesService.tagStorage[defaultTag]!.append(NotesService.noteList.last!)
            }
            SaveWithUserDefaults.shared.saveNoteList(newValue: NotesService.noteList)
            SaveWithUserDefaults.shared.saveTagStorage(newValue: NotesService.tagStorage)
            SaveWithUserDefaults.shared.saveTagList(newValue: NotesService.tagList)
        } else {
            return
        }
    }
    
    func findNote(cellNumberOfTag: Int, cellNumberOfNote: Int) -> Note {
        let tag: Tag = NotesService.tagList[cellNumberOfTag]
        let note: Note = NotesService.tagStorage[tag]![cellNumberOfNote]//here
        return note
    }
    
    func deleteNote(cellNumberOfTag: Int?, cellNumberOfNote: Int?) {
        let note = findNote(cellNumberOfTag: cellNumberOfTag!, cellNumberOfNote: cellNumberOfNote!)
        for tag in NotesService.tagList {
//            let masThisTag = NotesService.tagStorage[tag] as? [Note] ?? [Note]()
//            if masThisTag.contains(note) {
//            if NotesService.tagStorage[tag]!.contains(where: {$0 == note}) {
            if let index = NotesService.tagStorage[tag]!.firstIndex(where: {$0 == note}) {
                NotesService.tagStorage[tag]!.remove(at: index)
            }
        }
        NotesService.noteList.remove(at: note.id!)
        guard !NotesService.noteList.isEmpty else {return}
        for i in 0...NotesService.noteList.count-1 {
            NotesService.noteList[i].id = i
            print(NotesService.noteList[i].id!)
        }
        SaveWithUserDefaults.shared.saveNoteList(newValue: NotesService.noteList)
        SaveWithUserDefaults.shared.saveTagStorage(newValue: NotesService.tagStorage)
        //NotesService.tagStorage.forEach(){ print($0)}
    }
	
	//TAG DELETING SECTION
	func deleteTags(tags: [Tag]) {
		for tag in tags {
            NotesService.tagStorage[tag] = nil
            for note in NotesService.noteList {
                if note.raw.tagListThisNote.contains(tag) {
                    guard note.raw.tagListThisNote.count != 1 else {
                        note.raw.tagListThisNote.removeAll()
                        NotesService.tagStorage[defaultTag]!.append(note)
                        continue
                    }
                    note.raw.tagListThisNote = note.raw.tagListThisNote.filter{$0.name != tag.name}
                }
            }
			NotesService.tagList = NotesService.tagList.filter{$0.name != tag.name}
		}
        SaveWithUserDefaults.shared.saveNoteList(newValue: NotesService.noteList)
        SaveWithUserDefaults.shared.saveTagStorage(newValue: NotesService.tagStorage)
        SaveWithUserDefaults.shared.saveTagList(newValue: NotesService.tagList)
	}
	
    func deleteAllTagsByNote(cellNumberOfTag: Int?, cellNumberOfNote: Int?){
        let note: Note
        if let nOfTag = cellNumberOfTag, let nOfNote = cellNumberOfNote {
            note = self.findNote(cellNumberOfTag: nOfTag, cellNumberOfNote: nOfNote)
            NotesService.noteForFuncAddTagToNote = note
        } else {
            note = NotesService.noteList.last!
        }
        for tag in NotesService.tagList {
            if let index = NotesService.tagStorage[tag]!.firstIndex(where: {$0 == note}) {
                NotesService.tagStorage[tag]!.remove(at: index)
            }
        }
        note.raw.tagListThisNote.removeAll()
    }
	//END OF TAG DELETING SECTION
    
    func saveChangesToNote(editedNote: Note, title: String?, text: String?) {
        guard let titleOfNote = title else {return}
        editedNote.raw.title = titleOfNote
        editedNote.raw.text = text
        if editedNote.raw.tagListThisNote.isEmpty {
            NotesService.tagStorage[defaultTag]!.append(NotesService.noteList.last!)
        }
        SaveWithUserDefaults.shared.saveNoteList(newValue: NotesService.noteList)
        SaveWithUserDefaults.shared.saveTagStorage(newValue: NotesService.tagStorage)
    }
    
    func getNoteListByTag(tag: Tag) -> [Note] {
        return NotesService.tagStorage[tag]!
    }
    func getTagListByNote(note: Note) -> Set<Tag> {
        return note.raw.tagListThisNote
    }
    func getTagListByNewNote() -> Set<Tag> {
        return (NotesService.noteList.last?.raw.tagListThisNote)!
    }

    func getTags() -> [Tag] {
        return NotesService.tagList
    }
    
    func getNotes() -> [Note] {
        return NotesService.noteList
    }
}

