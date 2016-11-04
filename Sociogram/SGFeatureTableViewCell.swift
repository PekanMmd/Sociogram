//
//  SGFeatureTableViewCell.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGFeatureTableViewCell: SGTableViewCell {
	
	var isNoFeaturesCell = false
	var messageLabel	: SGLabel!
	
	var attributeName	: SGLabel!
	var score			: SGLabel!
	var contributions	: SGLabel!
	
	var feature			: SGFeature!

	init(feature: SGFeature?, reuseIdentifier: String) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		self.feature = feature
		self.attributeName = SGLabel(title: "", font: SGDesign.fontBoldOfSize(15))
		self.attributeName.textAlignment = .Left
		self.score = SGLabel(title: "", font: SGDesign.fontOfSize(20))
		self.score.textAlignment = .Right
		self.contributions = SGLabel(title: "", font: SGDesign.fontOfSize(10))
		self.contributions.textAlignment = .Right
		
		self.addSubview(attributeName)
		self.addSubview(score)
		self.addSubview(contributions)
		let views : [String : UIView] = ["a":attributeName,"s":score,"c":contributions]
		self.addConstraints(visualFormat: "|-(10)-[a][s][c]-(10)-|", layoutFormat: [NSLayoutFormatOptions.AlignAllTop, NSLayoutFormatOptions.AlignAllBottom], metrics: nil, views: views)
		self.addConstraintAlignTopAndBottomEdges(view1: self, view2: attributeName)
		self.addConstraintWidth(view: score, width: 50)
		self.addConstraintWidth(view: contributions, width: 100)
		
		self.messageLabel = SGLabel(title: localisedString("NoFeatures"), font: SGDesign.fontOfSize(15))
		self.messageLabel.alpha = 0
		self.addSubview(messageLabel)
		self.addConstraintAlignAllEdges(view1: self, view2: messageLabel)
		
	}
	
	override func update() {
		
		let a : CGFloat = isNoFeaturesCell ? 0 : 1
		
		self.contributions.alpha = a
		self.score.alpha = a
		self.attributeName.alpha = a
		
		self.messageLabel.alpha = 1 - a
		
		if isNoFeaturesCell {
			self.backgroundColor = SGDesign.colourWhite()
		}else if feature == nil {
			self.backgroundColor = SGDesign.colourWhite()
			self.attributeName.text = "..."
			self.score.text = "..."
			self.contributions.text = "..."
		} else {
			
			if feature.value < 0.4 {
				self.backgroundColor = SGDesign.colourRed()
			} else if feature.value > 0.6 {
				self.backgroundColor = SGDesign.colourGreen()
			} else {
				self.backgroundColor = SGDesign.colourYellow()
			}
			
			self.attributeName.text = feature.attribute.name
			self.score.text = "\(feature.value * 100)%"
			self.contributions.text = "\(feature.opinions) " + localisedString("Opinions").lowercaseString
		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	class func height() -> CGFloat {
		return 30
	}

}
