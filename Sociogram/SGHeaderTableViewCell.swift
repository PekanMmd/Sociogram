//
//  SGHeaderTableViewCell.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGHeaderTableViewCell: SGTableViewCell {
	
	var title = ""

	init(title: String, reuseIdentifier: String) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		self.title = title
		
		self.backgroundColor = SGDesign.colourMainTheme()
		self.textLabel?.textColor = SGDesign.colourWhite()
		self.textLabel?.text = title
		self.textLabel?.textAlignment = .Center
		self.textLabel?.adjustsFontSizeToFitWidth = true
		self.textLabel?.font = SGDesign.fontBoldOfSize(15)
	}

	override func update() {
		self.textLabel?.text = title
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	class func height() -> CGFloat {
		return 24
	}

}
