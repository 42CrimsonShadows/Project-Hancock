//
//  activityViewController.swift
//  Hancock
//
//  Created by Chris Ross on 6/5/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit

class activityViewController: UIViewController {
    
     let canvas = Canvas()

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.backgroundColor = .gray
        canvas.frame = CGRect(x: 200, y: 200, width: view.frame.size.width * 0.5, height: view.frame.size.height * 0.75)
       
    }

}

class Canvas: UIView {
    
    //2 dimensional CGPoint array of lines
    var lines = [[CGPoint]]()
    
    var lastTouch = CGPoint.zero
    var firstStartPoint = CGPoint()
    var firstEndPoint = CGPoint()
    var secondStartPoint = CGPoint()
    var secondEndPoint = CGPoint()
    var defaultColor = UIColor.blue.cgColor
    
    
    
    
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
       
        self.firstStartPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.25)
        self.firstEndPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.25)
        context.move(to: firstStartPoint)
        context.addLine(to: firstEndPoint)
        
        self.secondStartPoint = CGPoint(x: bounds.maxX * 0.25, y: bounds.maxY * 0.75)
        self.secondEndPoint = CGPoint(x: bounds.maxX * 0.25, y: bounds.maxY * 0.75)
        context.move(to: secondStartPoint)
        context.addLine(to: secondEndPoint)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
      
        
        context.setStrokeColor(defaultColor)
        context.setLineCap(.round)
        context.setLineWidth(20)
        
        //actually paints the line on the context
        context.strokePath()
    }
    
    
    
    
    //when figure touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //construct an array of CGpoints and add them to an array of lines
        
        guard let firstPoint = touches.first?.location(in: self) else { return }
        print("touches began")
        
        if CGPointDistance(from: firstPoint, to: firstStartPoint) < 50 {
            lines.append([CGPoint]())
        }
        
        
    }
    
    
    
    //when finger moves after touches began
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else { return }
        
        
        //MARK: -- Starting line
        print("Distance to firstStartPoint: ", CGPointDistance(from: point, to: firstStartPoint))
        
        
        
        //test where your mouse is when you hold the mouse button
        print("Point: ", point)
        
        guard var lastLine = lines.popLast() else { return }
        
        lastLine.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches Ended")
        guard let lastPoint = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        
        if CGPointDistance(from: lastPoint, to: secondStartPoint) > 50 {
            lines.removeAll()
            setNeedsDisplay()
        } else{
            defaultColor = UIColor.green.cgColor
            lastLine.append(lastPoint)
            lines.append(lastLine)
            setNeedsDisplay()          
        }
    }
    
    func CGPointDistanceSquared(from: CGPoint, to:  CGPoint) -> CGFloat {
        let calcOne = (from.x - to.x) * (from.x - to.x)
        let calcTwo = (from.y - to.y) * (from.y - to.y)
        return (calcOne + calcTwo)
    }
    
    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
}

