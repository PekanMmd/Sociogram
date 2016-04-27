//
//  SGMeViewController.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGMeViewController: SGProfileViewController {
	
	override var user : SGUser {
		get {
			return currentUser
		}
		set {
			return
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.tabBarItem.title = localisedString("Profile")
		
		self.title = localisedString("Profile")
	}

}
