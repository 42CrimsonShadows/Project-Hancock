//
//  LetterMatchingPGQViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 9/6/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class LetterMatchingPGQViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var rowOneLabelOne: UILabel!
    @IBOutlet weak var rowOneLabelTwo: UILabel!
    @IBOutlet weak var rowOneLabelThree: UILabel!
    @IBOutlet weak var rowOneLabelFour: UILabel!
    @IBOutlet weak var rowOneLabelFive: UILabel!
    
    @IBOutlet weak var rowTwoLabelOne: UILabel!
    @IBOutlet weak var rowTwoLabelTwo: UILabel!
    @IBOutlet weak var rowTwoLabelThree: UILabel!
    @IBOutlet weak var rowTwoLabelFour: UILabel!
    @IBOutlet weak var rowTwoLabelFive: UILabel!
    
    @IBOutlet weak var rowThreeLabelOne: UILabel!
    @IBOutlet weak var rowThreeLabelTwo: UILabel!
    @IBOutlet weak var rowThreeLabelThree: UILabel!
    @IBOutlet weak var rowThreeLabelFour: UILabel!
    @IBOutlet weak var rowThreeLabelFive: UILabel!
    
    @IBOutlet weak var rowFourLabelOne: UILabel!
    @IBOutlet weak var rowFourLabelTwo: UILabel!
    @IBOutlet weak var rowFourLabelThree: UILabel!
    @IBOutlet weak var rowFourLabelFour: UILabel!
    @IBOutlet weak var rowFourLabelFive: UILabel!
    
    @IBOutlet weak var rowFiveLabelOne: UILabel!
    @IBOutlet weak var rowFiveLabelTwo: UILabel!
    @IBOutlet weak var rowFiveLabelThree: UILabel!
    @IBOutlet weak var rowFiveLabelFour: UILabel!
    @IBOutlet weak var rowFiveLabelFive: UILabel!
    
    //setting up imageViews
    @IBOutlet weak var topBorder: UIImageView!
    @IBOutlet weak var youWinPic: UIImageView!
    
    //setting up workItem
    var workItem1:DispatchWorkItem? = nil
    
    //Setting up outlets for buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    //setting up score
    var tapArray =  [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lock rotation
        AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
        youWinPic.isHidden = true
        
        let letterMatchingArray = [ "p",  "g", "q"]
        
        instructionLabel.text = letterMatchingArray.randomElement()
        instructionLabel.font = UIFont(name: "Chalkboard SE", size: 120)
        instructionLabel.textColor = UIColor.white
        
        let labelArray = [rowOneLabelOne, rowOneLabelTwo, rowOneLabelThree, rowOneLabelFour, rowOneLabelFive, rowTwoLabelOne, rowTwoLabelTwo, rowTwoLabelThree, rowTwoLabelFour, rowTwoLabelFive, rowThreeLabelOne, rowThreeLabelTwo, rowThreeLabelThree, rowThreeLabelFour, rowThreeLabelFive, rowFourLabelOne, rowFourLabelTwo, rowFourLabelThree, rowFourLabelFour, rowFourLabelFive, rowFiveLabelOne, rowFiveLabelTwo, rowFiveLabelThree, rowFiveLabelFour, rowFiveLabelFive]
        
        //setting up a temporary array to ensure that there are at least three of each match in the game.
        for (_, UILabel) in labelArray.enumerated(){
            UILabel?.isHidden = false
        }
        
        
        for (_, UILabel) in labelArray.enumerated(){
            UILabel?.text = letterMatchingArray.randomElement()
            UILabel?.font = UIFont(name: "Chalkboard SE", size: 115)
            UILabel?.textColor = UIColor(red: 70/255.0, green: 125/255.0, blue: 126, alpha: 1.0)
            
        }
        
        
        for  UILabel in labelArray {
            // 3
            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(matchTapped)
                
            )
            
            // 4
            tapGesture.delegate = self
            UILabel?.addGestureRecognizer(tapGesture)
            UILabel?.alpha = 1.00
            
        }
        
        // Do any additional setup after loading the view.
    }//end of viewDidLoad
    
    @objc func matchTapped(  __ sender: UITapGestureRecognizer ){
        
        //setting up two arrays to compare for winning conditions
        let tappedLabel = sender.view as! UILabel
        
        //redeclaring labelArray to use for winning conditions
        let labelArray = [rowOneLabelOne, rowOneLabelTwo, rowOneLabelThree, rowOneLabelFour, rowOneLabelFive, rowTwoLabelOne, rowTwoLabelTwo, rowTwoLabelThree, rowTwoLabelFour, rowTwoLabelFive, rowThreeLabelOne, rowThreeLabelTwo, rowThreeLabelThree, rowThreeLabelFour, rowThreeLabelFive, rowFourLabelOne, rowFourLabelTwo, rowFourLabelThree, rowFourLabelFour, rowFourLabelFive, rowFiveLabelOne, rowFiveLabelTwo, rowFiveLabelThree, rowFiveLabelFour, rowFiveLabelFive]
        
        var tempLabelArray = [UILabel]()
        
        //what happens when a letter is tapped
        if tappedLabel.text == instructionLabel.text {
            print("Correct")
            tappedLabel.text = "🥇"
        }
        else {
            print("wrong")
            tappedLabel.alpha = 0.5
            workItem1 = DispatchWorkItem{
                tappedLabel.alpha = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute:self.workItem1!)
        }
        
        //code to add matches to arrays to check for winning conditions
        for (_, UILabel) in labelArray.enumerated(){
            if UILabel!.text == instructionLabel.text{
                tempLabelArray.append(UILabel!)
            }
        }
        
        print(tempLabelArray.count)
        
        if tappedLabel.text == instructionLabel.text {
            tapArray.append(tappedLabel.text!)
            
        }
        
        
        if tempLabelArray.count == tapArray.count {
            print("You win")
            for (_, UILabel) in labelArray.enumerated(){
                UILabel?.isHidden = true
                workItem1 = DispatchWorkItem {
                    self.youWinPic.isHidden = false
                    self.topBorder.isHidden = true
                    self.instructionLabel.isHidden = true
                    print("made it here")
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: self.workItem1!)
            
            }
            
        }//end of matchedTapped
        
        //backButton
        @IBAction func backButtonTapped(_ sender: UIButton) {
            performSegue(withIdentifier: "letterMatchingMenu", sender: self)
        }//end of backButtonTapped
        
        //reset Button
        @IBAction func resetButtonTapped(_ sender: Any) {
            viewDidLoad()
            topBorder.isHidden = false
            instructionLabel.isHidden = false
        }//end of resetButtonTapped
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed
//        AppDelegate.AppUtility.lockOrientation(.all)
    }
        
}//end of class


