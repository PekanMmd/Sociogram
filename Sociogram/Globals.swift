//
//  Globals.swift
//  Sociogram
//
//  Created by The Steez on 20/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import Foundation

//API manager
let APIManager = SGAPIManager()

// SGUser
var currentUser		= SGUser.defaultUser()
var autologin		= false
var canLogin		= true

// Attributes
var attributes = [String]()

func getAttributes() {
	if attributes.count == 0 {
		SGAPI.getAttributeList({ (atts, error) in
			if error == nil {
				if let alist = atts {
					attributes = alist
				}
			}
		})
	}
}

// Localisation
func localisedString(key: String) -> String {
	return NSLocalizedString(key, comment: "")
}

// Alert view visibility
var numberOfVisibileAlerts = 0


