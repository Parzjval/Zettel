//
//  testFile.swift
//  Zettel
//
//  Created by ArtemVolosatov on 12.11.2021.
//

import Foundation

let testNote1 = RawNote(title: "noteRaw", text: "nothing", tagListThisNote: [])
let testNote2 = RawNote(title: "noteForAllTags", text: "alfa", tagListThisNote: [
    Tag(name: "tagOne"),
    Tag(name: "tagTwo"),
    Tag(name:"tagThree")
    ])
let testNote3 = RawNote(title: "noteOnlytagOne", text: "epsilon", tagListThisNote: [
    Tag(name: "tagOne")
    ])

//var testNoteList:[Note] = []
//var testTagList:[Tag] = [Tag(name: defaultTag)]
//var testTagStorage:[Tag: [Note]] = [Tag(name: defaultTag):[] ]

//var testNoteList = [
//    Note(raw: RawNote(title: "noteForAll", text: "alfa", tagListThisNote: [
//        Tag(name: "tagOne"),
//        Tag(name: "tagTwo"),
//        Tag(name:"tagThree")
//        ])),
//    Note(raw: RawNote(title: "noteOnlyHere", text: "epsilon", tagListThisNote: [
//        Tag(name: "tagOne")
//        ]))
//    ]
//var testTagList = [
//    Tag(name: defaultTag):[],
//    Tag(name: "tagOne"):[
//    Note(raw: RawNote(title: "noteForAll", text: "alfa", tagListThisNote: [
//        Tag(name: "tagOne"),
//        Tag(id: 2, name: "tagTwo"),
//        Tag(id: 3, name:"tagThree")
//        ])),
//    Note(raw: RawNote(title: "noteOnlyHere", text: "epsilon", tagListThisNote: [
//        Tag(id: 1, name: "tagOne")
//        ]))
//    ],
//    Tag(id: 2, name: "tagTwo"):[
//    Note(raw: RawNote(title: "noteForAll", text: "alfa", tagListThisNote: [
//        Tag(id: 1, name: "tagOne"),
//        Tag(id: 2, name: "tagTwo"),
//        Tag(id: 3, name:"tagThree")
//        ]))
//    ],
//    Tag(id: 3, name: "tagThree"):[
//    Note(raw: RawNote(title: "noteForAll", text: "alfa", tagListThisNote: [
//        Tag(id: 1, name: "tagOne"),
//        Tag(id: 2, name: "tagTwo"),
//        Tag(id: 3, name:"tagThree")
//        ]))
//    ]
//]
