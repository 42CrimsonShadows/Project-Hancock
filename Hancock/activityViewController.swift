//
//  activityViewController.swift
//  Hancock
//
//  Created by Chris Ross on 6/5/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - Game State

enum LetterState: Int16 {
    case AtoB
    case AtoC
    case DtoE
}

class activityViewController: UIViewController {
    
    // MARK: - VARIABLES
    
    let canvas = Canvas()
    
    var player1 = AVAudioPlayer()
    
    let AUnderlayView: UIImageView = {
        let AUnderlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A-Underlay_Yellow.png")
        let AUnderlayView = UIImageView(image: AUnderlay)
        //this enables autolayout for our AUnderlayView
        AUnderlayView.translatesAutoresizingMaskIntoConstraints = false
        return AUnderlayView
    }()
    let A1UnderlayView: UIImageView = {
        //Add the letter A1 image to the canvas
        let A1Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.1_Cracks.png")
        let A1UnderlayView = UIImageView(image: A1Underlay)
        //this enables autolayout for our AUnderlayView
        A1UnderlayView.translatesAutoresizingMaskIntoConstraints = false
        return A1UnderlayView
    }()
    let A2UnderlayView: UIImageView = {
        //Add the letter A2 image to the canvas
        let A2Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.2_Cracks.png")
        let A2UnderlayView = UIImageView(image: A2Underlay)
        //this enables autolayout for our A2UnderlayView
        A2UnderlayView.translatesAutoresizingMaskIntoConstraints = false
        return A2UnderlayView
    }()
    let A3UnderlayView: UIImageView = {
        //Add the letter A3 image to the canvas
        let A3Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.3_Cracks.png")
        let A3UnderlayView = UIImageView(image: A3Underlay)
        //this enables autolayout for our A3UnderlayView
        A3UnderlayView.translatesAutoresizingMaskIntoConstraints = false
        return A3UnderlayView
    }()
    let BlueDotView: UIImageView = {
        //Add the Blue Dot image to the canvas
        let BlueDot = UIImage(named: "art.scnassets/DotImages/BlueDot.png")
        let BlueDotView = UIImageView(image: BlueDot)
        //this enables autolayout for our BlueDotView
        BlueDotView.translatesAutoresizingMaskIntoConstraints = false
        return BlueDotView
    }()
    var GreenDotView: UIImageView = {
        //Add the Green Dot image to the canvas
        let GreenDot = UIImage(named: "art.scnassets/DotImages/GreenDot.png")
        let GreenDotView = UIImageView(image: GreenDot)
        //this enables autolayout for our GreenDotView
        GreenDotView.translatesAutoresizingMaskIntoConstraints = false
        return GreenDotView
    }()
    let OrangeDotView: UIImageView = {
        //Add the Orange Dot image to the canvas
        let OrangeDot = UIImage(named: "art.scnassets/DotImages/OrangeDot.png")
        let OrangeDotView = UIImageView(image: OrangeDot)
        //this enables autolayout for our OrangeDotView
        OrangeDotView.translatesAutoresizingMaskIntoConstraints = false
        return OrangeDotView
    }()
    let PurpleDotView: UIImageView = {
        //Add the Purple Dot image to the canvas
        let PurpleDot = UIImage(named: "art.scnassets/DotImages/PurpleDot.png")
        let PurpleDotView = UIImageView(image: PurpleDot)
        //this enables autolayout for our PurpleDotView
        PurpleDotView.translatesAutoresizingMaskIntoConstraints = false
        return PurpleDotView
    }()
    let RedDotView: UIImageView = {
        //Add the Red Dot image to the canvas
        let RedDot = UIImage(named: "art.scnassets/DotImages/RedDot.png")
        let RedDotView = UIImageView(image: RedDot)
        //this enables autolayout for our RedDotView
        RedDotView.translatesAutoresizingMaskIntoConstraints = false
        return RedDotView
    }()
    let YellowDotView: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let YellowDot = UIImage(named: "art.scnassets/DotImages/YellowDot.png")
        let YellowDotView = UIImageView(image: YellowDot)
        //this enables autolayout for our YellowDotView
        YellowDotView.translatesAutoresizingMaskIntoConstraints = false
        return YellowDotView
    }()
    
    //MARK: - ACTIONS
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func undoButton(_ sender: Any) {
        canvas.lines.removeAll()
        canvas.checkpointLines.removeAll()
        canvas.setNeedsDisplay()
    }
    
    //MARK: - VIEWDIDLOAD & SETUP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCanvas()
        setupAUnderlay()
        //these are the lines with cracks
        setupGreenlines()
        setupDotsImages()
        
        //wait one second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.canvas.playAudioFile(file: "Line4", type: "mp3")
        })
        
    }
    
    private func setupCanvas() {
        //Add the drawing canvas to the UIView
        view.addSubview(canvas)
        canvas.backgroundColor = UIColor(white: 0.5, alpha: 0)
        
        //this enables autolayout for our canvas
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        canvas.widthAnchor.constraint(equalToConstant: 600).isActive = true
        canvas.heightAnchor.constraint(equalToConstant: 900).isActive = true
    }
    
    private func setupAUnderlay() {
        //Add the letter A underlay image to the UIView under the canvas
        view.insertSubview(AUnderlayView, belowSubview: canvas)
        AUnderlayView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor).isActive = true
        AUnderlayView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor).isActive = true
        AUnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        AUnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
    }
    
    public func setupGreenlines() {
        //Add the letter A1 green line to the UIView under the canvas
        view.insertSubview(A1UnderlayView, belowSubview: canvas)
        A1UnderlayView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor).isActive = true
        A1UnderlayView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor).isActive = true
        A1UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        A1UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
        A1UnderlayView.isHidden = true
        
        canvas.A1GreenLine = A1UnderlayView
        
        //Add the letter A2 green line to the UIView under the canvas
        view.insertSubview(A2UnderlayView, belowSubview: canvas)
        A2UnderlayView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor).isActive = true
        A2UnderlayView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor).isActive = true
        A2UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        A2UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
        A2UnderlayView.isHidden = true
        
        canvas.A2GreenLine = A2UnderlayView
        
        //Add the letter A3 green line to the UIView under the canvas
        view.insertSubview(A3UnderlayView, belowSubview: canvas)
        A3UnderlayView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor).isActive = true
        A3UnderlayView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor).isActive = true
        A3UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        A3UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
        A3UnderlayView.isHidden = true
        
        canvas.A3GreenLine = A3UnderlayView
    }
    
    public func setupDotsImages() {
        
        //Add the Dot Images to the UIView under the canvas
        view.insertSubview(BlueDotView, belowSubview: canvas)
        BlueDotView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor).isActive = true
        BlueDotView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor, constant: -300).isActive = true
        BlueDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        BlueDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        BlueDotView.isHidden = true
        
        canvas.blueDot = BlueDotView

        view.insertSubview(GreenDotView, belowSubview: canvas)
        GreenDotView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor).isActive = true
        GreenDotView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor, constant: -300).isActive = true
        GreenDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        GreenDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        GreenDotView.isHidden = true
        
        canvas.greenDot = GreenDotView

        view.insertSubview(OrangeDotView, belowSubview: canvas)
        OrangeDotView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor, constant: 225).isActive = true
        OrangeDotView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor, constant: 300).isActive = true
        OrangeDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        OrangeDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        OrangeDotView.isHidden = true
        
        canvas.orangeDot = OrangeDotView

        view.insertSubview(PurpleDotView, belowSubview: canvas)
        PurpleDotView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor, constant: -175).isActive = true
        PurpleDotView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor, constant: 125).isActive = true
        PurpleDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        PurpleDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        PurpleDotView.isHidden = true
        
        canvas.purpleDot = PurpleDotView

        view.insertSubview(RedDotView, belowSubview: canvas)
        RedDotView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor, constant: -225).isActive = true
        RedDotView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor, constant: 300).isActive = true
        RedDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        RedDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        RedDotView.isHidden = true
        
        canvas.redDot = RedDotView
            
        view.insertSubview(YellowDotView, belowSubview: canvas)
        YellowDotView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor, constant: 175).isActive = true
        YellowDotView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor, constant: 125).isActive = true
        YellowDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        YellowDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        YellowDotView.isHidden = true
        
        canvas.yellowDot = YellowDotView
    }
    
//    public func goBack() {
//
//        //dismissItem.dismiss(animated: false, completion: nil)
//        print("Go Back Was Called")
//        //self.performSegue(withIdentifier: "Back To Scene", sender: self)
//        //navigationController?.popToRootViewController(animated: true)
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
//    }
}
