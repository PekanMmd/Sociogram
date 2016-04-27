//
//  SGComment.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGComment: NSObject {
	
	var message		= ""
	var date		= NSDate(timeIntervalSinceNow: 0)
	var recipient	= "" // Username
	var agree		= 0
	var disagree	= 0
	var isPrivate	= true
	var id			= 0
	
	init(dictionaryRepresentation: [String: AnyObject]) {
		super.init()
		
		self.message = (dictionaryRepresentation["content"] ?? "") as! String
		if let d = dictionaryRepresentation["date"] {
			self.date = SGDesign.dateFormatter().dateFromString(d as! String) ?? NSDate(timeIntervalSinceNow: 0)
		}
		self.recipient = (dictionaryRepresentation["recipient"] ?? "") as! String
		let a = (dictionaryRepresentation["agree"] ?? "0") as! String
		self.agree = Int(a) ?? 0
		let d = (dictionaryRepresentation["disagree"] ?? "0") as! String
		self.agree = Int(d) ?? 0
		self.isPrivate = (dictionaryRepresentation["is_private"] ?? true) as! Bool
		self.id = (dictionaryRepresentation["id"] ?? 0) as! Int
		
	}
	
	
	
}








