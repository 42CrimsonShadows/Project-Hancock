//
//  activityViewController.swift
//  Hancock
//
//  Created by Chris Ross on 6/5/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit

// MARK: - Game State

enum LetterState: Int16 {
    case AtoB
    case AtoC
    case DtoE
}

class activityViewController: UIViewController {
    
    // MARK: - VARIABLES
    
    let canvas = Canvas()
    
    let AUnderlayView: UIImageView = {
        let AUnderlay = UIImage(named: "art.scnassets/LetterAImages/AUnderlay.png")
        let AUnderlayView = UIImageView(image: AUnderlay)
        //this enables autolayout for our AUnderlayView
        AUnderlayView.translatesAutoresizingMaskIntoConstraints = false
        return AUnderlayView
    }()
    let A1UnderlayView: UIImageView = {
        //Add the letter A1 image to the canvas
        let A1Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.1.png")
        let A1UnderlayView = UIImageView(image: A1Underlay)
        //this enables autolayout for our AUnderlayView
        A1UnderlayView.translatesAutoresizingMaskIntoConstraints = false
        return A1UnderlayView
    }()
    let A2UnderlayView: UIImageView = {
        //Add the letter A2 image to the canvas
        let A2Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.2.png")
        let A2UnderlayView = UIImageView(image: A2Underlay)
        //this enables autolayout for our A2UnderlayView
        A2UnderlayView.translatesAutoresizingMaskIntoConstraints = false
        return A2UnderlayView
    }()
    let A3UnderlayView: UIImageView = {
        //Add the letter A3 image to the canvas
        let A3Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.3.png")
        let A3UnderlayView = UIImageView(image: A3Underlay)
        //this enables autolayout for our A3UnderlayView
        A3UnderlayView.translatesAutoresizingMaskIntoConstraints = false
        return A3UnderlayView
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
        setupGreenlines()
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
}
