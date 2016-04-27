//
//  SGAttribute.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGAttribute: NSObject {
	
	var name				= ""
	var mean				= 0.5
	var standardDeviation	= 0.5
	
	var dictionaryRepresentaion : [String : AnyObject] {
		get {
			return ["" : ""]
		}
	}
	
	required init(dictionaryRepresentation: [String : AnyObject]) {
		super.init()
		
		self.name = (dictionaryRepresentation["name"] ?? "-") as! String
		let m = (dictionaryRepresentation["mean"] ?? "0.5") as! String
		self.mean = Double(m)!
		let s = (dictionaryRepresentation["sd"] ?? "0.5") as! String
		self.standardDeviation = Double(s)!
		
	}

}
