//
//  SGFeature.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGFeature: NSObject, SGObject {
	
	var filename : String {
		return  "SGFeature_" + self.attribute.name
	}
	
	var attribute		= SGAttribute(dictionaryRepresentation: ["name" : "-"])
	var value			= 0.5
	var opinions		= 0
	
	var dictionaryRepresentation : [String : AnyObject] {
		return ["attribute" : ["name" : self.attribute.name], "value" : self.value, "opinions" : self.opinions]
	}
	
	required init(dictionaryRepresentation: [String : AnyObject]) {
		super.init()
		
		let attrName = dictionaryRepresentation["name"] ?? "-"
		
		self.attribute	= SGAttribute(dictionaryRepresentation: ["name" : attrName!])
		self.value		= (dictionaryRepresentation["value"] ?? 0.5) as! Double
		self.opinions	= (dictionaryRepresentation["opinions"] ?? 0) as! Int
	}

}
