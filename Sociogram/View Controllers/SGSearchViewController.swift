//
//  SGSearchViewController.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGSearchViewController: SGTableViewController, UITextFieldDelegate {
	
	var users = [SGUser]()
	var searchBar = UITextField()
	var av = UIActivityIndicatorView()
	
	override var activityView : UIView {
		get {
			return av
		}
		set {
			return
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		search()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.tabBarItem.title = localisedString("Search")
		self.title = localisedString("Search")
    }
	
	override func layoutActivityView() {
		av.alpha = 0
		av.activityIndicatorViewStyle = .Gray
		av.startAnimating()
		self.addSubview(activityView, name: "av")
		self.addConstraintsFormat(visualFormat: "V:[bar]-(5)-[av]", layoutFormat: [NSLayoutFormatOptions.AlignAllCenterX])
		self.addConstraintSize(view: av, height: 15, width: 15)
	}
	
	override func layoutUI() {
		
		self.searchBar.placeholder = localisedString("Search")
		self.searchBar.backgroundColor = SGDesign.colourWhite()
		self.searchBar.delegate = self
		self.searchBar.layer.cornerRadius = SGDesign.sizeCornerRadius()
		self.searchBar.clearButtonMode = .Always
		self.searchBar.returnKeyType = .Search
		self.searchBar.autocapitalizationType = .None
		self.addSubview(searchBar, name: "bar")
		
		metrics["tabBarHeight"] = self.tabBarController?.tabBar.frame.height
		self.addSubview(tableView, name: "table")
		self.addConstraintsFormat(visualFormat: "V:|-(10)-[bar(40)]-(20)-[table]-(tabBarHeight)-|", layoutFormat: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight])
		self.addConstraintsFormat(visualFormat: "H:|-(5)-[table]-(5)-|", layoutFormat: [])
		
	}
	
	func updateUI() {
		
		tableView.reloadData()
		
	}
	
	func search() {
		
		self.showActivityView { b in
			self.searchBar.resignFirstResponder()
			let searchString = self.searchBar.text
			
			if searchString == nil {
				self.clearSearch()
				return
			}
			
			if (searchString == "") {
				self.clearSearch()
				return
			}
			
			SGAPI.getUserlistSearch(name: searchString!) { (response, e) in
				self.hideActivityView()
				
				guard e == nil else {
					SGAlertView.show(message: "Please check your internet connection.")
					return
				}
				
				guard let users = response else {
					SGAlertView.show(message: "No results for search:\n" + searchString!)
					return
				}
				
				if users.count == 0 {
					SGAlertView.show(message: "No results for search:\n" + searchString!)
				}
				
				self.users = users
				self.updateUI()
				
			}
		}
		
	}
	
	func clearSearch() {
		self.hideActivityView()
		self.users = []
		self.updateUI()
	}
	
	// Data source
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		if indexPath.section == 0 {
			return tableView.dequeueReusableCellWithIdentifier("h") ?? SGHeaderTableViewCell(title: localisedString("Results"), reuseIdentifier: "h")
		}
		
		let user = users[indexPath.section - 1]
		
		let cell = tableView.dequeueReusableCellWithIdentifier("c") as? SGUserTableViewCell ?? SGUserTableViewCell(user: user, reuseIdentifier: "c")
		cell.user = user
		cell.update()
		return cell
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return users.count > 0 ? users.count + 1 : 0
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return  indexPath.section == 0 ? SGHeaderTableViewCell.height() : SGUserTableViewCell.height()
	}
	
	// TableView Delegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
		
		guard indexPath.section != 0 else {
			return
		}
		
		let profileVC = SGProfileViewController()
		profileVC.user = self.users[indexPath.section - 1]
		
		self.navigationController?.pushViewController(profileVC, animated: true)
		
	}
	
	// TextField Delegate
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		guard string != "\n" else {
			self.search()
			return false
		}
		return true
	}
	
	
}







