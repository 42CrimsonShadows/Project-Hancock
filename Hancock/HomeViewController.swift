//
//  HomeViewController.swift
//  Hancock
//
//  Created by Casey on 5/30/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    
    @IBOutlet weak var upperCaseImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up to perform segue programmatically
        let tap =  UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        upperCaseImage.isUserInteractionEnabled = true
        upperCaseImage.addGestureRecognizer(tap)
    }
    
    @IBAction func logoutHandler(_ sender: Any) {
        try! Auth.auth().signOut()
        print("Successfully logged out")
        self.dismiss(animated: false, completion: nil)
    }

    @objc func tappedMe(){
        //action to perform segue
        performSegue(withIdentifier: "toChapterPage", sender: self)
    }
}
