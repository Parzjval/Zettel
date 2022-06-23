    //
    //  TagCollectionViewController.swift
    //  Zettel
    //
    //  Created by Vsevolod Moiseenkov on 13.11.2021.
    //

import Foundation
import UIKit

class TagCollectionViewController: UIViewController {
    private var cellNumberOfNote: Int?
    private var cellNumberOfTag: Int?
    init (_ cellNumberOfNote: Int?, _ cellNumberOfTag: Int?){
        super.init(nibName: nil, bundle: nil)
        self.cellNumberOfNote = cellNumberOfNote
        self.cellNumberOfTag = cellNumberOfTag
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let service: NotesServiceProtocol = NotesService()
    lazy var tagLine: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: TagCollectionViewController.makeLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
        
        return collectionView
    }()
    private let cellHeight: CGFloat = 30
    private let cellsOffset: CGFloat = 3
    private let numberOfItemsPerRow: CGFloat = 4
    
    private var tags: [Tag] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tagLine)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let note = service.returnNoteForFuncAddTagToNote(){
            tags = Array(service.getTagListByNote(note: note))
        } else {
            tags = Array(service.getTagListByNewNote())
            print("Exception in viewWillAppear of TagCollectionViewController")
        }
        tagLine.reloadData()
        print(tags)
    }
    
    private func getNote() -> Note? {
        guard let nOfTag = cellNumberOfTag, let nOfNote = cellNumberOfNote else { return nil}
        return service.findNote(cellNumberOfTag: nOfTag, cellNumberOfNote: nOfNote)
    }
    
    func removeTags(){
        tags.removeAll()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tagLine.topAnchor.constraint(equalTo: view.topAnchor),
            tagLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tagLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tagLine.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    static func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension TagCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as? TagCollectionViewCell else {
            return .init()
        }

        let tag = tags[indexPath.row]
        cell.configure(with: tag)
        
//        cell.configure(with: defaultTag)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
//        10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

extension TagCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let availableWidth = collectionView.frame.width - cellsOffset * (numberOfItemsPerRow + 1)
//        let cellWidth = availableWidth / numberOfItemsPerRow
        let cellWidth: CGFloat = 100

        return CGSize(width: cellWidth, height: cellHeight)
    }
}

