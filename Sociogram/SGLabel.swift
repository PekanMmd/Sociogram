//
//  SGLabel.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGLabel: UILabel {
	
	convenience init() {
		self.init(title: "", font: SGDesign.fontOfSize(10))
	}

	init(title: String, font: UIFont) {
		super.init(frame: CGRectZero)
		
		self.text = title
		self.textAlignment = .Center
		self.font = font
		self.adjustsFontSizeToFitWidth = true
		self.translatesAutoresizingMaskIntoConstraints = false
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

}
