//
//  ForumPost.swift
//  MyForum
//
//  Created by Anya Gerasimchuk on 1/14/16.
//  Copyright © 2016 Anya Gerasimchuk. All rights reserved.
////http://www.raywenderlich.com/98831/parse-tutorial-getting-started-web-backends
//

import Foundation

class ForumPost: PFObject{
    //make either image of comment optional by adding ?
    @NSManaged var image: PFFile?
    @NSManaged var user: PFUser
    @NSManaged var comment: String?
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: ForumPost.parseClassName())
        query.includeKey("user")
        query.orderByDescending("createdAt")
        return query
    }

    init(image: PFFile?, comment: String?, user: PFUser){
        super.init()
        
        self.image = image
        self.user = user
        self.comment = comment
    }
    
    override init(){
        super.init()
    }
    
}

extension ForumPost: PFSubclassing{
    class func parseClassName() -> String {
        return "ForumPost"
    }
    
    override class func initialize(){
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
}
