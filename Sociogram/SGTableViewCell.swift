//
//  SGTableViewCell.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGTableViewCell: UITableViewCell {

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.layer.cornerRadius = SGDesign.sizeCornerRadius()
		self.clipsToBounds = true
	}

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}

}
