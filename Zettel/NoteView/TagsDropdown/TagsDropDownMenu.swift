//
//  TagsDropDownViewController.swift
//  Zettel
//
//  Created by Vsevolod Moiseenkov on 18.11.2021.
//

import UIKit

class TagsDropDownMenu: UIViewController {
    private var cellNumberOfNote: Int?
    private var cellNumberOfTag: Int?
    init ( _ cellNumberOfNote: Int?, _ cellNumberOfTag: Int?){
        super.init(nibName: nil, bundle: nil)
        self.cellNumberOfNote = cellNumberOfNote
        self.cellNumberOfTag = cellNumberOfTag
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let service: NotesServiceProtocol = NotesService()
    private var tagList = [Tag]()
    private var tagTableView = UITableView()
    private var selectedTags = [Tag]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Теги"
        
        tagList = service.getTags()
        tagList.remove(at: 0)
        
        setupTableView()
        
        setupConstraints()
        setupNavigationItem()
    }
    
    func setupNavigationItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapDoneButton))
    }
    
    func setupTableView() {
        view.addSubview(tagTableView)
        tagTableView.delegate = self
        tagTableView.dataSource = self
        tagTableView.translatesAutoresizingMaskIntoConstraints = false
        tagTableView.tableFooterView = UIView()
        
        tagTableView.register(UINib(nibName: "TagCell", bundle: nil), forCellReuseIdentifier: "TagCell")
        
        tagTableView.allowsMultipleSelection = true
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            tagTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tagTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tagTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tagTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
            
    @objc private func didTapDoneButton() {
        selectedTags.removeAll()
        service.deleteAllTagsByNote(cellNumberOfTag: cellNumberOfTag, cellNumberOfNote: cellNumberOfNote)
        if let selectedRows = tagTableView.indexPathsForSelectedRows{
//            service.deleteAllTagsByNote(cellNumberOfTag: cellNumberOfTag, cellNumberOfNote: cellNumberOfNote)
            for iPath in selectedRows{
                selectedTags.append(tagList[iPath.row])
                service.addTagToNote(cellNumberOfTag: cellNumberOfTag, cellNumberOfNote: cellNumberOfNote, tagName: tagList[iPath.row].name)
            }
            
            print("----You have selectes Items -----")
            for tag in selectedTags{
                print(tag)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension TagsDropDownMenu: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {//кол-во ячеек в секции
        return tagList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {//высота ячеек
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tagTableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as? TagCell
//        let tag = tagList[indexPath.row]
//        cell?.configure(with: tag)
        
        cell?.tagLabel.text = String(tagList[indexPath.row].name)
        cell?.selectionStyle = .none
        
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tagTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tagTableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
