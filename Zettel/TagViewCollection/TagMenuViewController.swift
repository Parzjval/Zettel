//
//  TagMenuViewController.swift
//  Zettel
//
//  Created by Михаил Трапезников on 30.10.2021.
// создаем вид коллекции

import UIKit

final class TagMenuViewController: UIViewController {

    // CollectionView Section
    lazy var tagMenu: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        //регистация ячейки TagItem
        collectionView.register(.init(nibName: "TagItem", bundle: nil), forCellWithReuseIdentifier: "TagItem")
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        
        return collectionView
    }()
    // End of CoolectionView section
    
    // SearchBar section
	lazy var searchBar : UISearchBar = {
        let s = UISearchBar()
        s.tintColor = UIColor.black.withAlphaComponent(1.0)
        s.placeholder = "Search tags"
        s.delegate = self
        s.backgroundColor = UIColor.clear
        s.barTintColor = UIColor.clear
        s.searchBarStyle = .minimal
        s.returnKeyType = .search
        s.showsCancelButton = false
        s.showsBookmarkButton = false
        s.sizeToFit()
        
        return s
    }()
    
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.searchResultsUpdater = self
        s.obscuresBackgroundDuringPresentation = false
        s.definesPresentationContext = true
        
        return s
    }()
    
    private var searchActive: Bool = false
    // End of SearchBar section 
    
	// Tag Cell's parameters
    private let cellOffset: CGFloat = 12
    private let numberOfItemsPerRow: CGFloat = 3
	// End of cell's parameters
	
    // TagLists
    private var tags: [Tag] = []
    private var filtered: [Tag] = []
    // End of TagLists
	
	// CollectionViewLayout(contraints)
    private func setupCollectionViewLayout() {
        self.view.addSubview(tagMenu)
        
        tagMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tagMenu.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tagMenu.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tagMenu.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
	// TagList updater
	func updateTagLists() {
		tags = TagManager.shared.loadTags()
		print(tags)
		filtered = tags
		tagMenu.reloadData()
	}
	
	// A part of viewDidLoad for refreshing TagLists
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        updateTagLists()
		self.navigationItem.hidesSearchBarWhenScrolling = false
    }
	
	// Top BarButtons
	// - New Tag button -> TagCreator
	lazy var createTagButton: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Tag", style: .plain, target: self, action: #selector(TagButtonTapped(_:)))
		return button
	}()
	// - Select Tags button -> Delete cells
	lazy var selectTagsButton: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(SelectTagsButtonTapped(_:)))
		return button
	}()
	// - Delete Tags button -> Delete selected cells
	lazy var deleteTagsButton: UIBarButtonItem = {
		let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(DeleteTagsButtonTapped(_:)))
		return button
	}()
	// - Cancel button -> remove selection
	lazy var cancelButton: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelButtonTapped(_:)))
		return button
	}()
    
	// Mode: change Tag celect behavior
	var TagSelectMode: String = "view" {
		didSet {
			switch TagSelectMode {
			// view mode: tap Tag cell -> go to TableView of notes
			case "view":
				self.navigationItem.rightBarButtonItem = createTagButton
				self.navigationItem.leftBarButtonItem = selectTagsButton
				tagMenu.allowsMultipleSelection = false
			// select mode: tap Tag cell -> Tag selected
			case "select":
				self.navigationItem.rightBarButtonItem = deleteTagsButton
				self.navigationItem.leftBarButtonItem = cancelButton
				tagMenu.allowsMultipleSelection = true
			default:
				print("Unknown type of TagSelectMode: \(TagSelectMode)")
				break
			}
		}
	}
	
	// TagList with selected/not selected
	var selectedTags: [IndexPath: Bool] = [:]
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagMenu.backgroundColor = .white
        title = "zettel data"
        
        self.navigationItem.searchController = searchController
        
		TagSelectMode = "view"
        
        setupCollectionViewLayout()
    }
	
	// Buttons behavior
	// - TagCreator Button -> Create New Tag element
    @objc func TagButtonTapped(_ sender: UIBarButtonItem!)
    {
        let viewController = TagCreator()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
	
	// - TagSelect Button -> Change Tag's cell view
	@objc func SelectTagsButtonTapped(_ sender: UIBarButtonItem!)
	{
		TagSelectMode = "select"
		print("Select tapped")
	}
	
	let service: NotesServiceProtocol = NotesService()
	
	// - Delete button -> remove selected tags from service
	@objc func DeleteTagsButtonTapped(_ sender: UIBarButtonItem)
	{
		// Call service.removeTags(TagList)
		var removingTags: [Tag] = []
		for (curIndPath, value) in selectedTags {
			if value {
				removingTags.append(filtered[curIndPath.row])
			}
		}
		
		service.deleteTags(tags: removingTags)
		updateTagLists()
		TagSelectMode = "view"
		selectedTags.removeAll()
		print("Delete tapped")
	}
	
	// - Cancel button -> remove selection
	@objc func CancelButtonTapped(_ sender: UIBarButtonItem)
	{
		for (indPath, value) in selectedTags {
			if value {
				tagMenu.deselectItem(at: indPath, animated: true)
			}
		}
		selectedTags.removeAll()
		TagSelectMode = "view"
		print("Cancel tapped")
	}
}

// SearchBar search behavior delegating
extension TagMenuViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if searchBar.text!.isEmpty {
            filtered = tags
            self.tagMenu.reloadData()
        } else {
            filtered = tags.filter({ (item) -> Bool in
                
                return (item.name.localizedStandardContains(String(searchBar.text!)))
            })
            self.tagMenu.reloadData()
        }
    }
}

// Tag's Cell Layout, DataSource and Click behaviour delegating
extension TagMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //создаем ячейку и приводим к нашему типу TagItem если не получилось отдаем пустую
        guard let cell = tagMenu.dequeueReusableCell(withReuseIdentifier: "TagItem", for:
                                                        indexPath) as? TagItem else {
            return .init()
        }
        
        let tag = filtered[indexPath.row]
        cell.configure(with: tag)
        
        return cell
    }
    // задаем количество элементов в коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtered.count
    }
}

// задаем размеры
extension TagMenuViewController: UICollectionViewDelegateFlowLayout {
    //высота и ширина ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = (tagMenu.frame.width) - cellOffset * (numberOfItemsPerRow + 1)
        let cellWidth = availableWidth / numberOfItemsPerRow
        
        return CGSize(width: cellWidth-1, height: cellWidth-1)
    }
    //тоже размеры
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: cellOffset, bottom: 0, right: cellOffset)
    }
    //расстояние между ячейкам по вертикали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellOffset
    }
    //тоже размеры
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if TagSelectMode == "view" {
			tagMenu.deselectItem(at: indexPath, animated: true)
			let tag = filtered[indexPath.row]
        
			let viewController = TagNotes(indexPath.row)
			//let navController = UINavigationController(rootViewController: viewController)
        
			viewController.tag = tag
        
			navigationController?.pushViewController(viewController, animated: true)
		} else {
			print("Tag selected")
			if (indexPath == [0, 0]) {
				tagMenu.deselectItem(at: [0, 0], animated: true)
			} else {
				selectedTags[indexPath] = true
			}
		}
    }
	
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		if TagSelectMode == "select" {
			selectedTags[indexPath] = false
		}
	}
}
