//
//  LetterMatchingPGQViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 7/16/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class LetterMatchingPGQViewController: UIViewController, UIGestureRecognizerDelegate {

   //setting up instructionImageView
       @IBOutlet weak var instructionImageView: UIImageView!
       //setting up first row
       @IBOutlet weak var rowOneCardOneImageView: UIImageView!
       @IBOutlet weak var rowOneCardTwoImageView: UIImageView!
       @IBOutlet weak var rowOneCardThreeImageView: UIImageView!
       @IBOutlet weak var rowOneCardFourImageView: UIImageView!
       @IBOutlet weak var rowOneCardFiveImageView: UIImageView!
       //end of row one set up
       //setting up second row
       @IBOutlet weak var rowTwoCardOneImageView: UIImageView!
       @IBOutlet weak var rowTwoCardTwoImageView: UIImageView!
       @IBOutlet weak var rowTwoCardThreeImageView: UIImageView!
       @IBOutlet weak var rowTwoCardFourImageView: UIImageView!
       @IBOutlet weak var rowTwoCardFiveImageView: UIImageView!
       //end of row two set up
       //setting up row three
       @IBOutlet weak var rowThreeCardOneImageVIew: UIImageView!
       @IBOutlet weak var rowThreeCardTwoImageView: UIImageView!
       @IBOutlet weak var rowThreeCardThreeImageView: UIImageView!
       @IBOutlet weak var rowThreeCardFourImageView: UIImageView!
       @IBOutlet weak var rowThreeCardFiveImageVIew: UIImageView!
       //end of row three set up
       //setting up row four
       @IBOutlet weak var rowFourCardOneImageView: UIImageView!
       @IBOutlet weak var rowFourCardTwoImageView: UIImageView!
       @IBOutlet weak var rowFourCardThreeImageView: UIImageView!
       @IBOutlet weak var rowFourCardFourImageView: UIImageView!
       @IBOutlet weak var rowFourCardFiveImageView: UIImageView!
       //end of row four setup
       //setting up row five
       @IBOutlet weak var rowFiveCardOneImageView: UIImageView!
       @IBOutlet weak var rowFiveCardTwoImageView: UIImageView!
       @IBOutlet weak var rowFiveCardThreeImageView: UIImageView!
       @IBOutlet weak var rowFiveCardFourImageView: UIImageView!
       @IBOutlet weak var rowFiveCardFiveImageView: UIImageView!
       //end of row five setup
       //end of image view setup
       
       //tappedImage variable setup
        var tappedImage:UIImage? = nil
       
       //setup image array using image literals
       let letterMatchingArray = [ #imageLiteral(resourceName: "p-"), #imageLiteral(resourceName: "q-"), #imageLiteral(resourceName: "g-")]
       
       @IBAction func backButtonTapped(_ sender: UIButton) {
           performSegue(withIdentifier: "mainMenu", sender: self)
       }
       @IBAction func resetButtonTapped(_ sender: Any) {
           viewDidLoad()
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           instructionImageView.image = letterMatchingArray.randomElement()
           
           let imageViews = [rowOneCardOneImageView, rowOneCardTwoImageView, rowOneCardThreeImageView, rowOneCardFourImageView, rowOneCardFiveImageView, rowTwoCardOneImageView, rowTwoCardTwoImageView, rowTwoCardThreeImageView, rowTwoCardFourImageView, rowTwoCardFiveImageView, rowThreeCardOneImageVIew, rowThreeCardTwoImageView, rowThreeCardThreeImageView, rowThreeCardFourImageView, rowThreeCardFiveImageVIew, rowFourCardOneImageView, rowFourCardTwoImageView, rowFourCardThreeImageView, rowFourCardFourImageView, rowFourCardFiveImageView, rowFiveCardOneImageView, rowFiveCardTwoImageView, rowFiveCardThreeImageView, rowFiveCardFourImageView, rowFiveCardFiveImageView]
           
           for imageView in imageViews {
               imageView?.image = letterMatchingArray.randomElement()
           }
           
           for  imageView in imageViews {
                     // 3
                     let tapGesture = UITapGestureRecognizer(
                         target: self,
                         action: #selector(matchTapped)
                         
                     )
                     
                     // 4
                     tapGesture.delegate = self
                     imageView?.addGestureRecognizer(tapGesture)
                     imageView?.alpha = 1.00
                     
                 }
                 

           // Do any additional setup after loading the view.
       }
       
       @objc func matchTapped(__ sender: UITapGestureRecognizer) {
              
              let tappedImageView = sender.view as! UIImageView
              
               let imageViews = [rowOneCardOneImageView, rowOneCardTwoImageView, rowOneCardThreeImageView, rowOneCardFourImageView, rowOneCardFiveImageView, rowTwoCardOneImageView, rowTwoCardTwoImageView, rowTwoCardThreeImageView, rowTwoCardFourImageView, rowTwoCardFiveImageView, rowThreeCardOneImageVIew, rowThreeCardTwoImageView, rowThreeCardThreeImageView, rowThreeCardFourImageView, rowThreeCardFiveImageVIew, rowFourCardOneImageView, rowFourCardTwoImageView, rowFourCardThreeImageView, rowFourCardFourImageView, rowFourCardFiveImageView, rowFiveCardOneImageView, rowFiveCardTwoImageView, rowFiveCardThreeImageView, rowFiveCardFourImageView, rowFiveCardFiveImageView]
              
              print(sender.view!)
              print("I have been tapped")
              
              
              for _ in imageViews {
                  if tappedImageView.image == instructionImageView.image {
                      print("you win")
                      tappedImageView.image = #imageLiteral(resourceName: "Coin")
                      tappedImageView.alpha = 0.10
                  }
                  for _ in imageViews {
                      if tappedImageView.image != instructionImageView.image {
                       
                      }
                  }
                  
              }
          }//end of matchTapped
       

}
