//
//  SGAPI.swift
//  Sociogram
//
//  Created by The Steez on 07/03/2016.
//  Copyright © 2016 UCL. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class SGAPI : NSObject {
	
	/*
	 *  http://188.166.175.91:8080/listfn lists all https methods and their parameters
	 */
	
	private static let urlBasePath = "http://geoul.co.uk/"
	
	private class var userListPath : String {
		get {
			return urlBasePath + "getuserlist/"
		}
	}
	
	private class var userDetailsPath : String {
		get {
			return urlBasePath + "getuserdetail/"
		}
	}
	
	private class var followerListPath : String {
		get {
			return urlBasePath + "getfriendlist/"
		}
	}
	
	private class var attributeStatsPath : String {
		get {
			return urlBasePath + "getstats/"
		}
	}
	
	private class var attributesListPath : String {
		get {
			return urlBasePath + "getattributelist"
		}
	}
	
	private class var userFeaturesStatsPath : String {
		get {
			return urlBasePath + "userstats/"
		}
	}
	
	private class var featureContributionsPath : String {
		get {
			return urlBasePath + "contribute"
		}
	}
	
	private class var postCommentPath : String {
		get {
			return urlBasePath + "post"
		}
	}
	
	private class var publicPostsToUserPath : String {
		get {
			return urlBasePath + "publicpostto"
		}
	}
	
	private class var privatePostsToUserPath : String {
		get {
			return urlBasePath + "postto"
		}
	}
	
	private class var timelinePath : String {
		get {
			return urlBasePath + "friendpost"
		}
	}
	
	private class var signupPath : String {
		get {
			return urlBasePath + "signup"
		}
	}
	
	private class var loginPath : String {
		get {
			return urlBasePath + "login"
		}
	}
	
	private class var photoPath : String {
		get {
			return urlBasePath + "profile-photo"
		}
	}
	
	private class var updatePostPrivacyPath : String {
		get {
			return urlBasePath + "updateprivacy"
		}
	}
	
	private class var followPath : String {
		get {
			return urlBasePath + "addfriend"
		}
	}
	
	private class var headers : [String : String]? {
		get {
			return nil
		}
	}
	
	class func getUserlistSearch(name name: String, completion: ([SGUser]?, NSError?) -> Void ) {
		// Returns a list of users matching the specified name string
		
		if name.containsString(" ") {
			completion(nil, nil)
			return
		}
		
		Alamofire.request(.GET, userListPath + name, parameters: nil, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			let users = response.result.value as! [ [String : AnyObject] ]
			
			var usernames = [SGUser]()
			
			for user in users {
				usernames.append(SGUser(dictionaryRepresentation: user))
			}
			
			completion(usernames, nil)

		}
	}
	
	class func getUserDetails(username name: String, completion: (SGUser?, NSError?) -> Void ) {
		// Returns the details for a user
		
		Alamofire.request(.GET, userDetailsPath + name, parameters: nil, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			print(response)
			let dict = response.result.value as! [ [String: AnyObject] ]
			let user = SGUser(dictionaryRepresentation: dict[0])
			
			completion(user, nil)
			
		}
	}
	
	class func getFollowersForUser(username name: String, completion: ([String]?, NSError?) -> Void ) {
		// Returns the details for a user
		
		Alamofire.request(.GET, followerListPath + name, parameters: nil, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			let u = response.result.value as! [ [String : AnyObject] ]
			var users = [String]()
			for user in u {
				users.append(user["visible_to"]! as! String)
			}
			completion(users, nil)
			
		}
		
	}

	class func getStatsForAttribute(attribute attr: String, completion: (SGAttribute?, NSError?) -> Void ) {
		// Returns the details for a user
		
		Alamofire.request(.GET, attributeStatsPath + attr, parameters: nil, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			let dict = response.result.value as! [String: AnyObject]
			let attribute = SGAttribute(dictionaryRepresentation: dict)
			
			completion(attribute, nil)
			
		}
	}
	
	class func getAttributeList(completion: ([String]?, NSError?) -> Void ) {
		// Returns a list of users matching the specified name string
		
		Alamofire.request(.GET, attributesListPath).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			let attrs = response.result.value as! [String]
			completion(attrs, nil)
			
		}
	}

	class func getFeatureForUser(username name: String, attribute: String, completion: (SGFeature?, NSError?) -> Void ) {
		// Returns the details for a user
		
		Alamofire.request(.GET, userFeaturesStatsPath + name + "/" + attribute).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			let dict = response.result.value as! [[String: AnyObject]]
			let feature : SGFeature? = dict.count > 0 ? SGFeature(dictionaryRepresentation: dict[0]) : nil
			
			completion(feature, nil)
			
		}
	}
	
	class func postContributionForAttribute(attribute attr: String, fromUser from: String, toUser to: String, value: Double, completion: (Bool, NSError?) -> Void ) {
		// Returns the details for a user
		
		let params : [String : AnyObject] = ["att" : attr, "user_from" : from, "user_to" : to, "quantity" : value]
		
		Alamofire.request(.POST, featureContributionsPath, parameters: params, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(false, response.result.error)
				return
			}
			
			print(response)
			let result = response.result.value as! [String : AnyObject]
			let success = result["success"] as! Bool
			completion(success, nil)
			
		}
	}
	
	class func postNewLogin(username username: String, firstname: String, lastname: String, password: String, email: String, gender: String, age: Int, completion: (Bool, NSError?) -> Void) {
		//Sign up
		
		let params : [String : AnyObject] = ["username" : username, "name" : firstname + " " + lastname, "password" : password, "email" : email, "gender" : gender, "age" : age]
		
		Alamofire.request(.POST, signupPath, parameters: params, encoding: .JSON, headers: headers).responseJSON { response in
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(false, response.result.error)
				return
			}
			
			let success = response.result.error == nil
			completion(success, nil)
		}
	}
	
	class func postCommentToUser(message message: String, toUser to: String, completion: (Bool, NSError?) -> Void ) {
		// Returns the details for a user
		
		let params : [String : AnyObject] = ["content": message, "is_private" : true, "recipient" : to, "author" : currentUser.username, "date" : SGDesign.dateFormatter().stringFromDate(NSDate(timeIntervalSinceNow: 0)), "agree" : 0, "disagree" : 0]
		
		Alamofire.request(.POST, postCommentPath, parameters: params, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(false, response.result.error)
				return
			}
			
			let success = response.result.error == nil
			
//			let success = response.result.value as! Bool
			completion(success, nil)
			
		}
	}
	
	class func getUserComments(username user: String, includePrivate priv: Bool, completion: ([SGComment]?, NSError?) -> Void) {
		
		let params : [String : AnyObject] = ["user" : user]
		let path = priv ? privatePostsToUserPath : publicPostsToUserPath
		
		Alamofire.request(.POST, path, parameters: params, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			let dict = response.result.value as! [ [String: AnyObject] ]
			var comments = [SGComment]()
			
			for c in dict {
				let com = SGComment(dictionaryRepresentation: c)
				comments.append(com)
			}
			
			completion(comments, nil)
			
		}
	}
	
	class func putUpdateCommentPrivacy(id: Int, privacy priv: Bool, completion: (Bool?, NSError?) -> Void) {
		
		let params : [String : AnyObject] = ["id" : id, "private" : priv]
		
		Alamofire.request(.PUT, updatePostPrivacyPath, parameters: params, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(false, response.result.error)
				return
			}
			
			let success = response.result.error == nil
			
			completion(success, nil)
			
		}
	}
	
	
	class func getUserTimelineComments(username user: String, completion: ([SGComment]?, NSError?) -> Void) {
		let params : [String : AnyObject] = ["user" : user]
		
		Alamofire.request(.POST, timelinePath, parameters: params, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			let dict = response.result.value as! [ [String: AnyObject] ]
			var comments = [SGComment]()
			
			for c in dict {
				let com = SGComment(dictionaryRepresentation: c)
				comments.append(com)
			}
			
			completion(comments, nil)
			
		}
	}
	
	class func login(username user: String, password pass: String, completion: (Bool, NSError?) -> Void) {
		let params = ["username" : user, "password" : pass]
		Alamofire.request(.POST, loginPath, parameters: params, encoding: .JSON, headers: headers).responseJSON { response in
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(false, response.result.error)
				return
			}
			
			print(response.result.value)
			let success = response.result.value as! Bool
			completion(success, nil)
		}
	}
	
	class func follow(follower: String, following: String, completion: (Bool, NSError?) -> Void) {
		let params = ["username" : following, "visible_to" : follower]
		
		Alamofire.request(.POST, followPath, parameters: params, encoding: .JSON, headers: headers).responseJSON { response in
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(false, response.result.error)
				return
			}
			
			let success = response.result.error == nil
			completion(success, nil)
		}
	}
	
	class func getUserPhoto(username user: String, completion: (UIImage?, NSError?) -> Void) {
		let params : [String : AnyObject] = ["username" : user]
		
		Alamofire.request(.GET, photoPath, parameters: params, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(nil, response.result.error)
				return
			}
			
			let dict = response.result.value as! NSData
			let image = UIImage(data: dict)
			
			completion(image, nil)
			
		}
	}
	
	class func postUserPhoto(username user: String, photo: UIImage, completion: (Bool, NSError?) -> Void) {
		
//		let imagedata = UIImagePNGRepresentation(photo)!.byte
		let params : [String : AnyObject] = ["username" : user]
		
		Alamofire.request(.POST, photoPath, parameters: params, encoding: .JSON, headers: nil).responseJSON {
			response in
			
			guard response.result.isSuccess else {
				print("Error: \(response.result.error)")
				completion(false, response.result.error)
				return
			}
			
			print(response)
			let result = response.result.value as! [String : AnyObject]
			let success = result["success"] as! Bool
			completion(success, nil)
			
		}
	}
	
}







