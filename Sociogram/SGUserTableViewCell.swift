//
//  SGUserTableViewCell.swift
//  Sociogram
//
//  Created by The Steez on 23/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGUserTableViewCell: SGTableViewCell {

	var views = [String:UIView]()
	
	var user : SGUser?
	
	//MARK: - Views
	var photo			: SGProfileImageView!
	
	var name			: SGLabel!
	var username		: SGLabel!
	
	init(user: SGUser?, reuseIdentifier: String) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		self.user = user
		
		setUp()
		update()
		
	}

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	func setUp() {
		
		self.backgroundColor = SGDesign.colourWhite()
		
		// Photo
		photo = SGProfileImageView()
		photo.layer.cornerRadius = 25
		self.addSubview(photo)
		views["p"] = photo
		self.addConstraintSize(view: photo, height: 50, width: 50)
		
		
		// Profile
		name = SGLabel(title: "...", font: SGDesign.fontBoldOfSize(20))
		name.textAlignment = .Left
		name.textColor = SGDesign.colourNavy()
		
		username = SGLabel(title: "...", font: SGDesign.fontOfSize(15))
		username.textColor = SGDesign.colourDarkGrey()
		username.textAlignment = .Left
		
		self.addSubview(name)
		views["n"] = name
		self.addSubview(username)
		views["u"] = username
		
		self.addConstraintHeight(view: name, height: 20)
		self.addConstraintEqualHeights(view1: name, view2: username)
		
		self.addConstraints(visualFormat: "H:|-(10)-[p]-(10)-[n]-(10)-|", layoutFormat: [], metrics: nil, views: views)
		self.addConstraints(visualFormat: "V:|-(15)-[n][u]-(15)-|", layoutFormat: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: nil, views: views)
		self.addConstraints(visualFormat: "V:|-(10)-[p]", layoutFormat: [], metrics: nil, views: views)
		
	}
	
	override func update() {
		
		guard let u = user else {
			
			// TEMP
			name.text = "-"
			username.text = "-"
			photo.image = SGDesign.photoDefault()
			
			return
		}
		
		// Profile
		name.text = u.name
		username.text = u.username
		self.updatePhoto()
		
	}
	
	func updatePhoto() {
		photo.image = SGDesign.photoDefault()
	}
	
	class func height() -> CGFloat {
		return 70
	}

}
