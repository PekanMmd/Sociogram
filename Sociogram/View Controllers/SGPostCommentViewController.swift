//
//  SGPostCommentViewController.swift
//  Sociogram
//
//  Created by The Steez on 25/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGPostCommentViewController: SGViewController, UITextViewDelegate {
	
	var message		= UITextView()
	var username	: SGLabel!
	var postButton	: SGButton!
	
	var user    = SGUser.defaultUser()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	func setupUI() {
		
		self.message.font = SGDesign.fontOfSize(18)
		self.message.layer.cornerRadius = SGDesign.sizeCornerRadius()
		self.message.delegate = self
		self.message.returnKeyType = .Done
		self.message.textColor = SGDesign.colourNavy()
		self.addSubview(message, name: "m")
		
		self.username = SGLabel(title: user.name, font: SGDesign.fontBoldOfSize(20))
		self.username.textColor = SGDesign.colourNavy()
		self.username.textAlignment = .Left
		self.addSubview(username, name: "u")
		
		self.postButton = SGButton(title: localisedString("Post"), font: SGDesign.fontBoldOfSize(20), background: SGDesign.colourMainTheme(), textColour: SGDesign.colourWhite(), target: self, action: #selector(post), rounded: false)
		self.addSubview(postButton, name: "p")
		
		self.addMetric(value: SGDesign.sizeBottomButton(), name: "b")
		
		metrics["tabBarHeight"] = self.tabBarController?.tabBar.frame.height
		
		self.addConstraintsFormat(visualFormat: "V:|[u(30)][m(200)]", layoutFormat: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight])
		self.addConstraintsFormat(visualFormat: "V:[p(b)]-(tabBarHeight)-|", layoutFormat: [])
		self.addConstraintsFormat(visualFormat: "H:|-(10)-[m]-(10)-|", layoutFormat: [])
		self.addConstraintsFormat(visualFormat: "H:|[p]|", layoutFormat: [])
		
	}
	
	func post() {
		if self.message.text != "" {
			self.showActivityView { (done) in
				SGAPI.postCommentToUser(message: self.message.text!, toUser: self.user.username, completion: { (success, error) in
					if success {
						self.pop()
					} else {
						SGAlertView.show(message: "Please check your internet connection.")
					}
					self.hideActivityView()
				})
			}
		}
	}
	
	func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
		if text == "\n" {
			textView.resignFirstResponder()
			return false
		}
		return true
	}
	
}












