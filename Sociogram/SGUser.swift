//
//  SGUser.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGUser: NSObject, SGObject {
	
	var filename	: String {
		return "SGUser_" + self.username
	}
	
	var username	= "-"
	var name		= "-"
	var email		= ""
	var age			= 0
	var gender		= SGGenders.Other
	var photo		: UIImage!
	var features	= [SGFeature]()
	
	var dictionaryRepresentation: [String : AnyObject] {
		get {
			var rep = [String : AnyObject]()
			
			rep["username"] = self.username
			rep["name"] = self.name
			rep["email"] = self.email
			rep["age"] = self.age
			rep["gender"] = self.gender.rawValue
			
			var feats = [ [String : AnyObject] ]()
			for feature in features {
				feats.append(feature.dictionaryRepresentation)
			}
			rep["features"] = feats
			
			return rep
		}
	}
	
	required init(dictionaryRepresentation: [String : AnyObject]) {
		super.init()
		
		self.username	= (dictionaryRepresentation["username"] ?? "-") as! String
		self.name		= (dictionaryRepresentation["name"] ?? "-") as! String
		self.email		= (dictionaryRepresentation["email"] ?? "-") as! String
		self.age		= (dictionaryRepresentation["age"] ?? 0) as! Int
		self.gender		= SGGenders(rawValue: (dictionaryRepresentation["gender"] ?? "-") as! String) ?? .Other
		
		let f = (dictionaryRepresentation["features"] ?? []) as! [ [String : AnyObject] ]
		for feature in f {
			self.features.append(SGFeature(dictionaryRepresentation: feature))
		}
		
		
	}
	
	func listFeaturesByDescendingScores() -> [SGFeature] {
		return self.features.sort { $0.value > $1.value }
	}
	
	func saveAsDefault() {
		let ud = NSUserDefaults.standardUserDefaults()
		ud.setValue(self.username, forKey: "username")
		ud.synchronize()
	}
	
	func save() {
		SGFileManager.save(self.dictionaryRepresentation, filename: self.filename)
	}
	
	class func dummyUser1() -> SGUser {
		
		let att1 = ["name" : "Honest", "mean" : "0.5", "sd" : "0.5"]
		let att2 = ["name" : "Decent", "mean" : "0.5", "sd" : "0.5"]
		let att3 = ["name" : "Cool"  , "mean" : "0.0", "sd" : "0.0"]
		
		let f1 = ["attribute" : att1, "value" : 0.81, "contributors" : ["Stars", "Justin", "Bahador"]]
		let f2 = ["attribute" : att2, "value" : 0.37, "contributors" : ["Stars", "Justin", "Bahador", "Arash"]]
		let f3 = ["attribute" : att3, "value" : 0.55, "contributors" : ["Justin", "Arash"]]
		
		return SGUser(dictionaryRepresentation: ["name" : "Stars Momodu", "username" : "SteezySwag", "email" : "Steezy@gmail.com", "age" : 21, "gender" : "O", "features" : [ f1,f2,f3 ]])
	}
	
	class func dummyUser2() -> SGUser {
		
		
		let att1 = ["name" : "Honest", "mean" : "0.5", "sd" : "0.5"]
		let att2 = ["name" : "Decent", "mean" : "0.5", "sd" : "0.5"]
		let att3 = ["name" : "Brave" , "mean" : "0.0", "sd" : "0.0"]
		let att4 = ["name" : "Rash"  , "mean" : "0.0", "sd" : "0.0"]
		let att5 = ["name" : "Calm"  , "mean" : "0.0", "sd" : "0.0"]
		
		let f1 = ["attribute" : att1, "value" : 0.46, "contributors" : ["Stars", "Justin", "Bahador"]]
		let f2 = ["attribute" : att2, "value" : 0.96, "contributors" : ["Stars", "Justin", "Bahador", "Arash"]]
		let f3 = ["attribute" : att3, "value" : 0.21, "contributors" : ["Justin", "Arash"]]
		let f4 = ["attribute" : att4, "value" : 0.58, "contributors" : ["Stars", "Justin", "Bahador", "Arash"]]
		let f5 = ["attribute" : att5, "value" : 0.12, "contributors" : ["Stars", "Justin", "Bahador", "Arash"]]
		
		return SGUser(dictionaryRepresentation: ["name" : "Bahador Bahrami", "username" : "B_Bahrami", "email" : "b.bahrami@gmail.com", "age" : 27, "gender" : "F", "features" : [ f1,f2,f3,f4,f5 ]])
	}
	
	override func isEqual(object: AnyObject?) -> Bool {
		guard let obj = object else {
			return false
		}
		
		if obj.isMemberOfClass(SGUser) {
			return (obj as! SGUser).username == self.username
		}
		
		return false
	}
	
	class func defaultUser() -> SGUser {
		let dict = ["name" : "-", "username" : "-", "email" : "-", "age" : 0, "gender" : "F", "features" : [] ]
		return SGUser(dictionaryRepresentation: dict)
	}

}








