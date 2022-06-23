//
//  Tag.swift
//  Zettel
//
//  Created by Михаил Трапезников on 30.10.2021.
//
import Foundation
import UIKit

let defaultTag = Tag(name:"withoutTag")

struct Tag: Hashable, Codable {
//    let identifier: String = UUID().uuidString
    let name: String
    //var BackgroundColor: UIColor = .systemGray
    
    static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name == rhs.name
    }
}
