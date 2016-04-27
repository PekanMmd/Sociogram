//
//  SGEnums.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import Foundation

enum SGCommentTypes : String {
	case State		= "S"
	case Trait		= "T"
	case All		= "A"
	case Regular	= "N"
}

enum SGGenders : String {
	case Male		= "M"
	case Female		= "F"
	case Other		= "O"
	
	var string : String {
		get {
			switch self {
				case .Male		: return localisedString("Male")
				case .Female	: return localisedString("Female")
				case .Other		: return localisedString("Other")
			}
		}
	}
}

enum SGOrientations {
	case Horizontal
	case Vertical
}
