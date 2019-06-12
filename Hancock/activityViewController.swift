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

    
    //MARK: - ACTIONS
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func undoButton(_ sender: Any) {
        canvas.lines.removeAll()
        canvas.checkpointLines.removeAll()
        canvas.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCanvas()
        setupAUnderlay()
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
}



class Canvas: UIView {
    
    //MARK: - CANVAS VARIABLES
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 20
    //2 dimensional CGPoint array of lines
    var lines = [Line]()
    var checkpointLines = [Line]()
    
    var lastTouch = CGPoint.zero
    var aStartPoint = CGPoint()
    var aEndPoint = CGPoint()
    var bStartPoint = CGPoint()
    var bEndPoint = CGPoint()
    var cStartPoint = CGPoint()
    var cEndPoint = CGPoint()
    var dStartPoint = CGPoint()
    var dEndPoint = CGPoint()
    var eStartPoint = CGPoint()
    var eEndPoint = CGPoint()
    var defaultColor = UIColor.blue.cgColor
    var secondColor = UIColor.red.cgColor
    
    var letterState: LetterState = .AtoB
    var currentComplete = false
    var AtoB = false
    var AtoC = false
    var DtoE = false
    
    var startingPoint = CGPoint()
    var targetPoint = CGPoint()
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        //make first dot
        self.aStartPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.15)
        self.aEndPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.15)
        context.move(to: aStartPoint)
        context.addLine(to: aEndPoint)
        
        //make second dot
        self.bStartPoint = CGPoint(x: bounds.maxX * 0.1, y: bounds.maxY * 0.85)
        self.bEndPoint = CGPoint(x: bounds.maxX * 0.1, y: bounds.maxY * 0.85)
        context.move(to: bStartPoint)
        context.addLine(to: bEndPoint)

        //make second dot
        self.cStartPoint = CGPoint(x: bounds.maxX * 0.9, y: bounds.maxY * 0.85)
        self.cEndPoint = CGPoint(x: bounds.maxX * 0.9, y: bounds.maxY * 0.85)
        context.move(to: cStartPoint)
        context.addLine(to: cEndPoint)

        self.dStartPoint = CGPoint(x: bounds.maxX * 0.2, y: bounds.maxY * 0.65)
        self.dEndPoint = CGPoint(x: bounds.maxX * 0.2, y: bounds.maxY * 0.65)
        context.move(to: dStartPoint)
        context.addLine(to: dEndPoint)

        self.eStartPoint = CGPoint(x: bounds.maxX * 0.8, y: bounds.maxY * 0.65)
        self.eEndPoint = CGPoint(x: bounds.maxX * 0.8, y: bounds.maxY * 0.65)
        context.move(to: eStartPoint)
        context.addLine(to: eEndPoint)
        
        
        //draw line
        lines.forEach { (line) in
            context.setStrokeColor(defaultColor)
            context.setLineCap(.round)
            context.setLineWidth(20)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                context.move(to: p)
                } else {
                context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
        checkpointLines.forEach { (line) in
            context.setStrokeColor(secondColor)
            context.setLineCap(.round)
            context.setLineWidth(20)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
        context.setStrokeColor(defaultColor)
        context.setLineCap(.round)
        context.setLineWidth(20)
        
        context.strokePath()
    }
    
    
    //MARK: - TOUCHES
    
    //when figure touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //construct an array of CGpoints and add them to an array of lines
        
        if !AtoB {
            startingPoint = aStartPoint
            targetPoint = bStartPoint
        }
        
        guard let firstPoint = touches.first?.location(in: self) else { return }
        print("touches began")
        
        if CGPointDistance(from: firstPoint, to: startingPoint) < 50 {
            lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
        }
    }
    
    //when finger moves after touches began
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else { return }
        
        //print("Distance to aStartPoint: ", CGPointDistance(from: point, to: startingPoint))
        //test where your mouse is when you hold the mouse button
        //print("Point: ", point)
        
        if !AtoB || !AtoC || !DtoE {
            guard var lastLine = lines.popLast() else { return }
            
            lastLine.points.append(point)
            
            lines.append(lastLine)
            
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches Ended")
        guard let lastPoint = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        
        
        
            if CGPointDistance(from: lastPoint , to: targetPoint) > 50 {
                    lastLine.points.removeAll()
                    setNeedsDisplay()
                print("line not complete")
            }
            else {
                defaultColor = UIColor.green.cgColor
                lastLine.points.append(lastPoint)
                lines.append(lastLine)
                checkpointLines.append(lastLine)
                layer.zPosition = 100
                nextStep()
                setNeedsDisplay()
                print("line complete")
                
                if AtoB {
                    //Add the letter A1 image to the canvas
                    let A1Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.1.png")
                    let A1UnderlayView = UIImageView(image: A1Underlay)
                    A1UnderlayView.frame.size.width = self.frame.size.width
                    A1UnderlayView.frame.size.height = self.frame.size.height
                    
                    //exchangeSubview(at: 0, withSubviewAt: 1)
                    //sendSubviewToBack(A1UnderlayView)
                    //sendSubviewToBack(A1UnderlayView)
                    //insertSubview(A1UnderlayView, at: 10)
                    self.insertSubview(A1UnderlayView, belowSubview: self)
                    
                }
                if  AtoC {
                    
                    //Add the letter A1 image to the canvas
                    let A2Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.2.png")
                    let A2UnderlayView = UIImageView(image: A2Underlay)
                    A2UnderlayView.frame.size.width = self.frame.size.width
                    A2UnderlayView.frame.size.height = self.frame.size.height
                    //addSubview(A2UnderlayView)
                    self.insertSubview(A2UnderlayView, belowSubview: self)
                }
                if  DtoE {
                    
                    //Add the letter A1 image to the canvas
                    let A3Underlay = UIImage(named: "art.scnassets/LetterAImages/ABCGo-A.3.png")
                    let A3UnderlayView = UIImageView(image: A3Underlay)
                    A3UnderlayView.frame.size.width = self.frame.size.width
                    A3UnderlayView.frame.size.height = self.frame.size.height
                    //addSubview(A3UnderlayView)
                    self.insertSubview(A3UnderlayView, belowSubview: self)
                }
            }
    }
    
    
    //MARK: - TOUCH/POINT DISTANCE
    
    func CGPointDistanceSquared(from: CGPoint, to:  CGPoint) -> CGFloat {
        let calcOne = (from.x - to.x) * (from.x - to.x)
        let calcTwo = (from.y - to.y) * (from.y - to.y)
        return (calcOne + calcTwo)
    }
    
    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
    
    //MARK: - LETTERSTATE SWITCH
    
    func nextStep(){

        switch letterState {
        case .AtoB:
            startingPoint = aStartPoint;
            targetPoint = cStartPoint;
            letterState = .AtoC
            self.AtoB = true
        case .AtoC:
            startingPoint = dStartPoint;
            targetPoint = eStartPoint;
            letterState = .DtoE
            self.AtoC = true
        case .DtoE:
            //startingPoint = dStartPoint;
            //targetPoint = eStartPoint;
            //letterState = .AtoB
            self.DtoE = true
        }
        print("letterState is now:", letterState)
    }
}
