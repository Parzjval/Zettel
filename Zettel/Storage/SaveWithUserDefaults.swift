//
//  SaveWithUserDefaults.swift
//  Zettel
//
//  Created by ArtemVolosatov on 10.12.2021.
//

import Foundation

final class SaveWithUserDefaults {
    
    static let shared = SaveWithUserDefaults()
    
    private enum keys: String {
        case noteList
        case tagList
        case tagStorage
    }
    
//    private func isKeyPresentInUserDefaults(key: String) -> Bool {
//        return UserDefaults.standard.object(forKey: key) != nil
//    }
    
    func loadNoteList() -> [Note] {
        if let data = UserDefaults.standard.data(forKey: keys.noteList.rawValue) {
            do {
                let decoder = JSONDecoder()
                let noteList = try decoder.decode([Note].self, from: data)
                print ("load noteList")
                return noteList
            } catch {
                print ("unable to decode array of notes")
            }
        } else {
            print ("save noteList is empty")
        }
        return []
    }
    
    func saveNoteList(newValue: [Note]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newValue)
            //UserDefaults.standard.removeObject(forKey: keys.noteList.rawValue)
            UserDefaults.standard.set(data, forKey: keys.noteList.rawValue)
            print ("save noteList")
        } catch {
            print ("unable to encode array of notes")
        }
    }
    
    func loadTagStorage() -> [Tag:[Note]] {
        if let data = UserDefaults.standard.data(forKey: keys.tagStorage.rawValue) {
            do {
                let decoder = JSONDecoder()
                let tagStorage = try decoder.decode([Tag:[Note]].self, from: data)
                print ("load tagStorage")
                return tagStorage
            } catch {
                print ("unable to decode dict tagStorage")
            }
        } else {
            print ("save tagStorage is empty")
        }
        return [defaultTag:[]]
    }
    
    func saveTagStorage(newValue: [Tag:[Note]]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: keys.tagStorage.rawValue)
            print ("save tagStorage")
        } catch {
            print ("unable to encode dict tagStorage")
        }
    }
    
    func loadTagList() -> [Tag] {
//        UserDefaults.standard.removeObject(forKey: keys.noteList.rawValue)
//        UserDefaults.standard.removeObject(forKey: keys.tagList.rawValue)
//        UserDefaults.standard.removeObject(forKey: keys.tagStorage.rawValue)
        if let data = UserDefaults.standard.data(forKey: keys.tagList.rawValue) {
            do {
                let decoder = JSONDecoder()
                let tagList = try decoder.decode([Tag].self, from: data)
                print ("load tagList")
                return tagList
            } catch {
                print ("unable to decode array of tags")
            }
        } else {
            print ("save tagList is empty")
        }
        return [defaultTag]
    }
    
    func saveTagList(newValue: [Tag]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: keys.tagList.rawValue)
            print ("save tagList")
        } catch {
            print ("unable to encode array of tags")
        }
    }
}

