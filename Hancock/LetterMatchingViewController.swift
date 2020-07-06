//
//  LetterMatchingViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 6/17/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class LetterMatchingViewController: UIViewController, UIGestureRecognizerDelegate {
      
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
    
    //tappedImage variable setup
    var tappedImage:UIImage? = nil

    //setting up image array using an image literal
    let letterMatchingArray = [ #imageLiteral(resourceName: "a-"), #imageLiteral(resourceName: "c-"), #imageLiteral(resourceName: "d-"), #imageLiteral(resourceName: "e-"), #imageLiteral(resourceName: "x-"), #imageLiteral(resourceName: "r-") ]
    
 
    
     override func viewDidLoad() {
        super.viewDidLoad()
                      
        //set instruction label to show instruction image
        //instructionLabel.text = "test"
        
        //setup image on cards
        //row 1
        rowOneCardOneImageView.image =  letterMatchingArray.randomElement()
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
        instructionImageView.image =   #imageLiteral(resourceName: "a-")
        //end of image setup
        
        //set up array of image views
     let imageViews = [rowOneCardOneImageView, rowOneCardTwoImageView, rowOneCardThreeImageView, rowOneCardFourImageView, rowOneCardFiveImageView, rowTwoCardOneImageView, rowTwoCardTwoImageView, rowTwoCardThreeImageView, rowTwoCardFourImageView, rowTwoCardFiveImageView, rowThreeCardOneImageView, rowThreeCardTwoImageView, rowThreeCardThreeImageView, rowThreeCardFourImageView, rowThreeCardFiveImageView, rowFourCardOneImageView, rowFourCardTwoImageView, rowFourCardThreeImageView, rowFourCardFourImageView, rowFourCardFiveImageView]
     // 2
     for  imageView in imageViews {
       // 3
       let tapGesture = UITapGestureRecognizer(
         target: self,
         action: #selector(matchTapped)
                 
       )

       // 4
       tapGesture.delegate = self
        imageView?.addGestureRecognizer(tapGesture)

       // TODO: Add a custom gesture recognizer too
     }
        
        
}// End of ViewDidLoad
    
    @objc func matchTapped(__ sender: UITapGestureRecognizer) {
        
        let tappedImageView = sender.view as! UIImageView
        
         let imageViews = [rowOneCardOneImageView, rowOneCardTwoImageView, rowOneCardThreeImageView, rowOneCardFourImageView, rowOneCardFiveImageView, rowTwoCardOneImageView, rowTwoCardTwoImageView, rowTwoCardThreeImageView, rowTwoCardFourImageView, rowTwoCardFiveImageView, rowThreeCardOneImageView, rowThreeCardTwoImageView, rowThreeCardThreeImageView, rowThreeCardFourImageView, rowThreeCardFiveImageView, rowFourCardOneImageView, rowFourCardTwoImageView, rowFourCardThreeImageView, rowFourCardFourImageView, rowFourCardFiveImageView]
        
        print(sender.view!)
        print("I have been tapped")
        
        //if rowOneCardOneImageView.image == instructionImageView.image{
        //    print("you win")
        //    rowOneCardOneImageView.image = #imageLiteral(resourceName: "Coin")
       // }//testing getting reference
        
        for _ in imageViews {
            if tappedImageView.image == instructionImageView.image {
                print("you win")
                tappedImageView.image = #imageLiteral(resourceName: "Coin")
                tappedImageView.alpha = 0.10
            }
        }//this at least taps into the array - now i just need to figure out how to get it so that it doesnt just change the image when it loads. When i click one, it makes all the other matching ones coins as well... dont want that. i need a tapped image varable here to throw the reference into and refer back to.
}//end of matchTapped
    
}//end of LetterMatchingViewController Class
