//
//  CreditsPageViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 10/5/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class CreditsPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "backTapped", sender: self)
    }
    
}
