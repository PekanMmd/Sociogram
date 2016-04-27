//
//  SGObject.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import Foundation

protocol SGObject {
	
	var filename : String { get }

	var dictionaryRepresentation : [String : AnyObject] { get }
	
	init(dictionaryRepresentation: [String : AnyObject])
	
}

extension SGObject {
	func save() {
		SGFileManager.save(self.dictionaryRepresentation, filename: self.filename)
	}
	
	func erase() {
		SGFileManager.deleteFile(filename: self.filename)
	}
}








