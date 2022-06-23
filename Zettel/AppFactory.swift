//
//  AppFactory.swift
//  Zettel
//
//  Created by Vsevolod Moiseenkov on 11.10.2021.
//

import UIKit

class AppFactory{
    
    func buildTabBarController() -> UITabBarController{
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([buildNoteViewController(), buildTagMenuViewController(), buildNotesViewController()], animated: true)
        tabBarController.selectedIndex = 1
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        return tabBarController
    }
    
    func buildNotesViewController() -> UIViewController{
        let settingsViewController = SettingsController()
        let tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), selectedImage: nil)
        settingsViewController.tabBarItem = tabBarItem
		let navTagMenuNavigationController = UINavigationController(rootViewController: settingsViewController)
		
		navTagMenuNavigationController.view.backgroundColor = .white
        return navTagMenuNavigationController
    }
    
    func buildNoteViewController() -> UIViewController{
        let noteViewController = NoteViewController(nil, nil)
        noteViewController.title = "Заметка"
        let tabBarItem = UITabBarItem(title: "Note", image: UIImage(named: "note"), selectedImage: nil)
        noteViewController.tabBarItem = tabBarItem
        let noteViewNavigationController = UINavigationController(rootViewController: noteViewController)
        
        noteViewNavigationController.view.backgroundColor = .white
        noteViewNavigationController.navigationBar.backgroundColor = .white
        return noteViewNavigationController
    }

    func buildTagMenuViewController() -> UIViewController{
        let tagMenuViewController = TagMenuViewController()
        let tabBarItem = UITabBarItem(title: "tags", image: UIImage(named: "tag"), selectedImage: nil)
        tagMenuViewController.tabBarItem = tabBarItem
        let navTagMenuNavigationController = UINavigationController(rootViewController: tagMenuViewController)
        
        navTagMenuNavigationController.view.backgroundColor = .white
        return navTagMenuNavigationController
    }
    
}
