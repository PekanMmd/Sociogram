//
//  SGProfileImageView.swift
//  Sociogram
//
//  Created by The Steez on 26/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGProfileImageView: UIImageView {
	
	init() {
		super.init(frame: CGRectZero)
		self.translatesAutoresizingMaskIntoConstraints = false
		self.clipsToBounds = true
		self.backgroundColor = SGDesign.colourWhite()
		self.image = SGDesign.photoDefault()
		self.layer.borderColor = SGDesign.colourNavy().CGColor
		self.layer.borderWidth = 1
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

}
