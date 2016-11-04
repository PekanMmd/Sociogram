//
//  SGAPIManager.swift
//  Sociogram
//
//  Created by The Steez on 01/06/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit
import Alamofire

class SGAPIManager: Alamofire.Manager {
	
	init() {
		
		let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
		configuration.timeoutIntervalForRequest  = 3
		configuration.timeoutIntervalForResource = 3
		
		super.init(configuration: configuration)
		
		
	}

}
