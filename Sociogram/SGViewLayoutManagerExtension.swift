//
//  SGViewLayoutManagerExtension.swift
//  Sociogram
//
//  Created by The Steez on 22/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

extension SGViewLayoutManager {
	
	func addConstraints(visualFormat visualFormat: String, layoutFormat: NSLayoutFormatOptions, metrics: [String: CGFloat]?, views: [String: UIView]) {
		self.contentview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: layoutFormat, metrics: metrics, views: views))
	}
	
	func addConstraintEqualWidths(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraint(NSLayoutConstraint(item: view1, attribute: .Width, relatedBy: .Equal, toItem: view2, attribute: .Width, multiplier: 1, constant: 0))
	}
	
	func addConstraintEqualHeights(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraint(NSLayoutConstraint(item: view1, attribute: .Height, relatedBy: .Equal, toItem: view2, attribute: .Height, multiplier: 1, constant: 0))
	}
	
	func addConstraintEqualSizes(  view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraintEqualHeights(view1: view1, view2: view2)
		self.contentview.addConstraintEqualWidths( view1: view1, view2: view2)
	}
	
	func addConstraintAlignCenterX(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraint(NSLayoutConstraint(item: view1, attribute: .CenterX, relatedBy: .Equal, toItem: view2, attribute: .CenterX, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignCenterY(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraint(NSLayoutConstraint(item: view1, attribute: .CenterY, relatedBy: .Equal, toItem: view2, attribute: .CenterY, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignCenters(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraintAlignCenterX(view1: view1, view2: view2)
		self.contentview.addConstraintAlignCenterY(view1: view1, view2: view2)
	}
	
	func addConstraintAlignLeftEdges(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraint(NSLayoutConstraint(item: view1, attribute: .Left, relatedBy: .Equal, toItem: view2, attribute: .Left, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignRightEdges(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraint(NSLayoutConstraint(item: view1, attribute: .Right, relatedBy: .Equal, toItem: view2, attribute: .Right, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignTopEdges(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraint(NSLayoutConstraint(item: view1, attribute: .Top, relatedBy: .Equal, toItem: view2, attribute: .Top, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignBottomEdges(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraint(NSLayoutConstraint(item: view1, attribute: .Bottom, relatedBy: .Equal, toItem: view2, attribute: .Bottom, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignTopAndBottomEdges(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraintAlignTopEdges(view1: view1, view2: view2)
		self.contentview.addConstraintAlignBottomEdges(view1: view1, view2: view2)
	}
	
	func addConstraintAlignLeftAndRightEdges(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraintAlignLeftEdges(view1: view1, view2: view2)
		self.contentview.addConstraintAlignRightEdges(view1: view1, view2: view2)
	}
	
	func addConstraintAlignAllEdges(view1 view1: UIView, view2: UIView) {
		self.contentview.addConstraintAlignLeftAndRightEdges(view1: view1, view2: view2)
		self.contentview.addConstraintAlignTopAndBottomEdges(view1: view1, view2: view2)
	}
	
	func addConstraintHeight(view view: UIView, height: CGFloat) {
		let view = ["v" : view]
		let metric = ["h" : height]
		self.contentview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v(h)]", options: [], metrics: metric, views: view))
	}
	
	func addConstraintWidth( view view: UIView, width : CGFloat) {
		let view = ["v" : view]
		let metric = ["w" : width]
		self.contentview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[v(w)]", options: [], metrics: metric, views: view))
	}
	
	func addConstraintSize( view view: UIView, height: CGFloat, width : CGFloat) {
		self.contentview.addConstraintWidth( view: view, width : width)
		self.contentview.addConstraintHeight(view: view, height: height)
	}
	
	func addShadowToView(view view: UIView, radius: CGFloat, xOffset: CGFloat, yOffset: CGFloat) {
		
		view.layer.masksToBounds = false
		view.layer.shadowOpacity = 0.9
		view.layer.shadowOffset = CGSizeMake(xOffset, yOffset)
		view.layer.shadowColor = UIColor.blackColor().CGColor
		view.layer.shadowRadius = radius
		
	}
	
}