//
//  ForumComment.swift
//  MyForum
//
//  Created by Anya Gerasimchuk on 1/19/16.
//  Copyright © 2016 Anya Gerasimchuk. All rights reserved.
//

import Foundation

class ForumComment: PFObject{


    
    @NSManaged var user: PFUser
    @NSManaged var comment: String?
    @NSManaged var title: String?
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: ForumComment.parseClassName())
        query.includeKey("user")
        query.orderByDescending("createdAt")
        return query
    }
    
    //init(image: PFFile, user: PFUser, comment: String?){
    init(comment: String?, title: String?, user: PFUser){
        super.init()
        
        self.user = user
        self.comment = comment
        self.title = title
        
    }
    
    override init(){
        super.init()
    }
    
}

extension ForumComment: PFSubclassing{
    class func parseClassName() -> String {
        return "ForumComment"
    }
    
    override class func initialize(){
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
}

