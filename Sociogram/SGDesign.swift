//
//  SGDesign.swift
//  Sociogram
//
//  Created by The Steez on 12/03/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGDesign: NSObject {

	//MARK: - Fonts
	class func fontOfSize(size: CGFloat) -> UIFont {
		return UIFont(name: "Helvetica", size: size)!
	}
	
	class func fontBoldOfSize(size: CGFloat) -> UIFont {
		return UIFont(name: "Helvetica Bold", size: size)!
	}
	
	
	//MARK: - Sizes
	class func sizeCornerRadius() -> CGFloat {
		return 12.0
	}
	
	class func sizeBottomButton() -> CGFloat {
		return 60.0
	}
	
	
	//MARK: - Colours
	class func colourBlack() -> SGColour {
		return SGColour(hex: 0x000000FF)
	}
	
	class func colourWhite() -> SGColour {
		return SGColour(hex: 0xFFFFFFFF)
	}
	
	class func colourRed() -> SGColour {
		return SGColour(hex: 0xFC8868FF)
	}
	
	class func colourOrange() -> SGColour {
		return SGColour(hex: 0xF7B409FF)
	}
	
	class func colourYellow() -> SGColour {
		return SGColour(hex: 0xF8F8A8FF)
	}
	
	class func colourGreen() -> SGColour {
		return SGColour(hex: 0xC8E89CFF)
	}
	
	class func colourBlue() -> SGColour {
		return SGColour(hex: 0x70ACFFFF)
	}
	
	class func colourPurple() -> SGColour {
		return SGColour(hex: 0xC207EDFF)
	}
	
	class func colourPink() -> SGColour {
		return SGColour(hex: 0xFC80F6FF)
	}
	
	class func colourNavy() -> SGColour {
		return SGColour(hex: 0x28276BFF)
	}
	
	class func colourLightBlack() -> SGColour {
		return SGColour(hex: 0x282828FF)
	}
	
	class func colourGrey() -> SGColour {
		return SGColour(hex: 0xC0C0C8FF)
	}
	
	class func colourDarkGrey() -> SGColour {
		return SGColour(hex: 0xA0A0A8FF)
	}
	
	class func colourLightGrey() -> SGColour {
		return SGColour(hex: 0xF0F0FCFF)
	}
	
	class func colourMainTheme() -> SGColour {
		return colourBlue()
	}
	
	class func colourBackground() -> SGColour {
		return colourLightGrey()
	}
	
	class func colourBlur() -> SGColour {
		return SGColour(hex: 0x70ACFF80)
	}
	
	//MARK: - Dates
	class func dateFormatter() -> NSDateFormatter {
		let formatter = NSDateFormatter()
		formatter.dateStyle = .MediumStyle
		formatter.timeStyle = .ShortStyle
		return formatter
	}
	
	//MARK: - Photos
	class func photoDefault() -> UIImage {
		let image = UIImage(named: "PhotoDefault")!
		return image
	}
	
}

class SGColour: UIColor {
	init(hex: Double) {
		let red   = CGFloat((hex  / 0x1000000) / 0xFF)
		let green = CGFloat(((hex / 0x10000)   % 0x100) / 0xFF)
		let blue  = CGFloat(((hex / 0x100)     % 0x100) / 0xFF)
		let alpha = CGFloat((hex  % 0x100)     / 0xFF)
		
		super.init(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	required convenience init(colorLiteralRed red: Float, green: Float, blue: Float, alpha: Float) {
		self.init(hex: 0x0)
	}
}
