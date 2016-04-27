//
//  Sociogram
//
//  Created by The Steez on 08/03/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGViewController : UIViewController, SGViewLayoutManager {
	
	var contentview : UIView! { return self.view }
	
	var activityView : UIView = SGActivityView()
	
	var views    = [String : UIView ]()
	var metrics  = [String : CGFloat]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.addMetric(value: self.view.frame.width , name: "screenWidth")
		self.addMetric(value: self.view.frame.height, name: "screenHeight")
		
		setUpNavigationBar()
		self.activityView.alpha = 0
		self.view.backgroundColor = SGDesign.colourBackground()
		self.title = localisedString("AppName")
		self.navigationController?.navigationBar.backItem?.hidesBackButton = false
	}
	
	func setUpNavigationBar() {
		
		let titleTextAttributes = [NSForegroundColorAttributeName : SGDesign.colourWhite(), NSFontAttributeName : SGDesign.fontBoldOfSize(18)]
		self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
		self.navigationController?.navigationBar.barTintColor = SGDesign.colourMainTheme()
		self.navigationController?.navigationBar.tintColor = SGDesign.colourWhite()
		self.navigationController?.navigationBar.translucent = false
		
	}
	
	//MARK: - View layout
	func addSubview(view: UIView, name: String) {
		
		view.translatesAutoresizingMaskIntoConstraints = false
		self.contentview.addSubview(view)
		self.views[name] = view
		
	}
	
	func addMetric(value value: CGFloat, name: String) {
		self.metrics[name] = value
	}
	
	func addConstraintsFormat(visualFormat visualFormat: String, layoutFormat: NSLayoutFormatOptions) {
		self.addConstraints(visualFormat: visualFormat, layoutFormat: layoutFormat, metrics: metrics, views: views)
	}
	
	func createDummyViews(number : Int, baseName : String, orientation : SGOrientations) {
		
		for i in 1 ..< number{
			
			let dummy = UIView()
			dummy.userInteractionEnabled = false
			dummy.alpha = 0.0
			dummy.hidden = true
			dummy.translatesAutoresizingMaskIntoConstraints = false
			
			self.addSubview(dummy, name: baseName + "\(i)")
			
			guard i > 1 else {
				continue
			}
			if orientation == .Horizontal {
				self.addConstraintEqualWidths(view1: views[baseName + "\(1)"]!, view2: views[baseName + "\(i)"]!)
			} else {
				self.addConstraintEqualHeights(view1: views[baseName + "\(1)"]!, view2: views[baseName + "\(i)"]!)
			}
			
			
		}
	}
	
	
	//MARK: - Dismiss
	func pop() {
		self.navigationController?.popViewControllerAnimated(true)
	}
	
	
	//MARK: - Activity view methods
	func showActivityView() {
		self.showActivityView(nil)
	}
	
	func showActivityView(completion: ( (Bool) -> Void)! ) {
		
		layoutActivityView()
		UIView.animateWithDuration(0.25, animations: {
			self.activityView.alpha = 0.5
			}, completion : { (done: Bool) -> Void in
				if completion != nil {
					completion(done)
				}
		})
		
	}
	
	func layoutActivityView() {
		self.activityView.alpha = 0
		self.contentview.addSubview(activityView)
		let views = ["av" : activityView]
		self.contentview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[av]|", options: [], metrics: nil, views: views))
		self.contentview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[av]|", options: [], metrics: nil, views: views))
		
	}
	
	func hideActivityView() {
		UIView.animateWithDuration(0.25, animations: {
			self.activityView.alpha = 0
			}, completion: { (Bool) -> Void in
				self.activityView.removeFromSuperview()
		})
	}
	
}










