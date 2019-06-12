//
//  canvas.swift
//  Hancock
//
//  Created by Chris Ross on 6/12/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    //MARK: - CANVAS VARIABLES
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 20
    //2 dimensional CGPoint array of lines
    
    var usePreciseLocations = false {
        didSet {
            needsFullRedraw = true
            setNeedsDisplay()
        }
    }
    var isDebuggingEnabled = false {
        didSet {
            needsFullRedraw = true
            setNeedsDisplay()
        }
    }
    
    private var needsFullRedraw = true
    var lines = [Line]()
    var checkpointLines = [Line]()
    var dotPoints = [Line]()
    
      private let activeLines: NSMapTable<UITouch, Line> = NSMapTable.strongToStrongObjects()
    /**
     Holds a map of `UITouch` objects to `Line` objects whose touch has ended but still has points awaiting
     updates.
     
     Use `NSMapTable` to handle association as `UITouch` doesn't conform to `NSCopying`. There is no value
     in accessing the properties of the touch used as a key in the map table. `UITouch` properties should
     be accessed in `NSResponder` callbacks and methods called from them.
     */
    private let pendingLines: NSMapTable<UITouch, Line> = NSMapTable.strongToStrongObjects()
    
    /// A `CGContext` for drawing the last representation of lines no longer receiving updates into.
    private lazy var frozenContext: CGContext = {
        let scale = self.window!.screen.scale
        var size = self.bounds.size
        
        size.width *= scale
        size.height *= scale
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context: CGContext = CGContext(data: nil,
                                           width: Int(size.width),
                                           height: Int(size.height),
                                           bitsPerComponent: 8,
                                           bytesPerRow: 0,
                                           space: colorSpace,
                                           bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        context.setLineCap(.round)
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        context.concatenate(transform)
        
        return context
    }()
     private var frozenImage: CGImage?
    
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
    var lineColor = UIColor.blue.cgColor
    var checkPointColor = UIColor.darkGray.cgColor
    var dotPointColor = UIColor.green.cgColor
    var defaultColor = UIColor.black.cgColor
    
    var letterState: LetterState = .AtoB
    var currentComplete = false
    var AtoB = false
    var AtoC = false
    var DtoE = false
    
    var startingPoint = CGPoint()
    var targetPoint = CGPoint()
    
    var A1GreenLine: UIImageView?
    var A2GreenLine: UIImageView?
    var A3GreenLine: UIImageView?
    
    var goodTouch: Bool = false
    
    
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if !AtoB {
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
        }
        else if AtoB && !AtoC {
            //make first dot
            self.aStartPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.15)
            self.aEndPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.15)
            context.move(to: aStartPoint)
            context.addLine(to: aEndPoint)
            
            //make second dot
            self.cStartPoint = CGPoint(x: bounds.maxX * 0.9, y: bounds.maxY * 0.85)
            self.cEndPoint = CGPoint(x: bounds.maxX * 0.9, y: bounds.maxY * 0.85)
            context.move(to: cStartPoint)
            context.addLine(to: cEndPoint)
        }
        else {
            self.dStartPoint = CGPoint(x: bounds.maxX * 0.2, y: bounds.maxY * 0.65)
            self.dEndPoint = CGPoint(x: bounds.maxX * 0.2, y: bounds.maxY * 0.65)
            context.move(to: dStartPoint)
            context.addLine(to: dEndPoint)
            
            self.eStartPoint = CGPoint(x: bounds.maxX * 0.8, y: bounds.maxY * 0.65)
            self.eEndPoint = CGPoint(x: bounds.maxX * 0.8, y: bounds.maxY * 0.65)
            context.move(to: eStartPoint)
            context.addLine(to: eEndPoint)
        }
        
        //draw line
        lines.forEach { (line) in
            context.setStrokeColor(lineColor)
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
            context.setStrokeColor(checkPointColor)
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
        
        context.setStrokeColor(dotPointColor)
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
        if AtoB {
            startingPoint = aStartPoint
            targetPoint = cStartPoint
        }
        if AtoC {
            startingPoint = dStartPoint
            targetPoint = eStartPoint
        }
        
        guard let firstPoint = touches.first?.location(in: self) else { return }
        print("touches began")
        
        print("Startpoint= ", startingPoint)
        print("Targetpoint= ", targetPoint)
        print("AtoB=", AtoB)
        print("AtoC=", AtoC)
        print("DtoE=", DtoE)
        
        if CGPointDistance(from: firstPoint, to: startingPoint) < 50 {
            lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
            goodTouch = true
        }
    }
    
    //when finger moves after touches began
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else { return }
        
        //print("Distance to aStartPoint: ", CGPointDistance(from: point, to: startingPoint))
        //test where your mouse is when you hold the mouse button
        //print("Point: ", point)
        
        if goodTouch {
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
            //setNeedsDisplay()
            print("line not complete")
        }
        else {
            defaultColor = UIColor.green.cgColor
            lastLine.points.append(lastPoint)
            lines.append(lastLine)
            checkpointLines.append(lastLine)
            goodTouch = false
            nextStep()
            //setNeedsDisplay()
            print("line complete")
            
            if AtoB {
                A1GreenLine?.isHidden = false
            }
            if  AtoC {
                A2GreenLine?.isHidden = false
            }
            if  DtoE {
                A3GreenLine?.isHidden = false
            }
        }
        setNeedsDisplay()
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
            print("letterstate put target point at", targetPoint)
            letterState = .AtoC
            AtoB = true
        case .AtoC:
            startingPoint = dStartPoint;
            targetPoint = eStartPoint;
            letterState = .DtoE
            AtoC = true
        case .DtoE:
            //startingPoint = aStartPoint;
            //targetPoint = bStartPoint;
            //letterState = .DtoE
            DtoE = true
        }
        print("letterState is now:", letterState)
    }
}

