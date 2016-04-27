//
//  SGViewCommentViewController.swift
//  Sociogram
//
//  Created by The Steez on 26/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGViewCommentViewController: SGViewController {
	
	var comment : SGComment!
	var user    : SGUser!
	
	var isUser : Bool {
		return user == currentUser
	}
	
	var commentCell : SGCommentTableViewCell!
	
	var lButton : SGButton!
	var rButton : SGButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.commentCell = SGCommentTableViewCell(comment: comment, reuseIdentifier: "x")
		self.commentCell.translatesAutoresizingMaskIntoConstraints = false
		self.commentCell.backgroundColor = SGDesign.colourWhite()
		self.commentCell.update()
		self.addSubview(commentCell, name: "c")
		
		let leftTitle = isUser ? localisedString("Private") : localisedString("Disagree")
		lButton = SGButton(title: leftTitle, font: SGDesign.fontBoldOfSize(16), background: SGDesign.colourRed(), textColour: SGDesign.colourWhite(), target: self, action: #selector(left), rounded: false, image: nil)
		self.addSubview(lButton, name: "l")
		
		let rightTitle = isUser ? localisedString("Public") : localisedString("Agree")
		rButton = SGButton(title: rightTitle, font: SGDesign.fontBoldOfSize(16), background: SGDesign.colourBlue(), textColour: SGDesign.colourWhite(), target: self, action: #selector(left), rounded: false, image: nil)
		self.addSubview(rButton, name: "r")
		
		metrics["tabBarHeight"] = self.tabBarController?.tabBar.frame.height
		
		self.addConstraints(visualFormat: "V:|-(10)-[c]-(>=0)-[l]-(tabBarHeight)-|", layoutFormat: [], metrics: metrics, views: views)
		self.addConstraints(visualFormat: "H:|[l][r]|", layoutFormat: [NSLayoutFormatOptions.AlignAllTop, NSLayoutFormatOptions.AlignAllBottom], metrics: metrics, views: views)
		self.addConstraintEqualSizes(view1: lButton, view2: rButton)
		self.addConstraintHeight(view: lButton, height: SGDesign.sizeBottomButton())
		self.addConstraintHeight(view: commentCell, height: SGCommentTableViewCell.height())
		self.addConstraintAlignLeftAndRightEdges(view1: self.view, view2: commentCell)
		
		
	}
	
	func left() {
		self.showActivityView { (b) in
			if self.isUser {
				SGAPI.putUpdateCommentPrivacy(self.comment!.id, privacy: true, completion: { (success, error) in
					if error != nil {
						SGAlertView.show(message: "Please check your internet connection.")
					}
					if success! {
						self.pop()
					} else {
						SGAlertView.show(message: "Something went wrong.")
					}
				})
			} else {
//				SGAPI.
			}
			self.hideActivityView()
		}
	}
	
	func right() {
		self.showActivityView { (b) in
			if self.isUser {
				SGAPI.putUpdateCommentPrivacy(self.comment!.id, privacy: false, completion: { (success, error) in
					if error != nil {
						SGAlertView.show(message: "Please check your internet connection.")
					}
					if success! {
						self.pop()
					} else {
						SGAlertView.show(message: "Something went wrong.")
					}
				})
			} else {
				//				SGAPI.
			}
			self.hideActivityView()
		}
	}
	
}
















