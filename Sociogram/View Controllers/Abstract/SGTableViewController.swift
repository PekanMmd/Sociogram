//
//  SGTableViewController.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGTableViewController: SGViewController, UITableViewDataSource, UITableViewDelegate {
	
	var tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
	var spacing : CGFloat = 5
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.separatorStyle = .None
		self.tableView.backgroundColor = SGDesign.colourBackground()
		
		layoutUI()
		
	}
	
	func layoutUI() {
		metrics["tabBarHeight"] = self.tabBarController?.tabBar.frame.height
		self.addSubview(tableView, name: "table")
		self.addConstraintsFormat(visualFormat: "H:|-(5)-[table]-(5)-|", layoutFormat: [])
		self.addConstraintsFormat(visualFormat: "V:|[table]-(tabBarHeight)-|", layoutFormat: [])
	}
	
	// Data Source
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 30
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
//
//	func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//		return false
//	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 5
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 0
	}
	
	// Delegate
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		return
	}
	
}
