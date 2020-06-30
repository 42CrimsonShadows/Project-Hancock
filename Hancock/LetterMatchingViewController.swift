//
//  LetterMatchingViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 6/17/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class LetterMatchingViewController: UIViewController {
    //setting up instruction label
    @IBOutlet weak var instructionLabel: UILabel!
                //setting up image views - named by row and column position - LM
    //Row one
    @IBOutlet weak var rowOneCardOneImageView: UIImageView!
    @IBOutlet weak var rowOneCardTwoImageView: UIImageView!
    @IBOutlet weak var rowOneCardThreeImageView: UIImageView!
    @IBOutlet weak var rowOneCardFourImageView: UIImageView!
    @IBOutlet weak var rowOneCardFiveImageView: UIImageView!
    //Row two
    @IBOutlet weak var rowTwoCardOneImageView: UIImageView!
    @IBOutlet weak var rowTwoCardTwoImageView: UIImageView!
    @IBOutlet weak var rowTwoCardThreeImageView: UIImageView!
    @IBOutlet weak var rowTwoCardFourImageView: UIImageView!
    @IBOutlet weak var rowTwoCardFiveImageView: UIImageView!
    //Row three
    @IBOutlet weak var rowThreeCardOneImageView: UIImageView!
    @IBOutlet weak var rowThreeCardTwoImageView: UIImageView!
    @IBOutlet weak var rowThreeCardThreeImageView: UIImageView!
    @IBOutlet weak var rowThreeCardFourImageView: UIImageView!
    @IBOutlet weak var rowThreeCardFiveImageView: UIImageView!
    //Row four
    @IBOutlet weak var rowFourCardOneImageView: UIImageView!
    @IBOutlet weak var rowFourCardTwoImageView: UIImageView!
    @IBOutlet weak var rowFourCardThreeImageView: UIImageView!
    @IBOutlet weak var rowFourCardFourImageView: UIImageView!
    @IBOutlet weak var rowFourCardFiveImageView: UIImageView!
    //instruction image
    @IBOutlet weak var instructionImageView: UIImageView!
    //end of image view set up

    //setting up image array using an image literal
    let letterMatchingArray = [ #imageLiteral(resourceName: "PerpCross"), #imageLiteral(resourceName: "Triangle"), #imageLiteral(resourceName: "DiagonalCross"), #imageLiteral(resourceName: "Horizontal"), #imageLiteral(resourceName: "BookLine"), #imageLiteral(resourceName: "DiagonalRight") ] //testing with shapes
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        //set instruction label to show instruction image
        //instructionLabel.text = "test"
        
        //setup image on cards
        //row 1
        rowOneCardOneImageView.image =   letterMatchingArray.randomElement()
        rowOneCardTwoImageView.image =   letterMatchingArray.randomElement()
        rowOneCardThreeImageView.image =   letterMatchingArray.randomElement()
        rowOneCardFourImageView.image =   letterMatchingArray.randomElement()
        rowOneCardFiveImageView.image =   letterMatchingArray.randomElement()
        //row two
        rowTwoCardOneImageView.image =   letterMatchingArray.randomElement()
        rowTwoCardTwoImageView.image =   letterMatchingArray.randomElement()
        rowTwoCardThreeImageView.image =   letterMatchingArray.randomElement()
        rowTwoCardFourImageView.image =   letterMatchingArray.randomElement()
        rowTwoCardFiveImageView.image =   letterMatchingArray.randomElement()
        //row three
        rowThreeCardOneImageView.image =   letterMatchingArray.randomElement()
        rowThreeCardTwoImageView.image =   letterMatchingArray.randomElement()
        rowThreeCardThreeImageView.image =   letterMatchingArray.randomElement()
        rowThreeCardFourImageView.image =   letterMatchingArray.randomElement()
        rowThreeCardFiveImageView.image =   letterMatchingArray.randomElement()
        //row four
        rowFourCardOneImageView.image =   letterMatchingArray.randomElement()
        rowFourCardTwoImageView.image =   letterMatchingArray.randomElement()
        rowFourCardThreeImageView.image =   letterMatchingArray.randomElement()
        rowFourCardFourImageView.image =   letterMatchingArray.randomElement()
        rowFourCardFiveImageView.image =   letterMatchingArray.randomElement()
        //instruction image
        instructionImageView.image =   letterMatchingArray.randomElement()
        //end of image setup
        
        
}// End of ViewDidLoad
    

   
}
