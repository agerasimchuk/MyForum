//
//  commentsViewController.swift
//  MyForum
//
//  Created by Anya Gerasimchuk on 1/20/16.
//  Copyright © 2016 Anya Gerasimchuk. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class commentsViewController: PFQueryTableViewController, NSFetchedResultsControllerDelegate{
    
    //var fcomment = [FavoriteComment]()
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    lazy var scratchContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext()
        context.persistentStoreCoordinator = CoreDataStackManager.sharedInstance().persistentStoreCoordinator
        return context
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        let query = ForumComment.query()
        return query!
    }
    
    @IBAction func backHome(sender: AnyObject) {
        var controller = HomeViewController()
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }

    //table delegate method
    //TABLE DELEGATE METHODS
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {

        
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentPostCell", forIndexPath: indexPath) as! commentsTableViewCell
        
        /*
        if (){
            cell.accessoryType = .Checkmark
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Bottom)
        } else {
            cell.accessoryType = .None
        }
    */
        // let forumPost = object as! ForumPost

        let commentPost = object as! ForumComment
        
        cell.titleLable.text = commentPost.title
        cell.commentText.text = commentPost.comment
        //cell.userLabel = commentPost.user
        //cell.userLabel = commentPost.user.username
        cell.userLabel.text = commentPost.user.username
        return cell
    }
    

    
    

    //https://github.com/ParsePlatform/ParseUI-iOS/blob/master/ParseUIDemo/Swift/CustomViewControllers/ProductTableViewController/CustomProductTableViewController.swift
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            //cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        let commentPost = objects?[indexPath.row] as! ForumComment
        
        //let commentPostT = objects as! ForumComment
        //print("Here is the favorite comment : \(commentPost)")
        var userValue:String? = commentPost.user.username! as! AnyObject? as? String!
        
        //var userValue: String = commentPost.valueForKey("user") as! String

        
        print("this is the user: \(userValue)")
        //print("user value is now: \(commentPost.valueForKey("user")!)")
        
        var commentDictionary = [String: AnyObject]()
        commentDictionary[FavoriteComment.Keys.Comment] = commentPost.valueForKey("comment")
        commentDictionary[FavoriteComment.Keys.Title] = commentPost.valueForKey("title")
        //commentDictionary[FavoriteComment.Keys.User] = commentPost?.valueForKey("user")
        //commentDictionary[FavoriteComment.Keys.User] = userValue
        commentDictionary[FavoriteComment.Keys.User] = userValue
        
        
        //print("commentDictionary is : \(commentDictionary[FavoriteComment.Keys.Comment]! )")
         //add the new comment to the CoreData object and save

        let favoriteComment = FavoriteComment(dictionary: commentDictionary, context: self.sharedContext)
        
        print("favoriteComment: \(favoriteComment.comment)")
        
               //self.fcomment.append(favoriteComment)
        
        CoreDataStackManager.sharedInstance().saveContext()
        
        //print("And now the Favorite Comments are: \(fcomment)")
           }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .None
        }
    }
    

    @IBAction func LogoutPressed(sender: AnyObject) {
        PFUser.logOut()
        
        var controller = LoginViewController()
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
        presentViewController(controller, animated: true, completion: nil)    }
}

