//
//  TagManager.swift
//  Zettel
//
//  Created by Михаил Трапезников on 30.10.2021.
//

import Foundation

protocol TagManagerProtocol {
    func loadTags() -> [Tag]
    func getTag(tag: Tag) -> Tag?
}

final class TagManager: TagManagerProtocol {
    
    static var tagList: [Tag]  = []
    
    static let shared: TagManagerProtocol = TagManager()
    
    private init() {
        setTags()
    }
    
    func setTags() {
        TagManager.tagList = [
            Tag(name: "Without tags", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Productivity", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Social Media", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Film Ratings", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Programming", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Devices", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Math", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Articles", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Projects", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Computer Architecture", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Silicon Valley", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "VCS", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Project Managment", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "My Blog", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Sites Design", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Without tags1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Productivity1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Social Media1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Film Ratings1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Programming1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Devices1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Math1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Articles1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Projects1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Computer Architecture1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Silicon Valley1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "VCS1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Project Managment1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "My Blog1", BackgroundColor: ColorManager.shared.getColor()),
            Tag(name: "Sites Design1", BackgroundColor: ColorManager.shared.getColor()),
        ]
    }
    
    func loadTags() -> [Tag] {
        return TagManager.tagList
    }
    
    func getTag(tag: Tag) -> Tag? {
        for el in TagManager.tagList {
            if el == tag {
                return el
            }
        }
        return nil
    }
}
