//
//  SGTimelineViewController.swift
//  Sociogram
//
//  Created by The Steez on 21/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit

class SGTimelineViewController: SGTableViewController {
	
	var comments = [SGComment]()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.tabBarItem.title = localisedString("Timeline")
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		getTimeLine()
	}
	
	func updateUI() {
		
		tableView.reloadData()
		
	}
	
	func getTimeLine() {
		self.showActivityView { (done) in
			SGAPI.getUserTimelineComments(username: currentUser.username) { (comments, error) in
				if comments != nil {
					self.comments = comments!
					self.updateUI()
					
					if comments!.count == 0 {
						SGAlertView.show(message: "There are no posts which you are following")
					}
					
				} else {
					SGAlertView.show(message: "Please check your internet connection.")
				}
				self.hideActivityView()
			}
		}
	}
	
	// Data source
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		var comment : SGComment?
		
		if indexPath.section < comments.count {
			comment = comments[indexPath.section]
		}
		
		let cell = tableView.dequeueReusableCellWithIdentifier("c") as? SGCommentTableViewCell ?? SGCommentTableViewCell(comment: comment, reuseIdentifier: "c")
		cell.comment = comment
		cell.update()
		return cell
		
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return comments.count
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return SGCommentTableViewCell.height()
	}
	
	// Delegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		return
	}
	
	
}
