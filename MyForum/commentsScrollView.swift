//
//  commentsScrollView.swift
//  MyForum
//
//  Created by Anya Gerasimchuk on 1/18/16.
//  Copyright © 2016 Anya Gerasimchuk. All rights reserved.
//

import Foundation
import UIKit

class commentsScrollView: UIViewController {
    
    @IBOutlet weak var wallScroll: UIScrollView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Clean the scroll view
        cleanWall()
        
        //Reload the wall
        getWallImages()
    }
    
    // MARK: - Wall
    func cleanWall()
    {
        for viewToRemove in wallScroll.subviews {
            if let viewToRemove = viewToRemove as? UIView {
                viewToRemove.removeFromSuperview()
            }
        }
    }
    
    func getWallImages() {
        //1
        let query = ForumPost.query()!
        query.findObjectsInBackgroundWithBlock { objects, error in
            if error == nil {
                
                print("nil error found")
                //2
                if let objects = objects as? [ForumPost] {
                    print("left objects as ForumPost")
                    self.loadWallViews(objects)
                }
            } else if let error = error {
                print("A funny error")
            }
        }
    }
    
    func loadWallViews(objects: [ForumPost]) {
        //Clean the scroll view
        cleanWall()
        
        var originY: CGFloat = 0
        for wallPost: ForumPost in objects {
            print("this wall post: \(wallPost)")
            let wallView = UIView(frame: CGRect(x: 0, y: originY, width: self.wallScroll.frame.size.width, height: 270))
            
            //2
            //print("getting the image now")
            
            if wallPost.image != nil {
            wallPost.image!.getDataInBackgroundWithBlock { data, error in
                
                //print("an image here is: \(wallPost.image)")
                if let data = data {
                    if let image = UIImage(data: data) {
                        
                        
                        
//3
                        //Add the image
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: 10, y: 10, width: wallView.frame.size.width - 20, height: 200)
                        imageView.contentMode = UIViewContentMode.ScaleAspectFit
                        wallView.addSubview(imageView)
                        
                        //4
                        //Add the info label (User and creation date)
                        let creationDate = wallPost.createdAt
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "HH:mm dd/MM yyyy"
                        
                        let infoLabel = UILabel(frame: CGRect(x: 10, y: 220, width: 0, height: 0))
                        let dateString = dateFormatter.stringFromDate(creationDate!)
                        
                        /*
                        if let username = ForumPost.user.username {
                            infoLabel.text = "Uploaded by: \(username), \(dateString)"
                        } else {
                            infoLabel.text = "Uploaded by anonymous: , \(dateString)"
                        }
*/
                        
                        //infoLabel.text = "Uploaded by: \(ForumPost.user.username), \(dateString)"
                        infoLabel.text = "Uploaded by Anya"
                        infoLabel.font = UIFont(name: "HelveticaNeue", size: 12)
                        infoLabel.textColor = UIColor.blackColor()
                        infoLabel.backgroundColor = UIColor.clearColor()
                        infoLabel.sizeToFit()
                        wallView.addSubview(infoLabel)
                        
                        //5
                        //Add the comment label (User and creation date)
                        
                        let commentLabel = UILabel(frame: CGRect(x: 10, y: CGRectGetMaxY(infoLabel.frame)+5, width:300, height: 300))
                        commentLabel.text = wallPost.comment!
                        commentLabel.font = UIFont(name: "HelveticaNeue", size: 16)
                        commentLabel.textColor = UIColor.blackColor()
                        commentLabel.backgroundColor = UIColor.clearColor()
                        commentLabel.sizeToFit()
                        print("Comment is: \(commentLabel.text!)")
                        wallView.addSubview(commentLabel)
                        //originY += 270
                        
                    }
                }
            }
            }else{
                let infoLabel = UILabel(frame: CGRect(x: 10, y: 220, width: 0, height: 0))
                //let commentLabel = UILabel(frame: CGRect(x: 10, y: CGRectGetMaxY(infoLabel.frame)+5, width:300, height: 300))
                let commentText = UITextView(frame: CGRect(x: 10, y: CGRectGetMaxY(infoLabel.frame)+5, width:300, height: 300))
                commentText.text = wallPost.comment!
                commentText.font = UIFont(name: "HelveticaNeue", size: 16)
                commentText.textColor = UIColor.blackColor()
                commentText.backgroundColor = UIColor.clearColor()
                commentText.sizeToFit()
                print("Comment is: \(commentText.text!)")
                //wallView.addSubview(commentLabel)
                print("no image available")
                //originY += 100
            }
            
            //6
            print("adding a subview now for this wallView: \(wallView)")
            self.wallScroll.addSubview(wallView)
            originY += 500
        }
        //7
        print("setting height")
        self.wallScroll.contentSize.height = CGFloat(originY)
    }
    
    // MARK: - Actions
    @IBAction func logOutPressed(sender: AnyObject) {
        PFUser.logOut()
        navigationController?.popToRootViewControllerAnimated(true)
    }
}