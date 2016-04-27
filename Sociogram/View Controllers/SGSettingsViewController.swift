//
//  SGSettingsViewController.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGSettingsViewController: SGViewController, SGLogoutPossibleViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.tabBarItem.title = localisedString("Settings")
        // Do any additional setup after loading the view.
		
		let logoutButton = SGButton(title: localisedString("Logout"), font: SGDesign.fontBoldOfSize(20), background: SGDesign.colourRed(), textColour: SGDesign.colourWhite(), target: self, action: #selector(logout), rounded : false)
		self.addSubview(logoutButton, name: "l")
		
		metrics["tabBarHeight"] = self.tabBarController?.tabBar.frame.height
		
		self.addConstraintHeight(view: logoutButton, height: SGDesign.sizeBottomButton())
		self.addConstraintsFormat(visualFormat: "V:[l]-(tabBarHeight)-|", layoutFormat: [])
		self.addConstraintAlignLeftAndRightEdges(view1: logoutButton, view2: self.view)
		
    }
	
	func logout() {
		let file = currentUser.filename
		SGFileManager.deleteFile(filename: file)
		currentUser = SGUser.defaultUser()
		self.tabBarController!.navigationController?.popViewControllerAnimated(true)
	}

}






