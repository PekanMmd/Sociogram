//
//  SGTextFieldTableViewCell.swift
//  Sociogram
//
//  Created by The Steez on 26/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGTextFieldTableViewCell: SGTableViewCell {
	
	var title : SGLabel!
	var field : UITextField!
	
	var index = 0
	
	init(title: String, placeholder ph: String, index: Int, secure: Bool, textFieldDelegate del: UITextFieldDelegate, reuseIdentifier reuse: String) {
		super.init(style: .Default, reuseIdentifier: reuse)
		
		self.title = SGLabel(title: title, font: SGDesign.fontBoldOfSize(12))
		self.title.backgroundColor = SGDesign.colourWhite()
		self.title.textColor = SGDesign.colourMainTheme()
		self.addSubview(self.title)
		
		self.field = UITextField()
		self.field.placeholder = ph
		self.field.font = SGDesign.fontOfSize(16)
		self.field.textColor = SGDesign.colourNavy()
		self.field.tag = index
		self.field.delegate = del
		self.field.returnKeyType = .Done
		self.field.textAlignment = .Center
		self.field.translatesAutoresizingMaskIntoConstraints = false
		self.field.secureTextEntry = secure
		self.addSubview(field)
		
		let views = ["t" : self.title, "f" : field]
		self.addConstraints(visualFormat: "V:|[t(15)][f]|", layoutFormat: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: nil, views: views)
		self.addConstraints(visualFormat: "H:|[t]|", layoutFormat: [], metrics: nil, views: views)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	class func height() -> CGFloat {
		return 50
	}

}
