//
//  SGOpinionViewController.swift
//  Sociogram
//
//  Created by The Steez on 26/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGOpinionViewController: SGViewController {

	var feature : SGFeature!
	var user    : SGUser!
	var value   : SGLabel!
	
	var featureCell : SGFeatureTableViewCell!
	var slider		: UISlider!
	
	var contributeButton : SGButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.featureCell = SGFeatureTableViewCell(feature: feature, reuseIdentifier: "x")
		featureCell.translatesAutoresizingMaskIntoConstraints = false
		featureCell.update()
		self.addSubview(featureCell, name: "f")
		
		self.slider = UISlider()
		self.slider.tintColor = SGDesign.colourMainTheme()
		self.addSubview(slider, name: "s")
		
		self.value = SGLabel(title: "", font: SGDesign.fontBoldOfSize(18))
		self.addSubview(value, name: "v")
		
		self.contributeButton = SGButton(title: localisedString("Contribute"), font: SGDesign.fontBoldOfSize(18), background: SGDesign.colourYellow(), textColour: SGDesign.colourWhite(), target: self, action: #selector(contribute), rounded: false, image: nil)
		self.addSubview(contributeButton, name: "c")
		
		metrics["tabBarHeight"] = self.tabBarController?.tabBar.frame.height
		
		self.addConstraints(visualFormat: "V:|-(10)-[f]-(10)-[v]-(5)-[s]-(>=0)-[c]-(tabBarHeight)-|", layoutFormat: [NSLayoutFormatOptions.AlignAllCenterX], metrics: metrics, views: views)
		self.addConstraintAlignLeftAndRightEdges(view1: self.view, view2: contributeButton)
		self.addConstraintHeight(view: featureCell, height: SGFeatureTableViewCell.height())
		self.addConstraintWidth(view: featureCell, width: self.view.frame.width - 20)
		self.addConstraintSize(view: self.value, height: 50, width: 50)
		self.addConstraintWidth(view: self.slider, width: self.view.frame.width * 0.8)
		
	}
	
	func contribute() {
		let val = Double(slider.value)
		self.showActivityView { (d) in
			SGAPI.postContributionForAttribute(attribute: self.feature.attribute.name, fromUser: currentUser.username, toUser: self.user.username, value: val, completion: { (success, error) in
				if error != nil {
					SGAlertView.show(message: "Please check your internet connection.")
				} else {
					if success {
						self.pop()
					} else {
						SGAlertView.show(message: "Something went wrong.")
					}
				}
			})
		}
	}
	
	func updateValue(sender: UISlider) {
		let val = slider.value
		value.text = "\(val)%"
		
		if val < 0.4 {
			contributeButton.setBackgroundColour(SGDesign.colourRed())
		} else if val > 0.6 {
			contributeButton.setBackgroundColour(SGDesign.colourGreen())
		} else {
			contributeButton.setBackgroundColour(SGDesign.colourYellow())
		}
		
	}
	
}








