//
//  TagCreator.swift
//  Zettel
//
//  Created by Михаил Трапезников on 01.12.2021.
//

import UIKit

class TagCreator: UIViewController {

    lazy var TextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 10.0, y: 10.0, width: self.view.frame.width-20.0, height: 40.0))
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.center.x = self.view.center.x
        textView.center.y = 200
        
        
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = UIColor.lightGray
        textView.font = .systemFont(ofSize: 16)
        
        textView.text = "Enter Tag name"
        textView.backgroundColor = UIColor.white
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2
        textView.delegate = self
        
        return textView
    }()
    
    let service: NotesServiceProtocol = NotesService()
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationItem.searchController = searchController
        //self.view = UIView()
        
        self.view.backgroundColor = .white
        
        self.title = "New Tag"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.SaveButtonTapped(_:)))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.CancelButtonTapped(_:)))
        
        self.view.addSubview(TextView)
    }
    
    @objc func SaveButtonTapped(_ sender: UIBarButtonItem!)
    {
        let newTag = Tag(name: TextView.text)
        print(newTag)
        //Save tag
        
        self.service.addNewTagInTagList(tag: newTag)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func CancelButtonTapped(_ sender: UIBarButtonItem!)
    {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension TagCreator: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.TextView.text = ""
        self.TextView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.TextView.text = "Enter Tag name"
        self.TextView.textColor = UIColor.lightGray
    }
}
