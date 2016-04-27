//
//  SGActivityView.swift
//  Sociogram
//
//  Created by The Steez on 26/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGActivityView: UIView {

	init() {
		super.init(frame: CGRectZero)
		self.backgroundColor = SGDesign.colourMainTheme()
		self.alpha = 0.5
		let av = UIActivityIndicatorView()
		self.translatesAutoresizingMaskIntoConstraints = false
		av.translatesAutoresizingMaskIntoConstraints = false
		av.startAnimating()
		av.alpha = 1.0
		self.addSubview(av)
		self.addConstraintAlignCenters(view1: self, view2: av)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
}
