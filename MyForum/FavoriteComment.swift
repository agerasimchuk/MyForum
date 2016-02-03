//
//  FavoriteComment.swift
//  MyForum
//
//  Created by Anya Gerasimchuk on 1/22/16.
//  Copyright © 2016 Anya Gerasimchuk. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoriteComment: NSManagedObject{
    struct Keys {
        static let Comment = "comment"
        static let Title = "title"
        static let User = "user"

    }
    
    @NSManaged var comment: String
    @NSManaged var title: String
    @NSManaged var user: String
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext){
        
        let entity = NSEntityDescription.entityForName("FavoriteComment", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        comment = dictionary[Keys.Comment] as! String
        title = dictionary[Keys.Title] as! String
        user = dictionary[Keys.User] as! String
        
        print("In FavoriteComments")
        
    }
}


