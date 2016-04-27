//
//  SGCommentTableViewCell.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGCommentTableViewCell: SGTableViewCell {

	var comment		: SGComment!
	
	var photo		: SGProfileImageView!
	var user		: SGLabel!
	var message		: UITextView!
	var time		: SGLabel!
	
	var agree		: SGLabel!
	var agvalue		: SGLabel!
	var disagree	: SGLabel!
	var dgvalue		: SGLabel!
	
	init(comment: SGComment?, reuseIdentifier: String) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		self.comment = comment
		
		self.layer.borderColor = SGDesign.colourNavy().CGColor
		self.layer.borderWidth = 1
		
		photo = SGProfileImageView()
		photo.layer.cornerRadius = 25
		self.addSubview(photo)
		
		user = SGLabel(title: "", font: SGDesign.fontBoldOfSize(15))
		user.textAlignment = .Left
		self.addSubview(user)
		
		message = UITextView()
		message.translatesAutoresizingMaskIntoConstraints = false
		message.userInteractionEnabled = false
		message.font = SGDesign.fontOfSize(15)
		self.addSubview(message)
		
		time = SGLabel(title: "", font: SGDesign.fontOfSize(10))
		time.textAlignment = .Right
		self.addSubview(time)
		
		agree = SGLabel(title: localisedString("Agree") + ": ", font: SGDesign.fontBoldOfSize(10))
		agree.textAlignment = .Right
		self.addSubview(agree)
		
		agvalue = SGLabel(title: "0", font: SGDesign.fontOfSize(10))
		agvalue.textColor = SGDesign.colourBlue()
		agvalue.textAlignment = .Right
		self.addSubview(agvalue)
		
		disagree = SGLabel(title: localisedString("Disagree") + ": ", font: SGDesign.fontBoldOfSize(10))
		disagree.textAlignment = .Right
		self.addSubview(disagree)
		
		dgvalue = SGLabel(title: "0", font: SGDesign.fontOfSize(10))
		dgvalue.textColor = SGDesign.colourRed()
		dgvalue.textAlignment = .Right
		self.addSubview(dgvalue)
		
		let views = ["p" : photo, "u" : user, "m" : message, "t" : time, "a" : agree, "d" : disagree, "ag" : agvalue, "dg" : dgvalue]
		let metrics : [String : CGFloat] = ["g" : 10]
		
		self.addConstraints(visualFormat: "H:|-(g)-[p]-(g)-[u]-(>=0)-[t]-(g)-|", layoutFormat: [NSLayoutFormatOptions.AlignAllTop], metrics: metrics, views: views)
		self.addConstraints(visualFormat: "H:[m]-(g)-|", layoutFormat: [], metrics: metrics, views: views)
		self.addConstraints(visualFormat: "V:|-(g)-[u]-(g)-[m]", layoutFormat: [NSLayoutFormatOptions.AlignAllLeft], metrics: metrics, views: views)
		self.addConstraints(visualFormat: "V:[m][a]|", layoutFormat: [], metrics: metrics, views: views)
		self.addConstraints(visualFormat: "H:[a][ag]-(g)-[d][dg]-(g)-|", layoutFormat: [NSLayoutFormatOptions.AlignAllTop, NSLayoutFormatOptions.AlignAllBottom], metrics: metrics, views: views)
		self.addConstraintSize(view: photo, height: 50, width: 50)
		self.addConstraintSize(view: user, height: 20, width: 60)
		self.addConstraintEqualHeights(view1: user, view2: time)
		self.addConstraintWidth(view: time, width: 80)
		self.addConstraintWidth(view: agree, width: 50)
		self.addConstraintEqualHeights(view1: agree, view2: time)
		self.addConstraintEqualSizes(view1: agree, view2: disagree)
		self.addConstraintWidth(view: agvalue, width: 30)
		self.addConstraintEqualWidths(view1: agvalue, view2: dgvalue)
		
	}
	
	override func update() {
		
		self.backgroundColor = SGDesign.colourWhite()
		
		guard let c = comment else {
			user.text = "..."
			message.text = "..."
			time.text = "..."
			agvalue.text = "0"
			dgvalue.text = "0"
			
			return
		}
		
		user.text = c.recipient
		message.text = c.message
		time.text = SGDesign.dateFormatter().stringFromDate(c.date)
		
		agvalue.text = "\(c.agree)"
		dgvalue.text = "\(c.disagree)"
		
		updatePhoto()
		
	}
	
	private func updatePhoto() {
		self.photo.image = SGDesign.photoDefault()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	class func height() -> CGFloat {
		return 110
	}

}





