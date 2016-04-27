//
//  SGAlertView.swift
//  Sociogram
//
//  Created by The Steez on 27/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGAlertView: UIView {
	
	override var contentview: UIView {
		get {
			return self
		}
	}
	
	var doneButton : SGButton!
	
	var backView = UIView()
	
	var views   = [String : UIView ]()
	var metrics = [String : CGFloat]()
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	class func show(title title: String = localisedString("AppName"), doneButtonTitle: String = localisedString("OK"), message: String) {
		
		let alert = SGAlertView(title: title, doneButtonTitle: doneButtonTitle, message: message)
		alert.show()
	}
	
	init(title: String = localisedString("AppName"), doneButtonTitle: String = localisedString("OK"), message: String) {
		super.init(frame: CGRectZero)
		
		// alert main
		self.backgroundColor = SGDesign.colourWhite()
		self.layer.cornerRadius = SGDesign.sizeCornerRadius()
		self.layer.borderColor = SGDesign.colourNavy().CGColor
		self.layer.borderWidth = 1.0
		self.clipsToBounds = true
		self.translatesAutoresizingMaskIntoConstraints = false
		
		let viewWidth = UIScreen.mainScreen().bounds.width
		views["self"] = self
		metrics["viewWidth"] = viewWidth * 0.6
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[self(viewWidth)]", options: [], metrics: metrics, views: views))
		
		// background
		self.backView.backgroundColor = SGDesign.colourBlur()
		self.backView.translatesAutoresizingMaskIntoConstraints = false
		
		// title
		let titleLabel = SGLabel(title: title, font: SGDesign.fontBoldOfSize(18))
		titleLabel.textColor = SGDesign.colourMainTheme()
		self.addSubview(titleLabel)
		views["title"] = titleLabel
		
		self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.9, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: titleLabel, attribute: .CenterX, multiplier: 1, constant: 0))
		
		// message
		let messageView = UITextView()
		messageView.font = SGDesign.fontOfSize(16)
		messageView.textColor = SGDesign.colourNavy()
		messageView.text = message
		messageView.backgroundColor = UIColor.clearColor()
		messageView.textAlignment = .Center
		messageView.userInteractionEnabled = false
		messageView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(messageView)
		views["message"] = messageView
		self.addConstraint(NSLayoutConstraint(item: messageView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.9, constant: 0))
		messageView.sizeToFit()
		metrics["messageHeight"] = 80
		
		doneButton = SGButton(title: doneButtonTitle, font: SGDesign.fontBoldOfSize(18), background: SGDesign.colourMainTheme(), textColour: SGDesign.colourWhite(), target: self, action: #selector(dismiss), rounded : false)
		self.addSubview(doneButton)
		self.addConstraintEqualWidths(view1: self, view2: doneButton)
		views["doneButton"] = doneButton
		
		// Layout
		
		let formatString = "V:|-(10)-[title(30)][message(messageHeight)]-(10)-[doneButton]|"
		
		self.addConstraints(visualFormat: formatString, layoutFormat: [NSLayoutFormatOptions.AlignAllCenterX], metrics: metrics, views: views)
		
	}
	
	func show() {
		
		let views = ["self" : self, "back" : backView]
		
		let window = UIApplication.sharedApplication().keyWindow!
		window.addSubview(backView)
		backView.addSubview(self)
		window.addConstraint(NSLayoutConstraint(item: window, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
		window.addConstraint(NSLayoutConstraint(item: window, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
		window.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[back]|", options: [], metrics: nil, views: views))
		window.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[back]|", options: [], metrics: nil, views: views))
		
	}
	
	func dismiss() {
		
		UIView.animateWithDuration(0.25, animations: {
			
			self.alpha = 0
			self.backView.alpha = 0
			
			}, completion: { (Bool) -> Void in
				self.removeFromSuperview()
				self.backView.removeFromSuperview()
		})
		
	}
	
	
}
