//
//  ViewController.swift
//  Sociogram
//
//  Created by The Steez on 07/03/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGLoginViewController: SGViewController, UITextFieldDelegate {
	
	var username		= UITextField()
	var password		= UITextField()
	var loginButton		: UIButton!
	var signupButton	: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getAttributes()
		
		canLogin = true
		
		setUpNavigationBar()
		
		setUpUI()
		
		let lastUsername = NSUserDefaults.standardUserDefaults().stringForKey("username")
		if let uname = lastUsername {
			self.username.text = uname
			
			let u = SGFileManager.load(filename: SGUser(dictionaryRepresentation: ["username" : uname]).filename)
			if u != nil {
				currentUser = SGUser(dictionaryRepresentation: u!)
				
				if currentUser != SGUser.defaultUser() {
					self.automaticLoginTransition()
				}
			}
		}
		
		
	}
	
	func setUpUI() {
		
		
		
		self.view.backgroundColor = SGDesign.colourLightGrey()
		
		username.delegate = self
		password.delegate = self
		
		username.layer.cornerRadius = SGDesign.sizeCornerRadius()
		password.layer.cornerRadius = SGDesign.sizeCornerRadius()
		username.backgroundColor = SGDesign.colourWhite()
		password.backgroundColor = SGDesign.colourWhite()
		username.placeholder = localisedString("Username")
		password.placeholder = localisedString("Password")
		password.secureTextEntry = true
		username.returnKeyType = .Next
		password.returnKeyType = .Done
		username.textColor = SGDesign.colourNavy()
		password.textColor = SGDesign.colourNavy()
		
		loginButton = SGButton(title: localisedString("Login"), font: SGDesign.fontBoldOfSize(15), background: SGDesign.colourMainTheme(), textColour: SGDesign.colourWhite(), target: self, action: #selector(login), rounded : false)
		signupButton = SGButton(title: localisedString("Signup"), font: SGDesign.fontBoldOfSize(15), background: SGDesign.colourWhite(), textColour: SGDesign.colourMainTheme(), target: self, action: #selector(signup), rounded : false)
		
		self.addSubview(username, name: "username")
		self.addSubview(password, name: "password")
		self.addSubview(loginButton, name: "login")
		self.addSubview(signupButton, name: "signup")
		
		let buttonGap : CGFloat = 10
		self.addMetric(value: buttonGap, name: "gap")
		let fieldWidth = metrics["screenWidth"]! * 0.9
		
		username.translatesAutoresizingMaskIntoConstraints = false
		password.translatesAutoresizingMaskIntoConstraints = false
		
		self.addConstraintHeight(view: loginButton, height: SGDesign.sizeBottomButton())
		self.addConstraintEqualSizes(view1: signupButton, view2: loginButton)
		
		self.addConstraintSize(view: username, height: 40, width: fieldWidth)
		self.addConstraintEqualSizes(view1: username, view2: password)
		
		self.addConstraintsFormat(visualFormat: "V:|-(50)-[username]-(10)-[password]", layoutFormat: .AlignAllCenterX)
		
		self.addConstraintsFormat(visualFormat: "V:[login]|", layoutFormat: [])
		self.addConstraintsFormat(visualFormat: "H:|[login][signup]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		
		self.addConstraintAlignCenterX(view1: username, view2: self.view)
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		if textField == username {
			password.becomeFirstResponder()
		} else {
			textField.resignFirstResponder()
		}
	}
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		if string == "\n" {
			textField.endEditing(true)
			return false
		}
		return true
	}
	
	
	func login() {
		self.showActivityView { (done) in
			SGAPI.login(username: self.username.text!, password: self.password.text!) { (success, error) in
				
				if error != nil {
					SGAlertView.show(message: "Please check your internet connection.")
				}
				
				if success {
					self.setUser()
				} else {
					SGAlertView.show(message: "The username or password was incorrect.")
				}
				self.hideActivityView()
			}
		}
	}
	
	func setUser() {
		self.showActivityView { (done) in
			SGAPI.getUserDetails(username: self.username.text!, completion: { (user, error) in
				if user != nil {
					currentUser = user!
					self.loginSetup()
					self.successfulLogin()
				} else {
					SGAlertView.show(message: "Please check your internet connection.")
				}
				self.hideActivityView()
			})
		}
	}
	
	func loginSetup() {
		currentUser.save()
		currentUser.saveAsDefault()
	}
	
	func successfulLogin() {
		loginSetup()
		loginTransition()
	}
	
	func automaticLogin() {
		loginSetup()
		if canLogin {
			canLogin = false
			loginTransition()
		}
	}
	
	func automaticLoginTransition() {
		self.navigationController?.setNavigationBarHidden(true, animated: false)
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let tabvc = storyboard.instantiateViewControllerWithIdentifier("tabVC")
		self.navigationController?.pushViewController(tabvc, animated: false)
	}
	
	func loginTransition() {
		self.performSegueWithIdentifier("toTabVC", sender: self)
	}
	
	func signup() {
		self.performSegueWithIdentifier("toSignUpVC", sender: self)
	}
	
	override func viewWillAppear(animated: Bool) {
		self.title = localisedString("AppName")
		if autologin {
			autologin = false
			self.automaticLogin()
		} else {
			self.navigationController?.setNavigationBarHidden(false, animated: false)
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		self.title = localisedString("Login")
		if segue.destinationViewController.isMemberOfClass(SGTabBarController) {
			
			self.navigationController?.setNavigationBarHidden(true, animated: false)
		}
	}
	

}







