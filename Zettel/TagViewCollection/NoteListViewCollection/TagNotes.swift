//
//  TagNotes.swift
//  Zettel
//
//  Created by Михаил Трапезников on 30.10.2021.
//

import UIKit

final class TagNotes: UIViewController {
    
    private var cellNumberOfTag: Int?
    init ( _ cellNumberOfTag: Int?){
        super.init(nibName: nil, bundle: nil)
        self.cellNumberOfTag = cellNumberOfTag
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var tableVisibility = true
    lazy var collectionNoteList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.delegate = self
        collView.dataSource = self
        collView.register(.init(nibName: "TagNotesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagNotesCollectionViewCell")
        collView.backgroundColor = .white
        collView.isHidden = true
        return collView
    }()
    
    lazy var tableNoteList: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none //линии между ячейками
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "TagNote", bundle: nil), forCellReuseIdentifier: "TagNote")
        tableView.rowHeight = 96
        tableView.estimatedRowHeight = 96
        return tableView
    }()
    let service: NotesServiceProtocol = NotesService()
    private var notes: [Note] = []
//    private let rowOffset: CGFloat = 8
    
    var tag: Tag? //{
//        didSet {
//            guard let tag = tag else {
//                return
//            }
//
//           configure(with: tag)
//        }
//    }
    private func setupCollectionViewLayout() {
        self.view.addSubview(collectionNoteList)
        collectionNoteList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionNoteList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionNoteList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionNoteList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }


    private func setupTableViewLayout() {
        self.view.addSubview(tableNoteList)
        
        tableNoteList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableNoteList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableNoteList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableNoteList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = tag?.name
        view.backgroundColor = .white
        
        let rightButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showEditing))
        let button = UIBarButtonItem(image: UIImage(named: "switchVisibilityButton"), style: .plain, target: self, action: #selector(switchView))
        //self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.setRightBarButtonItems([rightButton, button], animated: true)
        
        notes = NoteManager.shared.loadNotes(tag: tag!)
        setupTableViewLayout()
        setupCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notes = NoteManager.shared.loadNotes(tag: tag!)
        tableNoteList.reloadData()
        collectionNoteList.reloadData()
    }
    
    @objc func switchView(sender: UIBarButtonItem){
        if tableVisibility {
            tableNoteList.isHidden = true
            collectionNoteList.isHidden = false
            tableVisibility = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            collectionNoteList.isHidden = true
            tableNoteList.isHidden = false
            tableVisibility = true
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

    @objc func showEditing(sender: UIBarButtonItem){
        if (self.tableNoteList.isEditing == true) {
            self.tableNoteList.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        } else {
            self.tableNoteList.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
    }
}

extension TagNotes: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableNoteList.dequeueReusableCell(withIdentifier: "TagNote", for: indexPath) as? TagNote else {
            return .init()
        }
        
        let note = notes[indexPath.row]
        
        cell.configure(with: note)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableNoteList.deselectRow(at: indexPath, animated: true)
        let viewController = NoteViewController(indexPath.row, cellNumberOfTag)

        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        service.deleteNote(cellNumberOfTag: cellNumberOfTag, cellNumberOfNote: indexPath.row)
        notes = NoteManager.shared.loadNotes(tag: tag!)
        tableView.deleteRows(at: [indexPath], with: .fade)
        self.collectionNoteList.reloadData()
    }
}

extension TagNotes: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagNotesCollectionViewCell", for: indexPath) as? TagNotesCollectionViewCell else {
            return .init()
        }
        let note = notes[indexPath.row]
        cell.configure(with: note, and: notes.count, numberOfNote: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionNoteList.frame.width - 50*2
        let availableHeight = collectionNoteList.frame.height

        return CGSize(width: availableWidth, height: availableHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}
