//
//  SGTabBarController.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		updateTabs()
		canLogin = true

        // Do any additional setup after loading the view.
    }
	
	func updateTabs() {
		let images = ["profileIcon", "timelineIcon", "searchIcon", "settingsIcon"]
		let titles = [localisedString("Profile"), localisedString("Timeline"), localisedString("Search"), localisedString("Settings")]
		
		self.tabBar.tintColor = SGDesign.colourMainTheme()
		self.tabBar.backgroundColor = SGDesign.colourWhite()
		
		for i in 0 ..< 4 {
			
			self.viewControllers![i].tabBarItem = SGTabBarItem.item(imageName: images[i], title: titles[i])
		}
	}
}
