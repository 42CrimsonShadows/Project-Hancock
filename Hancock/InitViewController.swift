//
//  InitViewController.swift
//  Hancock
//
//  Created by Casey on 5/30/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit
import Firebase

class InitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
        }
    }

}
