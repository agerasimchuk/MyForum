//
//  GlobalVariables.swift
//  MyForum
//
//  Created by Anya Gerasimchuk on 2/4/16.
//  Copyright © 2016 Anya Gerasimchuk. All rights reserved.
//

import Foundation

class GlobalVariables {
    
    // These are the properties you can store in your singleton
    //private var myName: String = "bob"
    var saved = [Bool]()
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}