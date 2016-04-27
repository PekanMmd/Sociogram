//
//  SGButton.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGButton: UIButton {
	
	var backColour : SGColour!
	var highColour : SGColour!
	
	override var highlighted : Bool {
		didSet {
			UIView.animateWithDuration(0.25) { 
				self.backgroundColor = self.highlighted ? self.highColour : self.backColour
			}
		}
	}

	init(title: String, font: UIFont, background: SGColour, textColour: SGColour, target: NSObject, action: Selector, rounded : Bool = true, image: UIImage?  = nil) {
		super.init(frame: CGRectZero)
		
		self.highColour = SGDesign.colourGrey()
		
		self.titleLabel?.font = font
		self.setTitle(title, forState: .Normal)
		self.setBackgroundColour(background)
		self.setTitleColor(textColour, forState: .Normal)
		self.setImage(image, forState: .Normal)
		self.addTarget(target, action: action, forControlEvents: .TouchUpInside)
		self.titleLabel?.adjustsFontSizeToFitWidth = true
		self.layer.cornerRadius = rounded ? SGDesign.sizeCornerRadius() : 0
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setTitleColor(SGDesign.colourLightGrey(), forState: .Highlighted)
		self.clipsToBounds = true
		
	}
	
	func setBackgroundColour(colour: SGColour) {
		self.backColour = colour
		self.backgroundColor = colour
	}
	

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}

}
