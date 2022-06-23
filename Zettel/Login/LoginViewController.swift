//
//  LoginViewController.swift
//  Zettel
//
//  Created by Михаил Трапезников on 12.12.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

	// View style elements START SECTION
	let inputsContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true
		view.layer.borderColor = UIColor.gray.cgColor
		view.layer.borderWidth = 2
		return view
	}()
	
	let loginButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .black
		button.setTitle("Login", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.layer.cornerRadius = 5
		button.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
		return button
	}()
	
	let signUpButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .black
		button.setTitle("Sign Up", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.layer.cornerRadius = 5
		button.addTarget(self, action: #selector(SignUpButtonTapped), for: .touchUpInside)
		return button
	}()
	
	let usernameTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "UserName"
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.autocorrectionType = .no
		return tf
	}()
	
	let passwordTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Password"
		tf.isSecureTextEntry = true
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.autocorrectionType = .no
		return tf
	}()
	
	let separatorTextField: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let Logo: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: label.font.fontName, size: 64)
		label.textColor = .black
		label.text = "zettel"
		label.translatesAutoresizingMaskIntoConstraints = false
		label.contentMode = .scaleAspectFill
		label.textAlignment = .center
		return label
	}()
	
	let errors: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: label.font.fontName, size: 16)
		label.textColor = .red
		label.text = ""
		label.translatesAutoresizingMaskIntoConstraints = false
		label.contentMode = .scaleAspectFill
		label.textAlignment = .center
		label.isHidden = true
		return label
	}()
	// View style elements END SECTION
	
	// START SETUP SECTION
	func setupTextFieldsView() {
		view.addSubview(inputsContainerView)
		
		inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
		inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
	}
	
	func setupLoginButton() {
		view.addSubview(loginButton)
		
		loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
		loginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	func setupSignUpButton() {
		view.addSubview(signUpButton)
		
		signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
		signUpButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	func setupUsernameTextField() {
		view.addSubview(usernameTextField)
		
		usernameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		usernameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
		usernameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24).isActive = true
		usernameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
	}
	
	func setupSeparator() {
		view.addSubview(separatorTextField)
		
		separatorTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 2).isActive = true
		separatorTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor).isActive = true
		separatorTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -4).isActive = true
		separatorTextField.heightAnchor.constraint(equalToConstant: 1).isActive = true
	}
	
	func setupPasswordTextField() {
		view.addSubview(passwordTextField)
		
		passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: separatorTextField.bottomAnchor).isActive = true
		passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24).isActive = true
		passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
	}
	
	func setupLogo() {
		view.addSubview(Logo)
		
		Logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		Logo.bottomAnchor.constraint(equalTo: errors.topAnchor, constant: -3).isActive = true
		Logo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -120).isActive = true
		Logo.heightAnchor.constraint(equalToConstant: 150).isActive = true
	}
	
	func setupErrors() {
		view.addSubview(errors)
		
		errors.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		errors.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -3).isActive = true
		errors.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -120).isActive = true
		errors.heightAnchor.constraint(equalToConstant: 18).isActive = true
	}
	// END SETUP SECTION
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		
		setupTextFieldsView()
		setupLoginButton()
		setupUsernameTextField()
		setupSeparator()
		setupPasswordTextField()
		setupErrors()
		setupLogo()
		setupSignUpButton()
	}
	
	// LogIn Button Authentification
	// Additional function for errors label hiding
	func hideError() {
		UIView.animate(withDuration: 2) {
			self.errors.alpha = 0
		}
	}
	
	@objc func LoginButtonTapped() {
		let email = usernameTextField.text ?? ""
		let password = passwordTextField.text ?? ""
		Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
			if let error = error as NSError? {
				self.errors.alpha = 1
				self.errors.isHidden = false
				switch AuthErrorCode(rawValue: error.code){
				case .operationNotAllowed:
					print("Operations still don't enable.")
					self.errors.text = "Operations still don't enable."
					self.hideError()
				case .userDisabled:
					print("You can't log in.")
					self.errors.text = "You can't log in."
					self.hideError()
				case .wrongPassword:
					print("Wrong password.")
					self.errors.text = "Wrong password."
					self.hideError()
				case .invalidEmail:
					print("Invalid email.")
					self.errors.text = "Invalid email."
					self.hideError()
				default:
					print("Error: \(error.localizedDescription)")
					self.errors.text = "Error: \(error.localizedDescription)"
					self.hideError()
				}
			} else {
				print("User signs in successfully")
				let userInfo = Auth.auth().currentUser
				let email = userInfo?.email
			
				print("User Logged In: Username: \(String(describing: email)).")
				let factory = AppFactory()
				let tabBarController = factory.buildTabBarController()
				let appDelegate = UIApplication.shared.delegate as! AppDelegate
				appDelegate.window?.rootViewController = tabBarController
			}
		}
	}
	
	@objc func SignUpButtonTapped() {
		let email = usernameTextField.text ?? ""
		let password = passwordTextField.text ?? ""
		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
			if let error = error as NSError? {
				self.errors.alpha = 1
				self.errors.isHidden = false
				switch AuthErrorCode(rawValue: error.code) {
				case .operationNotAllowed:
					print("Operations still don't enable.")
					self.errors.text = "Operations still don't enable."
					self.hideError()
				case .emailAlreadyInUse:
					print("Email is already used.")
					self.errors.text = "Email is already used"
					self.hideError()
				case .invalidEmail:
					print("Invalid Email.")
					self.errors.text = "Invalid Email."
					self.hideError()
				case .weakPassword:
					print("Weak password. It has to be at least 6 symbols.")
					self.errors.text = "Weak password"
					self.hideError()
				default:
					print("Error: \(error.localizedDescription)")
					self.errors.text = "Error: \(error.localizedDescription)"
					self.hideError()
				}
		  } else {
			print("User signs up successfully")
			let newUserInfo = Auth.auth().currentUser
			let email = newUserInfo?.email
			print("User signed up with email \(String(describing: email))")
			let factory = AppFactory()
			let tabBarController = factory.buildTabBarController()
			let appDelegate = UIApplication.shared.delegate as! AppDelegate
			appDelegate.window?.rootViewController = tabBarController
		  }
		}
	}
}
