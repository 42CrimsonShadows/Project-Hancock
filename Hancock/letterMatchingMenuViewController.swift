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

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func aThroughZTapped(_ sender: Any) {
        performSegue(withIdentifier: "aThroughZ", sender: self)
    }
    
    @IBAction func bAndDTapped(_ sender: Any) {
        performSegue(withIdentifier: "bAndD", sender: self)
    }
    
    @IBAction func pGQTapped(_ sender: Any) {
        performSegue(withIdentifier: "pGQ", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
