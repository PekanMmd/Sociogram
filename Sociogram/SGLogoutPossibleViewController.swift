//
//  SGLogoutPossibleViewController.swift
//  Sociogram
//
//  Created by The Steez on 25/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit


protocol SGLogoutPossibleViewController {
	var tabBarController : UITabBarController? { get }
}

extension SGLogoutPossibleViewController {
	
	// Seems to cause issues with button selectors
	
	//	func logout() {
	//		self.tabBarController!.navigationController?.popViewControllerAnimated(true)
	//	}
}