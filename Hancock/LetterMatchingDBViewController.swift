//
//  LetterMatchingDBViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 7/16/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class LetterMatchingDBViewController: UIViewController, UIGestureRecognizerDelegate {
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
    let letterMatchingArray = [ #imageLiteral(resourceName: "b-.png"), #imageLiteral(resourceName: "d-.png")]
    
    //set up work item for delay
    var workItem1:DispatchWorkItem? = nil
    var workItem2:DispatchWorkItem? = nil
    
    //settingup winning image
    @IBOutlet weak var youWinPic: UIImageView!
    
    //line label - setting it up so that it can be hidden when the game is won
    @IBOutlet weak var lineLabel: UILabel!
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "mainMenu", sender: self)
    }
    @IBAction func resetButtonTapped(_ sender: Any) {
        viewDidLoad()
        let imageViews = [rowOneCardOneImageView, rowOneCardTwoImageView, rowOneCardThreeImageView, rowOneCardFourImageView, rowOneCardFiveImageView, rowTwoCardOneImageView, rowTwoCardTwoImageView, rowTwoCardThreeImageView, rowTwoCardFourImageView, rowTwoCardFiveImageView, rowThreeCardFiveImageVIew, rowThreeCardTwoImageView, rowThreeCardThreeImageView, rowThreeCardFourImageView, rowFiveCardFiveImageView, rowFourCardOneImageView, rowFourCardTwoImageView, rowFourCardThreeImageView, rowFourCardFourImageView, rowFourCardFiveImageView, rowFiveCardOneImageView, rowFiveCardTwoImageView, rowFiveCardThreeImageView, rowFiveCardFourImageView, rowFiveCardFiveImageView, instructionImageView]
               
               
               for imageView in imageViews {
                   imageView?.isHidden = false
               }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youWinPic.isHidden = true
        lineLabel.isHidden = false
        
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
        var winningImage = [UIImage]()
        var winningImageCount = winningImage.count
        var newTempImages = [UIImage]()
        var newTempImagesCount  = newTempImages.count
        
        let imageViews = [rowOneCardOneImageView, rowOneCardTwoImageView, rowOneCardThreeImageView, rowOneCardFourImageView, rowOneCardFiveImageView, rowTwoCardOneImageView, rowTwoCardTwoImageView, rowTwoCardThreeImageView, rowTwoCardFourImageView, rowTwoCardFiveImageView, rowThreeCardOneImageVIew, rowThreeCardTwoImageView, rowThreeCardThreeImageView, rowThreeCardFourImageView, rowThreeCardFiveImageVIew, rowFourCardOneImageView, rowFourCardTwoImageView, rowFourCardThreeImageView, rowFourCardFourImageView, rowFourCardFiveImageView, rowFiveCardOneImageView, rowFiveCardTwoImageView, rowFiveCardThreeImageView, rowFiveCardFourImageView, rowFiveCardFiveImageView]
        
        print(sender.view!)
        print("I have been tapped")
        
        
        for _ in imageViews {
            if tappedImageView.image == instructionImageView.image {
                print("you win")
                tappedImageView.image = #imageLiteral(resourceName: "Coin")
            }
            for _ in imageViews {
                if tappedImageView.image != instructionImageView.image {
                    tappedImageView.alpha = 0.10
                    print ("no")
                    
                    workItem1 = DispatchWorkItem{
                        //play the final narration
                        tappedImageView.alpha = 1.0
                        print("test")
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute:self.workItem1!)
                }
            }
            
            for (index, imageView) in imageViews.enumerated(){
                if tappedImageView.image == instructionImageView.image {
                    winningImage.append(imageView!.image!)
                    
                }
                
                
            }
            
            for (index, imageView) in imageViews.enumerated(){
                if imageView!.image == instructionImageView.image {
                    newTempImages.append(imageView!.image!)
                    print("this works")
                }
            }
            
            if newTempImages.count == winningImage.count {
                print("you win")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.55, execute:self.workItem2!)
            }
            workItem2 = DispatchWorkItem{
                self.youWinPic.isHidden = false
                self.youWinPic.image = #imageLiteral(resourceName: "YouWin.png")
                self.lineLabel.isHidden = true
                
                let imageViews = [self.rowOneCardOneImageView, self.rowOneCardTwoImageView, self.rowOneCardThreeImageView, self.rowOneCardFourImageView, self.rowOneCardFiveImageView, self.rowTwoCardOneImageView, self.rowTwoCardTwoImageView, self.rowTwoCardThreeImageView, self.rowTwoCardFourImageView, self.rowTwoCardFiveImageView, self.rowThreeCardOneImageVIew, self.rowThreeCardTwoImageView, self.rowThreeCardThreeImageView, self.rowThreeCardFourImageView, self.rowThreeCardFiveImageVIew, self.rowFourCardOneImageView, self.rowFourCardTwoImageView, self.rowFourCardThreeImageView, self.rowFourCardFourImageView, self.rowFourCardFiveImageView,self.rowFiveCardOneImageView, self.rowFiveCardTwoImageView, self.rowFiveCardThreeImageView, self.rowFiveCardFourImageView, self.rowFiveCardFiveImageView, self.instructionImageView]
                
                
                for imageView in imageViews {
                    imageView?.isHidden = true
                }
                
            }
        }
        
        
    }//end of matchTapped
    
    
}
