    //
    //  NoteViewController.swift
    //  Zettel
    //
    //  Created by Vsevolod Moiseenkov on 11.10.2021.
    //


import UIKit
import UITextView_Placeholder

class NoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    private var cellNumberOfNote: Int?
    private var cellNumberOfTag: Int?
    private var currentNote: Note?
    private var flagForFuncRemovePlace: Bool = true
    lazy var tagVC: TagCollectionViewController = {
        return TagCollectionViewController(cellNumberOfNote, cellNumberOfTag)
    }()
    init (_ cellNumberOfNote: Int?, _ cellNumberOfTag: Int?){
        super.init(nibName: nil, bundle: nil)
        self.cellNumberOfNote = cellNumberOfNote
        self.cellNumberOfTag = cellNumberOfTag
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let service: NotesServiceProtocol = NotesService()
    private let headerTextField = HeaderTextField()
    private var tagButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.setTitle("Add tag", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(didTapTagButton), for: .touchUpInside)
        return button
    }()
    private let noteTextView = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerTextField.delegate = self
        noteTextView.delegate = self
        
        view.backgroundColor = .white
        
        view.addSubview(headerTextField)
        view.addSubview(tagButton)
        add(tagVC)
        view.addSubview(noteTextView)
        setupSaveButton()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard flagForFuncRemovePlace else {
            flagForFuncRemovePlace = true
            return
        }// здесь загружаются текст заголовка и текст текстВью, перенес во WillAppear, потому что эта функция вызывается каждый раз, когда переходим на NoteViewController
        //let note = service.returnNoteForFuncAddTagToNote()
        let note = getNote()//получеаем заметку
        if note == nil {//если хотим создать новую заметку, то getNote() вернет nil, и создается место для новой заметки
            service.createNewNote()
        }
        setupHeader(note: note)
        setupTextView(note: note)
//        setupTagLine(note: note)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard flagForFuncRemovePlace else {return}//сохранение изменений в существующей заметке, и удаление созданного места, при создании новой заметки
        guard let editedNote = self.currentNote else {
            if getNote() == nil {
                service.removePlaceForCreatedNote()
            }
            return
        }
        service.saveChangesToNote(editedNote: editedNote, title: headerTextField.text, text: noteTextView.text)
        self.currentNote = nil
            //        if let editedNote = self.getNote() {
            //            service.saveChangesToNote(id: editedNote.id!, title: headerTextField.text, text: noteTextView.text)
            //        } else {
            //            service.saveNewNote(title: headerTextField.text, text: noteTextView.text)
            //        }
    }
    
//    override func viewDidDisappear(_ animated: Bool) {//уведомление что заголовок пустой
//        if (headerTextField.text?.isEmpty)!
//        {
//            let alertVC = UIAlertController(title: "Отсутствует заголовок", message:  "Заполните поле заголовка", preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .default))
//            present(alertVC, animated: true, completion: nil)
//        }
//    }
    
    private func getNote() -> Note? {
        guard let nOfTag = cellNumberOfTag, let nOfNote = cellNumberOfNote else { return nil}
        return service.findNote(cellNumberOfTag: nOfTag, cellNumberOfNote: nOfNote)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        headerTextField.resignFirstResponder()
        return true
    }
    
    func setupSaveButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveNote))
    }
    
    private func setupHeader(note: Note?){
            //        headerTextField.becomeFirstResponder()//?
        headerTextField.translatesAutoresizingMaskIntoConstraints = false
        headerTextField.layer.cornerRadius = 20
        headerTextField.spellCheckingType = UITextSpellCheckingType.yes
        headerTextField.font = UIFont.boldSystemFont(ofSize: 25)
        if let selectedNote = note {
            headerTextField.text = selectedNote.raw.title
        } else {
            headerTextField.placeholder = "Заголовок"
        }
    }
    
//    private func setupTagLine(note: Note?){
//        if let selectedNote = note {
//
//        } else {
//            headerTextField.placeholder = "Заголовок"
//        }
//    }
    
    private func setupTextView(note: Note?){
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.contentInsetAdjustmentBehavior = .automatic//поведение скролла
        
        noteTextView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        noteTextView.layer.cornerRadius = 20
        
        noteTextView.placeholder = "Enter your notes here"
        noteTextView.placeholderColor = UIColor.lightGray
            //        noteTextView.attributedPlaceholder =
        
        noteTextView.font = UIFont.systemFont(ofSize: 17)
            //        noteTextView.textColor = UIColor.lightGray
        
        if let selectedNote = note {
            noteTextView.text = selectedNote.raw.text
        }
        
        noteTextView.spellCheckingType = UITextSpellCheckingType.yes
        noteTextView.autocorrectionType = UITextAutocorrectionType.yes
        
            //        noteTextView.font = UIFont(name: "Verdana", size: 49)
            //        noteTextView.font = UIFont.preferredFont(forTextStyle: .body) //для настройки динамического изменнения размера
        
            //серый оттенок
            //        noteTextView.layer.shadowColor = UIColor.gray.cgColor; //чет не работает
            //        noteTextView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
            //        noteTextView.layer.shadowOpacity = 0.4
            //        noteTextView.layer.shadowRadius = 20
            //        noteTextView.layer.masksToBounds = false //?
    }
    
    func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        tagVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            headerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerTextField.heightAnchor.constraint(equalToConstant: 50),
        
            tagButton.topAnchor.constraint(equalTo: headerTextField.bottomAnchor),
            tagButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tagButton.heightAnchor.constraint(equalToConstant: 30),
            
            tagVC.view.centerYAnchor.constraint(equalTo: tagButton.centerYAnchor),
            tagVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tagVC.view.trailingAnchor.constraint(equalTo: tagButton.leadingAnchor, constant: -5),
            tagVC.view.heightAnchor.constraint(equalToConstant: 30),

            noteTextView.topAnchor.constraint(equalTo: tagVC.view.bottomAnchor, constant: 5),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noteTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    @objc func saveNote(){
//        flagForFuncRemovePlace = true
        if let editedNote = self.getNote() {
            service.saveChangesToNote(editedNote: editedNote, title: headerTextField.text, text: noteTextView.text)
        } else {
                //сохраняем новую заметку, очищаем поля и создаем место для еще одной новой заметки
            service.saveNewNote(title: headerTextField.text, text: noteTextView.text)
            service.createNewNote()
            headerTextField.text?.removeAll()
            noteTextView.text.removeAll()
            tagVC.removeTags()
            tagVC.tagLine.reloadData()
        }
    }
    
    @objc
    private func didTapTagButton(){
//        service.deleteAllTagsByNote(cellNumberOfTag: cellNumberOfTag, cellNumberOfNote: cellNumberOfNote)
        self.currentNote = self.getNote()
        flagForFuncRemovePlace = false
        let rootVC = TagsDropDownMenu(cellNumberOfNote, cellNumberOfTag)
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {// Just to be safe, we check that this view controller
            // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
