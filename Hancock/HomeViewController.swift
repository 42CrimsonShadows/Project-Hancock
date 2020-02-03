//
//  HomeViewController.swift
//  Hancock
//
//  Created by Casey on 5/30/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var upperCaseImage: UIImageView!
    @IBOutlet weak var lowerCaseImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up to perform segue programmatically
        let tap1 =  UITapGestureRecognizer(target: self, action: #selector(tappedUpper))
        let tap2 =  UITapGestureRecognizer(target: self, action: #selector(tappedLower))
        upperCaseImage.isUserInteractionEnabled = true
        upperCaseImage.addGestureRecognizer(tap1)
        
        lowerCaseImage.isUserInteractionEnabled = true
        lowerCaseImage.addGestureRecognizer(tap2)
    }
    
    @IBAction func logoutHandler(_ sender: Any) {
//        try! Auth.auth().signOut()
        print("Successfully logged out")
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func tappedUpper(){
        //action to perform segue
        performSegue(withIdentifier: "toChapterPageUpper", sender: self)
    }
    @objc func tappedLower(){
        //action to perform segue
        performSegue(withIdentifier: "toChapterPageLower", sender: self)
    }
}
