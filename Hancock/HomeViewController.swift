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

    override func viewDidLoad() {
        super.viewDidLoad()
          

    }
    
    @IBAction func logoutHandler(_ sender: Any) {
        try! Auth.auth().signOut()
        print("Successfully logged out")
        self.dismiss(animated: false, completion: nil)
    }

}
