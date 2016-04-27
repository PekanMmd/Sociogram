//
//  SGSignupViewController.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGSignupViewController: SGTableViewController, UITextFieldDelegate {
	
	let fields = ["Firstname", "Lastname", "Age", "Username", "Email", "Password", "ConfirmPassword"]
	
	//MARK: - Views
	var firstname		= ""
	var lastname		= ""
	var username		= ""
	var password		= ""
	var confirm			= ""
	var email			= ""
	var age				= 0
	
	var genderValue		= SGGenders.Other
	var gender			: UISegmentedControl!
	
	var signupButton	: SGButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		signupButton = SGButton(title: localisedString("Signup"), font: SGDesign.fontBoldOfSize(18), background: SGDesign.colourWhite(), textColour: SGDesign.colourMainTheme(), target: self, action: #selector(signup), rounded: false)
		gender = UISegmentedControl(items: [localisedString("Female"),localisedString("Male"),localisedString("Other")])
		gender.selectedSegmentIndex = 2
		gender.addTarget(self, action: #selector(genderUpdateAction), forControlEvents: .ValueChanged)
		gender.tintColor = SGDesign.colourMainTheme()
		setupUI()
    }

	override func layoutUI() {
		return
	}
	
	func setupUI() {
		
		let photo = SGProfileImageView()
		photo.layer.cornerRadius = 25
		self.addSubview(photo, name: "p")
		self.addConstraintSize(view: photo, height: 50, width: 50)
		self.addSubview(tableView, name: "table")
		self.addSubview(signupButton, name: "s")
		self.addSubview(gender, name: "g")
		self.addConstraintHeight(view: self.signupButton, height: SGDesign.sizeBottomButton())
		self.addConstraintsFormat(visualFormat: "V:|-(10)-[p]-(10)-[g]-(5)-[table][s]|", layoutFormat: [.AlignAllCenterX])
		self.addConstraintsFormat(visualFormat: "H:|-(10)-[table]-(10)-|", layoutFormat: [])
		self.addConstraintsFormat(visualFormat: "H:|[s]|", layoutFormat: [])
	}
	
	func signup() {
		self.showActivityView { (done) in
			
			SGAPI.postNewLogin(username: self.username, firstname: self.firstname, lastname: self.lastname, password: self.password, email: self.email, gender: self.genderValue.rawValue, age: self.age) { (success, error) in
				
				self.hideActivityView()
				
				if error != nil {
					SGAlertView.show(message: "Please check your internet connection.")
					return
				}
				
				guard success else {
					SGAlertView.show(message: "Please check that all your details are correct and unique.")
					return
				}
				
				currentUser = SGUser(dictionaryRepresentation: ["name" : self.firstname + " " + self.lastname, "username" : self.username, "email" : self.email, "age" : self.age, "gender" : self.genderValue.rawValue, "features" : []])
				autologin = true
				self.pop()
			}
		}
		//		currentUser = SGUser(dictionaryRepresentation: ["name" : self.firstname + " " + self.lastname, "username" : self.username, "email" : self.email, "age" : self.age, "gender" : self.genderValue.rawValue, "features" : []])
		//		currentUser = SGUser.dummyUser2()
		//		autologin = true
		//		self.pop()
	}
	
	func genderUpdateAction(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
			case 0	: self.genderValue = .Female
			case 1	: self.genderValue = .Male
			default	: self.genderValue = .Other
		}
	}
	
	// textfield delegate
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		if string == "\n" {
			textField.resignFirstResponder()
			return false
		}
		return true
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		if textField.text != "" {
			
			let text = textField.text ?? ""
			
			switch textField.tag {
				case 0: self.firstname	= text
				case 1: self.lastname	= text
				case 2: self.age		= Int(text) ?? 0
				case 3: self.username	= text.stringByReplacingOccurrencesOfString(" ", withString: "")
				case 4: self.email		= text
				case 5: self.password	= text
				case 6: self.confirm	= text
				default : break;
			}
		}
	}
	
	/// tableview data source
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return SGTextFieldTableViewCell.height()
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return fields.count
	}
	
	func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return false
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let section = indexPath.section
		let secure = (section == 5) || (section == 6)
		let title = fields[section]
		let cell = SGTextFieldTableViewCell(title: localisedString(title), placeholder: "-", index: section, secure: secure, textFieldDelegate: self, reuseIdentifier: "f")
		return cell
	}
}






