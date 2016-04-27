//
//  SGProfileViewController.swift
//  Sociogram
//
//  Created by The Steez on 19/04/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import UIKit
import Alamofire

class SGProfileViewController: SGTableViewController {

	//MARK: - Properties
	
	var user	= SGUser.defaultUser()
	var comments = [SGComment]()
	
	var isUser : Bool {
		return user == currentUser // Used to check if it is the user's own profile
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = user.username
		
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		updateUI()
		updateUser()
		getFeatures()
		getComments()
	}
	
	func updateUI() {
		
		tableView.reloadData()
		
	}
	
	func updateUser() {
		
		self.showActivityView { (d) in
			SGAPI.getUserDetails(username: self.user.username, completion: { (user, error) in
				if error != nil {
					SGAlertView.show(message: "Please check your internet connection.")
				} else {
					if user != nil {
						self.user = user!
						if self.isUser {
							currentUser = user!
						}
					}
				}
			})
		}
		
	}
	
	func getFeatures() {
		
		self.showActivityView { (done) in
			SGAPI.getUserFeatures(username: self.user.username, completion: { (featureList, error) in
				if featureList != nil {
					self.user.features = featureList!
					self.updateUI()
				} else if error != nil {
					SGAlertView.show(message: "Couldn't get features for user.")
				}
				self.hideActivityView()
			})
		}
	}
	
	func getComments() {
		
		self.showActivityView { (done) in
			SGAPI.getUserComments(username: self.user.username, includePrivate: self.isUser) { (comments, error) in
				if comments != nil {
					self.comments = comments!
					self.updateUI()
				} else {
					SGAlertView.show(message: "Couldn't get comments for user.")
				}
				self.hideActivityView()
			}
		}
	}
	
	func featuresActions(index: Int) {
		if !self.isUser {
			
			let vc = SGOpinionViewController()
			vc.user = self.user
			vc.feature = user.listFeaturesByDescendingScores()[index]
			
			self.navigationController?.pushViewController(vc, animated: true)
			
		}
	}
	
	func editProfileAction() {
		let vc = SGNewFeatureViewController()
		
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	func viewCommentAction(index idx: Int) {
		let index = idx - firstCommentIndex()
		let comment = comments[index]
		
		let vcvc = SGViewCommentViewController()
		vcvc.comment = comment
		vcvc.user = user
		
		self.navigationController?.pushViewController(vcvc, animated: true)
		
	}
	
	func postComment() {
		let commentVC = SGPostCommentViewController()
		commentVC.user = self.user
		self.navigationController?.pushViewController(commentVC, animated: true)
	}
	
	// Table view data source
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let section = indexPath.section
		
		let fCount = user.features.count
		
		if section == 0 {
			return profileCell()
		} else if section == 1 {
			return headerCell(localisedString("Features"))
		} else if fCount > 0 {
			if section - 1 <= user.features.count {
				return featureCell(user.listFeaturesByDescendingScores()[section - 2])
			} else if section == user.features.count + 2 {
				return headerCell(localisedString("Comments"))
			} else if section == user.features.count + 3 {
				if user != currentUser {
					return postCommentCell()
				}
			}
		} else {
			if section == 2 {
				return featureCell(nil)
			} else if section == 3 {
				return headerCell(localisedString("Comments"))
			} else if section == 4 {
				if user != currentUser {
					return postCommentCell()
				}
			}
		}
		
		
		return commentCell(comments[section - firstCommentIndex()])
		
	}
	
	func profileCell() -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("p") as? SGProfileTableViewCell ?? SGProfileTableViewCell(user: user, reuseIdentifier: "p")
		cell.user = user
		cell.update()
		return cell
	}
	
	func headerCell(title: String) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("h") as? SGHeaderTableViewCell ?? SGHeaderTableViewCell(title: title, reuseIdentifier: "h")
		cell.title = title
		cell.update()
		return cell
	}
	
	func featureCell(feature: SGFeature?) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("f") as? SGFeatureTableViewCell ?? SGFeatureTableViewCell(feature: feature, reuseIdentifier: "f")
		if user.features.count > 0 {
			cell.feature = feature
			cell.isNoFeaturesCell = false
		} else {
			cell.isNoFeaturesCell = true
		}
		cell.update()
		return cell
	}
	
	func postCommentCell() -> UITableViewCell {
		return tableView.dequeueReusableCellWithIdentifier("pc") ?? SGPostTableViewCell(reuseIdentifier: "pc")
	}
	
	func commentCell(comment: SGComment?) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("c") as? SGCommentTableViewCell ?? SGCommentTableViewCell(comment: comment, reuseIdentifier: "c")
		cell.comment = comment
		cell.update()
		return cell
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		let commentCellCount = user == currentUser ? comments.count : comments.count + 1
		return 3 + commentCellCount + max(user.features.count, 1)
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		
		switch cellTypeForIndexPath(indexPath) {
			case .Profile	: return SGProfileTableViewCell.height()
			case .Header	: return SGHeaderTableViewCell.height()
			case .Feature	: return SGFeatureTableViewCell.height()
			case .Post		: return SGPostTableViewCell.height()
			case .Comment	: return SGCommentTableViewCell.height()
		}
		
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return spacing
	}
	
	// Table view delegate
	
	func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		
		switch cellTypeForIndexPath(indexPath) {
			case .Profile	: return isUser
			case .Feature	: return (user.features.count > 0)
			case .Header	: return false
			default			: return true
		}
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: false)
		
		let section = indexPath.section
		
		switch cellTypeForIndexPath(indexPath) {
			case .Profile	: if isUser { editProfileAction()  }
			case .Header	: return
			case .Feature	: if user.features.count > 0 { featuresActions(section - 2) }
			case .Post		: postComment()
			case .Comment	: viewCommentAction(index: section)
		}
	}
	
	enum SGProfileCellTypes : Int {
		case Profile = 0
		case Header
		case Feature
		case Post
		case Comment
	}
	
	func firstCommentIndex() -> Int {
		
		if user.features.count > 0 {
			let n = isUser ? user.features.count + 3 : user.features.count + 4
			return n
		} else {
			let n = isUser ? 4 : 5
			return n
		}
	}
	
	func cellTypeForIndexPath(indexPath: NSIndexPath) -> SGProfileCellTypes {
		
		let section = indexPath.section
		
		let fCount = user.features.count
		let isUser = self.user == currentUser
		
		if section == 0 {
			return .Profile
		} else if section == 1 {
			return .Header
		} else if fCount > 0 {
			if section - 1 <= user.features.count {
				return.Feature
			} else if section == user.features.count + 2 {
				return .Header
			} else if section == user.features.count + 3 {
				if !isUser {
					return .Post
				}
			}
		} else {
			if section == 2 {
				return .Feature
			} else if section == 3 {
				return .Header
			} else if section == 4 {
				if user != currentUser {
					return .Post
				}
			}
		}
		
		return .Comment
		
	}
	
	
}




















