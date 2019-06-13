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
    private var useDebugDrawing = false
    
    private let reticleView: ReticleView = {
        let view = ReticleView(frame: CGRect.null)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        return view
    }()
    
    @IBOutlet private weak var canvasView: Canvas!
    @IBOutlet private weak var debugButton: UIButton!
    
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var forceLabel: UILabel!
    @IBOutlet private weak var azimuthAngleLabel: UILabel!
    @IBOutlet private weak var azimuthUnitVectorLabel: UILabel!
    @IBOutlet private weak var altitudeAngleLabel: UILabel!
    
    /// An IBOutlet Collection with all of the labels for touch values.
    @IBOutlet private var gagueLabelCollection: [UILabel]!
    
    
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
        canvas.addSubview(reticleView)
        //toggleDebugDrawing(sender: debugButton)
        //clearGagues()
        
        if #available(iOS 12.1, *) {
            let pencilInteraction = UIPencilInteraction()
            pencilInteraction.delegate = self
            view.addInteraction(pencilInteraction)
        }
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvas.drawTouches(touches, withEvent: event)

        touches.forEach { (touch) in
            //updateGagues(with: touch)

            if useDebugDrawing, touch.type == .pencil {
                reticleView.isHidden = false
                updateReticleView(with: touch)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvas.drawTouches(touches, withEvent: event)

        touches.forEach { (touch) in
            //updateGagues(with: touch)

            if useDebugDrawing, touch.type == .pencil {
                updateReticleView(with: touch)

                // Use the last predicted touch to update the reticle.
                guard let predictedTouch = event?.predictedTouches(for: touch)?.last else { return }

                updateReticleView(with: predictedTouch, isPredicted: true)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvas.drawTouches(touches, withEvent: event)
        canvas.endTouches(touches, cancel: false)

        touches.forEach { (touch) in
            //clearGagues()

            if useDebugDrawing, touch.type == .pencil {
                reticleView.isHidden = true
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvas.endTouches(touches, cancel: true)

        touches.forEach { (touch) in
            //clearGagues()

            if useDebugDrawing, touch.type == .pencil {
                reticleView.isHidden = true
            }
        }
    }
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        canvas.updateEstimatedPropertiesForTouches(touches)
    }
    
     //MARK: Actions
    
    @IBAction private func clearView(sender: Any) {
        canvas.clear()
    }

    @IBAction private func toggleDebugDrawing(sender: UIButton) {
        canvas.isDebuggingEnabled = !canvasView.isDebuggingEnabled
        useDebugDrawing.toggle()
        sender.isSelected = canvas.isDebuggingEnabled
    }

    @IBAction private func toggleUsePreciseLocations(sender: UIButton) {
        canvas.usePreciseLocations = !canvasView.usePreciseLocations
        sender.isSelected = canvasView.usePreciseLocations
    }

    // MARK: Convenience

    /// Gather the properties on a `UITouch` for force, altitude, azimuth and location.
    /// - Tag: PencilProperties
    private func updateReticleView(with touch: UITouch, isPredicted: Bool = false) {
        guard touch.type == .pencil else { return }

        reticleView.predictedDotLayer.isHidden = !isPredicted
        reticleView.predictedLineLayer.isHidden = !isPredicted

        let azimuthAngle = touch.azimuthAngle(in: canvas)
        let azimuthUnitVector = touch.azimuthUnitVector(in: canvas)
        let altitudeAngle = touch.altitudeAngle

        if isPredicted {
            reticleView.predictedAzimuthAngle = azimuthAngle
            reticleView.predictedAzimuthUnitVector = azimuthUnitVector
            reticleView.predictedAltitudeAngle = altitudeAngle
        } else {
            let location = touch.preciseLocation(in: canvasView)
            reticleView.center = location
            reticleView.actualAzimuthAngle = azimuthAngle
            reticleView.actualAzimuthUnitVector = azimuthUnitVector
            reticleView.actualAltitudeAngle = altitudeAngle
        }
    }

    private func updateGagues(with touch: UITouch) {
        forceLabel.text = touch.force.valueFormattedForDisplay ?? ""

        let azimuthUnitVector = touch.azimuthUnitVector(in: canvasView)
        azimuthUnitVectorLabel.text = azimuthUnitVector.valueFormattedForDisplay ?? ""

        let azimuthAngle = touch.azimuthAngle(in: canvasView)
        azimuthAngleLabel.text = azimuthAngle.valueFormattedForDisplay ?? ""

        // When using a finger, the angle is Pi/2 (1.571), representing a touch perpendicular to the device surface.
        altitudeAngleLabel.text = touch.altitudeAngle.valueFormattedForDisplay ?? ""

        let location = touch.preciseLocation(in: canvasView)
        locationLabel.text = location.valueFormattedForDisplay ?? ""
    }

//    private func clearGagues() {
//        gagueLabelCollection.forEach { (label) in
//            label.text = ""
//        }
//    }

    /// A view controller extension that implements pencil interactions.
    /// - Tag: PencilInteraction
    @available(iOS 12.1, *)
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        guard UIPencilInteraction.preferredTapAction == .switchPrevious else { return }

        /* The tap interaction is a quick way for the user to switch tools within an app.
         Toggling the debug drawing mode from Apple Pencil is a discoverable action, as the button
         for debug mode is on screen and visually changes to indicate what the tap interaction did.
         */
        toggleDebugDrawing(sender: debugButton)
    }
}
