//
//  SGPostTableViewCell.swift
//  Sociogram
//
//  Created by The Steez on 25/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGPostTableViewCell: SGTableViewCell {
	
	private var icon  : UIImageView!
	private var label : SGLabel!
	
	init(reuseIdentifier: String?) {
		super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = SGDesign.colourWhite()
		
		icon = UIImageView(image: UIImage(named: "PostIcon")?.imageWithRenderingMode(.AlwaysTemplate))
		icon.tintColor = SGDesign.colourMainTheme()
		icon.backgroundColor = SGDesign.colourWhite()
		icon.contentMode = .ScaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false
		label = SGLabel(title: localisedString("PostComment"), font: SGDesign.fontOfSize(15))
		label.textColor = SGDesign.colourMainTheme()
		
		self.addSubview(icon)
		self.addSubview(label)
		let views = ["i" : icon, "l" : label]
		let metrics = ["w" : SGPostTableViewCell.height() * 1.5]
		
		self.addConstraints(visualFormat: "H:|[i(w)][l]|", layoutFormat: [NSLayoutFormatOptions.AlignAllTop, NSLayoutFormatOptions.AlignAllBottom], metrics: metrics, views: views)
		self.addConstraints(visualFormat: "V:|[i]|", layoutFormat: [], metrics: metrics, views: views)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	
	
	class func height() -> CGFloat {
		return 40
	}

}
