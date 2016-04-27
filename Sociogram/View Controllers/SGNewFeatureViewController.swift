//
//  SGNewFeatureViewController.swift
//  Sociogram
//
//  Created by The Steez on 26/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGNewFeatureViewController: SGTableViewController, UITextFieldDelegate {
	
	var addButton : SGButton!
	var name      : UITextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = localisedString("AddFeature")
		
		self.addButton = SGButton(title: localisedString("Add"), font: SGDesign.fontBoldOfSize(18), background: SGDesign.colourMainTheme(), textColour: SGDesign.colourWhite(), target: self, action: #selector(submit), rounded: false, image: nil)
		self.addButton.backgroundColor = SGDesign.colourMainTheme()
		self.addSubview(addButton, name: "a")
		
		name = UITextField()
		name.font = SGDesign.fontOfSize(18)
		name.backgroundColor = SGDesign.colourWhite()
		name.textColor = SGDesign.colourMainTheme()
		name.layer.cornerRadius = SGDesign.sizeCornerRadius()
		name.delegate = self
		name.returnKeyType = .Done
		self.addSubview(name, name: "n")
		
		metrics["tabBarHeight"] = self.tabBarController?.tabBar.frame.height
		
		self.addConstraints(visualFormat: "V:|-(10)-[n]-(>=0)-[a]-(tabBarHeight)-|", layoutFormat: [NSLayoutFormatOptions.AlignAllCenterX], metrics: metrics, views: views)
		self.addConstraintAlignLeftAndRightEdges(view1: self.view, view2: addButton)
		self.addConstraintSize(view: self.name, height: 40, width: 200)
		self.addConstraintHeight(view: addButton, height: SGDesign.sizeBottomButton())
		
	}
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		if string == "\n" {
			textField.resignFirstResponder()
			return false
		}
		return true
	}
	
	func submit() {
		if name.text == "" {
			return
		}
		self.showActivityView { (d) in
			SGAPI.postNewFeature(feature: self.name.text!, forUser: currentUser.username, completion: { (success, error) in
				if error != nil {
					SGAlertView.show(message: "Please check your internet connection.")
				} else if success {
					self.pop()
				} else {
					SGAlertView.show(message: "Something went wrong.")
				}
				self.hideActivityView()
			})
			
		}
		
	}
}
