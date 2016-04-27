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
	var contributors	= [String]()
	
	var dictionaryRepresentation : [String : AnyObject] {
		return ["attribute" : ["name" : self.attribute.name], "value" : self.value, "contributors" : self.contributors]
	}
	
	required init(dictionaryRepresentation: [String : AnyObject]) {
		super.init()
		
		self.attribute = SGAttribute(dictionaryRepresentation: (dictionaryRepresentation["attribute"] ?? []) as! [String : AnyObject])
		self.value = (dictionaryRepresentation["value"] ?? 0.5) as! Double
		self.contributors = (dictionaryRepresentation["contributors"] ?? []) as! [String]
	}

}
