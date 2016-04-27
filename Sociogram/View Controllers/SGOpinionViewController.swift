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
		self.slider.setValue(Float(feature.value), animated: false)
		self.slider.addTarget(self, action: #selector(updateValue), forControlEvents: .ValueChanged)
		self.addSubview(slider, name: "s")
		
		self.value = SGLabel(title: "\(self.feature.value * 100)%", font: SGDesign.fontBoldOfSize(24))
		self.addSubview(value, name: "v")
		
		self.contributeButton = SGButton(title: localisedString("Contribute"), font: SGDesign.fontBoldOfSize(18), background: SGDesign.colourYellow(), textColour: SGDesign.colourWhite(), target: self, action: #selector(contribute), rounded: false, image: nil)
		if feature.value < 0.4 {
			self.contributeButton.setBackgroundColour(SGDesign.colourRed())
		} else if feature.value > 0.6 {
			self.contributeButton.setBackgroundColour(SGDesign.colourGreen())
		} else {
			self.contributeButton.setBackgroundColour(SGDesign.colourYellow())
		}
		self.addSubview(contributeButton, name: "c")
		
		metrics["tabBarHeight"] = self.tabBarController?.tabBar.frame.height
		
		self.addConstraints(visualFormat: "V:|-(10)-[f]-(10)-[v]-(5)-[s]-(>=0)-[c]-(tabBarHeight)-|", layoutFormat: [NSLayoutFormatOptions.AlignAllCenterX], metrics: metrics, views: views)
		self.addConstraintAlignLeftAndRightEdges(view1: self.view, view2: contributeButton)
		self.addConstraintHeight(view: featureCell, height: SGFeatureTableViewCell.height())
		self.addConstraintWidth(view: featureCell, width: self.view.frame.width - 20)
		self.addConstraintSize(view: self.value, height: 80, width: 80)
		self.addConstraintWidth(view: self.slider, width: self.view.frame.width * 0.8)
		self.addConstraintHeight(view: self.contributeButton, height: SGDesign.sizeBottomButton())
		
	}
	
	func contribute() {
		let val = Double(slider.value)
		self.showActivityView { (d) in
			SGAPI.postContributionForAttribute(attribute: self.feature.attribute.name, fromUser: currentUser.username, toUser: self.user.username, value: val, completion: { (success, error) in
				if error != nil {
					SGAlertView.show(message: "Please check your internet connection.")
					self.hideActivityView()
				} else {
					if success {
						self.pop()
					} else {
						SGAlertView.show(message: "Something went wrong.")
					}
					self.hideActivityView()
				}
			})
		}
	}
	
	func updateValue(sender: UISlider) {
		let val = slider.value
		value.text = String(format: "%2.1f", val * 100) + "%"
		
		UIView.animateWithDuration(0.25) { 
			if val < 0.4 {
				self.contributeButton.setBackgroundColour(SGDesign.colourRed())
			} else if val > 0.6 {
				self.contributeButton.setBackgroundColour(SGDesign.colourGreen())
			} else {
				self.contributeButton.setBackgroundColour(SGDesign.colourYellow())
			}
		}
	}
	
}








