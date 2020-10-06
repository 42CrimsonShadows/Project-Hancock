//
//  letterMatchingMenuViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 7/13/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class letterMatchingMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lock rotation
        AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func aThroughZTapped(_ sender: Any) {
        performSegue(withIdentifier: "aThroughZ", sender: self)
    }
    
    @IBAction func bAndDTapped(_ sender: Any) {
        performSegue(withIdentifier: "bAndDTapped", sender: self)
    }
    
    @IBAction func pGQTapped(_ sender: Any) {
        performSegue(withIdentifier: "pGAndQTapped", sender: self)
    }
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed
//        AppDelegate.AppUtility.lockOrientation(.all)
    }

}
