//
//  SGTabBarItem.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGTabBarItem: UITabBarItem {
	
	class func item(imageName image : String, title: String)  -> UITabBarItem {
		
		let item = UITabBarItem(title: title, image: UIImage(named: image), tag: 0)
		let titleTextAttributes = [ NSFontAttributeName : SGDesign.fontBoldOfSize(12)]
		item.setTitleTextAttributes(titleTextAttributes, forState: .Normal)
		return item
	}

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
}
