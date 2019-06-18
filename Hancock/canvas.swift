//
//  canvas.swift
//  Hancock
//
//  Created by Chris Ross on 6/12/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit
import AVFoundation

class Canvas: UIView {
    
    //MARK: - CANVAS VARIABLES
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 20
    //2 dimensional CGPoint array of lines
    var lines = [Line]()
    var checkpointLines = [Line]()
    var dotPoints = [Line]()
    
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
    
    var audioPlayer = AVAudioPlayer()
    

    
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
            //nextStep()
            goodTouch = false
            
            switch letterState {
            case .AtoB:
                A1GreenLine?.isHidden = false
                playAudioFile(file: "RockBreak1", type: "wav")
                //wait 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playAudioFile(file: "Line5", type: "mp3")
                    
                    //wait 1 second
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.playAudioFile(file: "Line6", type: "mp3")
                    })
                })
                letterState = .AtoC
                AtoB = true
            case .AtoC:
                A2GreenLine?.isHidden = false
                playAudioFile(file: "RockBreak2", type: "aiff")
                //wait 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playAudioFile(file: "Line7", type: "mp3")
                    
                })
                letterState = .DtoE
                AtoC = true
            case .DtoE:
                A3GreenLine?.isHidden = false
                playAudioFile(file: "RockExplode", type: "wav")
                
                //wait 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playAudioFile(file: "Line8", type: "mp3")
                    
                    //wait 2 second
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        //activityViewController().goBack()
                        //activityViewController().dismiss(animated: false, completion: nil)
                        //activityViewController().performSegue(withIdentifier: "Back To Scene", sender: self)
                        
                    })
                })
                DtoE = true
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
    
    func playAudioFile(file: String, type: String) {
        let audioPath = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        
        do
        {
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        } catch {
            print("AudioPlayer not available!")
        }
        
        audioPlayer.play()
    }
}

