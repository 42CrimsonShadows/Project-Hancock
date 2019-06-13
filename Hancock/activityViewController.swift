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

class activityViewController: UIViewController, UIPencilInteractionDelegate {
    
    // MARK: - VARIABLES
    
    //let canvas = Canvas()
    
    private var useDebugDrawing = false
    
    private let reticleView: ReticleView = {
        let view = ReticleView(frame: CGRect.null)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        return view
    }()
    
    //New properties
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var debugButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forceLabel: UILabel!
    @IBOutlet weak var azimuthAngleLabel: UILabel!
    @IBOutlet weak var azimuthUnitVectorLabel: UILabel!
    @IBOutlet weak var altitudeAngleLabel: UILabel!
    
    @IBOutlet private var gagueLabelCollection: [UILabel]!
    
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
//    @IBAction func undoButton(_ sender: Any) {
//        canvasView.lines.removeAll()
//        canvasView.checkpointLines.removeAll()
//        canvasView.setNeedsDisplay()
//    }
    
    //MARK: - VIEWDIDLOAD & SETUP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.addSubview(reticalView)
        
        toggleDebugDrawing(sender: debugButton)
        clearGuages()
        
        if #available(iOS 12.1, *) {
            let pencilInteraction = UIPencilInteraction()
            pencilInteraction.delegate = self
            view.addInteraction(pencilInteraction)
        }
        
        //setupCanvas()
        setupAUnderlay()
        setupGreenlines()
        
    }
    
    //MARK: -- Changes 1
//    private func setupCanvas() {
//        //Add the drawing canvas to the UIView
//        view.addSubview(canvas)
//        canvas.backgroundColor = UIColor(white: 0.5, alpha: 0)
//
//        //this enables autolayout for our canvas
//        canvas.translatesAutoresizingMaskIntoConstraints = false
//        canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        canvas.widthAnchor.constraint(equalToConstant: 600).isActive = true
//        canvas.heightAnchor.constraint(equalToConstant: 900).isActive = true
//    }
    
    private func setupAUnderlay() {
        //Add the letter A underlay image to the UIView under the canvas
        view.insertSubview(AUnderlayView, belowSubview: canvasView)
        AUnderlayView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        AUnderlayView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
        AUnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        AUnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
    }
    public func setupGreenlines() {
        //Add the letter A1 green line to the UIView under the canvas
        view.insertSubview(A1UnderlayView, belowSubview: canvasView)
        A1UnderlayView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        A1UnderlayView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
        A1UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        A1UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
        A1UnderlayView.isHidden = true
        
        canvasView.A1GreenLine = A1UnderlayView
        
        //Add the letter A2 green line to the UIView under the canvas
        view.insertSubview(A2UnderlayView, belowSubview: canvasView)
        A2UnderlayView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        A2UnderlayView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
        A2UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        A2UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
        A2UnderlayView.isHidden = true
        
        canvasView.A2GreenLine = A2UnderlayView
        
        //Add the letter A3 green line to the UIView under the canvas
        view.insertSubview(A3UnderlayView, belowSubview: canvasView)
        A3UnderlayView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        A3UnderlayView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
        A3UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        A3UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
        A3UnderlayView.isHidden = true
        
        canvasView.A3GreenLine = A3UnderlayView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvasView.drawTouches(touches, withEvent: event)
        
        touches.forEach { (touch) in updateGagues(with: touch)
            
            if useDebugDrawing, touch.type == .pencil {
                reticleView.isHidden = false
                updateReticleView(with: touch)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvasView.drawTouches(touches, withEvent: event)
        
        touches.forEach { (touch) in
            updateGagues(with: touch)
            
            if useDebugDrawing, touch.type == .pencil {
                updateReticleView(with: touch)
                
                guard let predictedTouch = event?.predictedTouches(for: touch)?.last else { return }
                
                updateReticleView(with: predictedTouch, isPredicted: true)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvasView.drawTouches(touches, withEvent: event)
        canvasView.endTouches(touches, cancel: false)
        
        touches.forEach { (touch) in
            clearGagues()
            
            if useDebugDrawing, touch.type == .pencil {
                reticleView.isHidden = true
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { (touch) in
            clearGagues()
            
            if useDebugDrawing, touch.type == .pencil {
                reticleView.isHidden = true
            }
        }
    }
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        canvasView.updateEstimatedPropertiesForTouches(touches)
    }
    
    //MARK: Actions
    
    @IBAction func clearView(_ sender: Any) {
        canvasView.clear()
    }
    
    @IBAction func toggleDebugDrawing(_ sender: UIButton) {
        canvasView.isDebuggingEnabled = !canvasView.isDebuggingEnabled
        useDebugDrawing.toggle()
        sender.isSelected = canvasView.isDebuggingEnabled
    }
    
    @IBAction func toggleUsePreciseLocations(_ sender: UIButton) {
        canvasView.usePreciseLocations = !canvasView.usePreciseLocations
        sender.isSelected = canvasView.usePreciseLocations
    }
    
    //MARK: Convenience
    
    
    
    
    
    
    
}
