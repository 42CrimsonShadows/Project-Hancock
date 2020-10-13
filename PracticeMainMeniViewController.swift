//
//  PracticeMainMeniViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 9/7/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class PracticeMainMeniViewController: UIViewController {
    
    //setting up outlets
    
    @IBOutlet weak var linePracticeButton: UIButton!
    @IBOutlet weak var letterMatchingButton: UIButton!
    @IBOutlet weak var letterImitationLower: UIButton!
    @IBOutlet weak var letterImitationUpper: UIButton!
    @IBOutlet weak var freeDrawButton: UIButton!
    @IBOutlet weak var puzzlesTapped: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lock rotation
        AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func linePracticeTapped(_ sender: Any) {
        performSegue(withIdentifier: "linePractice", sender: self)
    }
    
    
    @IBAction func letterMatchingTapped(_ sender: Any) {
        performSegue(withIdentifier: "letterMatching", sender: self)
    }
    
    
    @IBAction func letterImitationLowerTapped(_ sender: Any) {
        performSegue(withIdentifier: "letterImitationLower", sender: self)
        
    }
    
    @IBAction func letterImitationUpperTapped(_ sender: Any) {
        performSegue(withIdentifier: "letterImitationUpper", sender: self)
    }
    

    
    
    @IBAction func freeDrawTapped(_ sender: Any) {
        performSegue(withIdentifier: "freeDraw", sender: self)
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func puzzlesTapped(_ sender: Any) {
        performSegue(withIdentifier: "puzzleTapped", sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
}
