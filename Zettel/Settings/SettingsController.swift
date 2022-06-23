//
//  SettingsControllerViewController.swift
//  Zettel
//
//  Created by Михаил Трапезников on 12.12.2021.
//

import UIKit

class SettingsController: UIViewController {
	
	// View style elements START SECTION
	let infoView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true
		view.layer.borderColor = UIColor.gray.cgColor
		view.layer.borderWidth = 2
		return view
	}()
	
	let teamName: UILabel = {
		let label = UILabel()
		label.text = "Team: "
		label.font = UIFont(name: label.font.fontName, size: 16.0)
		label.textAlignment = .center
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let teamNameLabel: UILabel = {
		let label = UILabel()
		label.text = "zettel team"
		label.font = UIFont.boldSystemFont(ofSize: 16.0)
		label.textAlignment = .center
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let versionLabel: UILabel = {
		let label = UILabel()
		label.text = "Version: "
		label.font = UIFont(name: label.font.fontName, size: 16.0)
		label.textAlignment = .center
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let versionNumLabel: UILabel = {
		let label = UILabel()
		label.text = "1.0"
		label.font = UIFont.boldSystemFont(ofSize: 16.0)
		label.textAlignment = .center
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let verticalSeparator: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let nameSeparator: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let logoutButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .black
		button.setTitle("Logout", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.layer.cornerRadius = 5
		button.addTarget(self, action: #selector(LogoutButtonTapped), for: .touchUpInside)
		return button
	}()
	// View style elements END SECTION
	
	// START SETUP SECTION
	func setupInfoView() {
		view.addSubview(infoView)
		
		infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		infoView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
		infoView.heightAnchor.constraint(equalToConstant: 120).isActive = true
	}
	
	func setupVerticalSeparator() {
		view.addSubview(verticalSeparator)
		
		verticalSeparator.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 2).isActive = true
		verticalSeparator.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
		verticalSeparator.widthAnchor.constraint(equalToConstant: 1).isActive = true
		verticalSeparator.heightAnchor.constraint(equalTo: infoView.heightAnchor, constant: -4).isActive = true
	}
	
	func setupTeamName() {
		view.addSubview(teamName)
		
		teamName.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 12).isActive = true
		teamName.topAnchor.constraint(equalTo: infoView.topAnchor).isActive = true
		teamName.rightAnchor.constraint(equalTo: verticalSeparator.leftAnchor, constant: -12).isActive = true
		teamName.heightAnchor.constraint(equalTo: infoView.heightAnchor, multiplier: 1/2).isActive = true
	}
	
	func setupTeamNameLabel() {
		view.addSubview(teamNameLabel)
		
		teamNameLabel.leftAnchor.constraint(equalTo: verticalSeparator.rightAnchor, constant: 12).isActive = true
		teamNameLabel.topAnchor.constraint(equalTo: infoView.topAnchor).isActive = true
		teamNameLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 12).isActive = true
		teamNameLabel.heightAnchor.constraint(equalTo: infoView.heightAnchor, multiplier: 1/2).isActive = true
	}
	
	func setupNameSeparator() {
		view.addSubview(nameSeparator)
		
		nameSeparator.topAnchor.constraint(equalTo: teamName.bottomAnchor).isActive = true
		nameSeparator.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 2).isActive = true
		nameSeparator.widthAnchor.constraint(equalTo: infoView.widthAnchor, constant: -4).isActive = true
		nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
	}
	
	func setupVersion() {
		view.addSubview(versionLabel)
		
		versionLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 12).isActive = true
		versionLabel.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor).isActive = true
		versionLabel.rightAnchor.constraint(equalTo: verticalSeparator.leftAnchor, constant: -12).isActive = true
		versionLabel.heightAnchor.constraint(equalTo: infoView.heightAnchor, multiplier: 1/2).isActive = true
	}
	
	func setupVersionNum() {
		view.addSubview(versionNumLabel)
		
		versionNumLabel.leftAnchor.constraint(equalTo: verticalSeparator.rightAnchor, constant: 12).isActive = true
		versionNumLabel.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor).isActive = true
		versionNumLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 12).isActive = true
		versionNumLabel.heightAnchor.constraint(equalTo: infoView.heightAnchor, multiplier: 1/2).isActive = true
	}
	
	func setupLogOutButton() {
		view.addSubview(logoutButton)
		
		logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		logoutButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 12).isActive = true
		logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
		logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	// END SETUP SECTION
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Settings"
		self.view.backgroundColor = .white
		
		setupInfoView()
		setupVerticalSeparator()
		setupTeamName()
		setupTeamNameLabel()
		setupNameSeparator()
		setupVersion()
		setupVersionNum()
		setupLogOutButton()
    }
	
	// LogOut Button
	@objc func LogoutButtonTapped() {
		print("Logged Out")
		let loginController = LoginViewController()
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.window?.rootViewController = loginController
	}
}
