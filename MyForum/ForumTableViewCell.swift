//
//  ForumTableViewCell.swift
//  MyForum
//
//  Created by Anya Gerasimchuk on 1/11/16.
//  Copyright © 2016 Anya Gerasimchuk. All rights reserved.
//

import Foundation

import UIKit

class ForumTableViewCell: PFTableViewCell {

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postText: UITextField!

    @IBOutlet weak var progre: UIProgressView!
    @IBOutlet weak var postImage: PFImageView!
    
}