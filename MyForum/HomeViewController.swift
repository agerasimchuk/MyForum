//
//  HomeViewController.swift
//  MyForum
//
//  Created by Anya Gerasimchuk on 2/2/16.
//  Copyright © 2016 Anya Gerasimchuk. All rights reserved.
//

import Foundation

import UIKit
import CoreData

class HomeViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logoutNow(sender: AnyObject) {
        PFUser.logOut()
        
        var controller = LoginViewController()
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
        presentViewController(controller, animated: true, completion: nil)
    }
}