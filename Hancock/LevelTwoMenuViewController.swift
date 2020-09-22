//
//  LevelTwoMenuViewController.swift
//  Hancock
//
//  Created by Jasmine Young on 6/22/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class LevelTwoMenuViewController: UIViewController {
    
    // MARK: - Variables
    private var letterToLoad: String? // to set letterToDraw in LevelTwoVC

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lock rotation
        AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    @IBAction func loadLetter(_ sender: UIButton) {
        // get letter from button
        letterToLoad = sender.currentTitle! // every button connected has a title
        // load activity
        performSegue(withIdentifier: "toLevelTwoActivity", sender: self)
    }
    @IBAction func returnToMenu(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if we're going to the activity
         if let destination = segue.destination as? LevelTwoActivityViewController {
            // set letterToDraw (which is needed to load the video and letter label)
            destination.letterToDraw = letterToLoad! // segue is only performed after letterToLoad is set
        }
    }
    
  
}
