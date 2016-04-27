//
//  SGProfileTableViewCell.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGProfileTableViewCell: SGTableViewCell {
	
	var views = [String:UIView]()
	
	var user : SGUser?
	
	//MARK: - Views
	var photo			: SGProfileImageView!
	var settings		: SGButton!
	var editFollow		: SGButton!
	
	var name			: SGLabel!
	var username		: SGLabel!
	
	var age				: SGLabel!
	var ageVal			: SGLabel!
	var gender			: SGLabel!
	var genderVal		: SGLabel!

	var followers		= [String]()

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

	init(user: SGUser?, reuseIdentifier: String) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		self.user = user
		
		setUp()
		update()
		
	}
	
	func setUp() {
		
		self.backgroundColor = SGDesign.colourWhite()
		
		// Photo
		photo = SGProfileImageView()
		photo.layer.cornerRadius = 50
		self.addSubview(photo)
		views["p"] = photo
		self.addConstraintSize(view: photo, height: 100, width: 100)
		
		// Edit/Follow Button
		editFollow = SGButton(title: "", font: SGDesign.fontBoldOfSize(10), background: SGDesign.colourMainTheme(), textColour: SGDesign.colourWhite(), target: self, action: #selector(SGProfileTableViewCell.editFollowAction))
		self.addSubview(editFollow)
		views["e"] = editFollow
		self.addConstraintSize(view: editFollow, height: 25, width: 60)
		
		
		// Profile
		name = SGLabel(title: "...", font: SGDesign.fontBoldOfSize(20))
		name.textColor = SGDesign.colourNavy()
		
		let labelFont = SGDesign.fontOfSize(15)
		
		username = SGLabel(title: "...", font: labelFont)
		username.textColor = SGDesign.colourGrey()
		age = SGLabel(title: localisedString("Age") + ": ", font: labelFont)
		age.textAlignment = .Right
		ageVal = SGLabel(title: "...", font: labelFont)
		ageVal.textAlignment  = .Left
		gender = SGLabel(title: localisedString("Gender") + ": ", font: labelFont)
		gender.textAlignment = .Right
		genderVal = SGLabel(title: "...", font: labelFont)
		genderVal.textAlignment = .Left
		self.addSubview(name)
		views["n"] = name
		self.addSubview(username)
		views["u"] = username
		self.addSubview(age)
		views["a"] = age
		self.addSubview(gender)
		views["g"] = gender
		self.addSubview(ageVal)
		views["av"] = ageVal
		self.addSubview(genderVal)
		views["gv"] = genderVal
		
		self.addConstraintHeight(view: name, height: 30)
		self.addConstraintEqualHeights(view1: name, view2: username)
		
		self.addConstraintSize(view: age, height: 30, width: 80)
		self.addConstraintEqualSizes(view1: gender, view2: age)
		self.addConstraintSize(view: ageVal, height: 30, width: 50)
		self.addConstraintEqualSizes(view1: genderVal, view2: ageVal)
		
		
		self.addConstraints(visualFormat: "V:|-(5)-[p][n][u][a][g]-(5)-|", layoutFormat: [], metrics: nil, views: views)
		self.addConstraintAlignCenterX(view1: self, view2: photo)
		self.addConstraintAlignLeftEdges(view1: age, view2: gender)
		self.addConstraintAlignLeftEdges(view1: ageVal, view2: genderVal)
		self.addConstraintAlignTopAndBottomEdges(view1: genderVal, view2: gender)
		self.addConstraints(visualFormat: "H:|-(10)-[a]-(5)-[av]", layoutFormat: [NSLayoutFormatOptions.AlignAllTop], metrics: nil, views: views)
		self.addConstraintAlignLeftAndRightEdges(view1: self, view2: name)
		self.addConstraintAlignLeftAndRightEdges(view1: name, view2: username)
		self.addConstraints(visualFormat: "H:[e]-(5)-|", layoutFormat: [], metrics: nil, views: views)
		self.addConstraints(visualFormat: "V:[e]-(5)-|", layoutFormat: [], metrics: nil, views: views)
		
		
	}
	
	override func update() {
		
		editFollow.enabled = !(user == currentUser)
		
		guard let u = user else {
			
			// TEMP
			name.text = "-"
			username.text = "-"
			ageVal.text = "-"
			genderVal.text = "-"
			photo.image = SGDesign.photoDefault()
			editFollow.setTitle("-", forState: .Normal)
			
			return
		}
		
		// Edit/Follow Button
		var efTitle = localisedString("Follow")
		if currentUser == u {
			efTitle = localisedString("Edit")
		}
		editFollow.setTitle(efTitle, forState: .Normal)
		
		SGAPI.getFollowersForUser(username: u.username) { (followers, error) in
			if followers != nil {
				self.followers = followers!
				if followers!.contains(currentUser.username) {
					self.followers.append(currentUser.username)
					efTitle = localisedString("Unfollow")
				}
			}
		}
		
		// Profile
		name.text = u.name
		username.text = u.username
		ageVal.text = "\(u.age)"
		genderVal.text = u.gender.string
		
		updatePhoto()
	}
	
	func editFollowAction() {
		if (currentUser != user) {
			SGAPI.follow(currentUser.username, following: (self.user?.username)!) { (success, error) in
				if success {
					self.editFollow.setTitle(localisedString("Unfollow"), forState: .Normal)
				} else {
					SGAlertView.show(message: "Please check your internet connection.")
				}
			}
		}
	}
	

	func updatePhoto() {
		self.photo.image = SGDesign.photoDefault()
	}
	
	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	class func height() -> CGFloat {
		return 230
	}
	
	
}
