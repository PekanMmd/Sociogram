//
//  SGFileManager.swift
//  Sociogram
//
//  Created by The Steez on 25/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGFileManager: NSObject {
	
	static let docsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
	
	class func pathForFile(name: String) -> String {
		return docsPath + "/" + name
	}
	
	class func save(data: [String : AnyObject], filename file: String) -> Bool {
		let data = NSKeyedArchiver.archivedDataWithRootObject(data)
		
		do {
			try data.writeToFile(pathForFile(file), options: .DataWritingAtomic)
		} catch {
			print("Couldn't save file: ", file)
			return false
		}
		return true
	}
	
	class func load(filename file: String) -> [String : AnyObject]? {
		guard let data = NSData(contentsOfFile: pathForFile(file)) else {
			return nil
		}
		return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [String : AnyObject]?
	}
	
	class func deleteFile(filename name: String) -> Bool {
		let fm = NSFileManager.defaultManager()
		let path = pathForFile(name)
		
		if fm.fileExistsAtPath(path) {
			do {
				try fm.removeItemAtPath(path)
			} catch {
				return false
			}
		}
		return true
	}

}








