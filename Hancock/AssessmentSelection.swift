//
//  AssessmentSelection.swift
//  Hancock
//
//  Created by Lauren  Matthews on 8/17/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit
import Foundation
import ARKit


//setting up variables
var assessmentArray: [UIImage]?


class AssessmentSelection: UIViewController {
    
    //setting up image Views
    @IBOutlet weak var cardOne: UIImageView!
    @IBOutlet weak var cardTwo: UIImageView!
    @IBOutlet weak var cardThree: UIImageView!
    @IBOutlet weak var cardFour: UIImageView!
    @IBOutlet weak var cardFive: UIImageView!
    @IBOutlet weak var cardSix: UIImageView!
    @IBOutlet weak var instructionCard: UIImageView!
    @IBOutlet weak var puzzleImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let letterArray = [  #imageLiteral(resourceName: "I") , #imageLiteral(resourceName: "T"), #imageLiteral(resourceName: "L") , #imageLiteral(resourceName: "E") , #imageLiteral(resourceName: "F") , #imageLiteral(resourceName: "H")]
       let UIImages = [cardOne, cardTwo, cardThree, cardFour, cardFive, cardSix]
        instructionCard.image = letterArray.randomElement()
        
        for UIImage in UIImages {
            UIImage?.image = letterArray.randomElement()
        }

        // Do any additional setup after loading the view.
    }
    
   


}//end of class
