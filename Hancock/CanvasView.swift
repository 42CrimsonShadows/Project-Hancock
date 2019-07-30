/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The `CanvasView` tracks `UITouch`es and represents them as a series of `Line`s.
 */

import UIKit
import AVFoundation

public var startingPoint = CGPoint()
public var targetPoint = CGPoint()
public var middlePoint1 = CGPoint()
public var middlePoint2 = CGPoint()

class CanvasView: UIView {
    // MARK: Properties
    
    //to determine what line we are one when drawing the letter
    var Line1: Bool = false
    var Line2: Bool = false
    var Line3: Bool = false
    var Line4: Bool = false
    
    var lineColor = UIColor.blue.cgColor
    var checkPointColor = UIColor.darkGray.cgColor
    var dotPointColor = UIColor.black.cgColor
    var defaultColor = UIColor.black.cgColor
    
    //var letterState: LetterState = .AtoB
    var letterState: LetterState = .P1_P2
    
    var letterComplete: Bool = false

    var goodTouch: Bool = false
    var goodLine: Bool = false
    var coin1Collected: Bool = false
    var coin2Collected: Bool = false
    
    //cracked images for letters
    //var A1GreenLine: UIImageView?
    //var A1GreenLine: UIImageView?
    //var A2GreenLine: UIImageView?
    //var A3GreenLine: UIImageView?
    
    //Line #1 dots
    var greenDot: UIImageView?
    var redDot: UIImageView?
    //Line #2 dots
    var blueDot: UIImageView?
    var orangeDot: UIImageView?
    //Line #3 dots
    var purpleDot: UIImageView?
    var yellowDot: UIImageView?
    //Line #4 dots
    var pinkDot: UIImageView?
    var whiteDot: UIImageView?
    //middle dots 1, 2, 3, & 4
    var blackDot1: UIImageView?
    var blackDot2: UIImageView?
    var blackDot3: UIImageView?
    var blackDot4: UIImageView?
    var blackDot5: UIImageView?
    var blackDot6: UIImageView?
    var blackDot7: UIImageView?
    var blackDot8: UIImageView?
    
    var audioPlayer = AVAudioPlayer()
    
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
    
    /// Array containing all line objects that need to be drawn in `drawRect(_:)`.
    private var lines = [Line]()
    
    /// Array containing all line objects that have been completely drawn into the frozenContext.
    private var finishedLines = [Line]()
    
    /**
     Holds a map of `UITouch` objects to `Line` objects whose touch has not ended yet.
     
     Use `NSMapTable` to handle association as `UITouch` doesn't conform to `NSCopying`. There is no value
     in accessing the properties of the touch used as a key in the map table. `UITouch` properties should
     be accessed in `NSResponder` callbacks and methods called from them.
     */
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
    
    /// An optional `CGImage` containing the last representation of lines no longer receiving updates.
    private var frozenImage: CGImage?
    
    // MARK: Drawing
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        setNeedsDisplay()
        context.setLineCap(.round)
        
        //let actViewController = activityViewController()
        
        switch true {
        case Line1:
            //count the points in the array to determine how many lines there will be (4 dots = 1 line...)
            //activityPoints[0][0] is the first item in the group that is the first group in the array
            startingPoint = CGPoint(x: bounds.maxX * activityPoints[0][0], y: bounds.maxY * activityPoints[0][1])
            middlePoint1 = CGPoint(x: bounds.maxX * activityPoints[1][0], y: bounds.maxY * activityPoints[1][1])
            middlePoint2 = CGPoint(x: bounds.maxX * activityPoints[2][0], y: bounds.maxY * activityPoints[2][1])
            targetPoint = CGPoint(x: bounds.maxX * activityPoints[3][0], y: bounds.maxY * activityPoints[3][1])
            
            //show the dots for the first letter
            greenDot?.isHidden = false
            redDot?.isHidden = false
            
            if coin1Collected == false {
                blackDot1?.isHidden = false
            }
            if coin2Collected == false {
                blackDot2?.isHidden = false
            }


        case Line2:
            //count the points in the array to determine how many lines there will be (4 dots = 1 line...)
            let arraySize = activityPoints.count
            blackDot1?.isHidden = true
            blackDot2?.isHidden = true

            if arraySize > 4 {
                startingPoint = CGPoint(x: bounds.maxX * activityPoints[4][0], y: bounds.maxY * activityPoints[4][1])
                middlePoint1 = CGPoint(x: bounds.maxX * activityPoints[5][0], y: bounds.maxY * activityPoints[5][1])
                middlePoint2 = CGPoint(x: bounds.maxX * activityPoints[6][0], y: bounds.maxY * activityPoints[6][1])
                targetPoint = CGPoint(x: bounds.maxX * activityPoints[7][0], y: bounds.maxY * activityPoints[7][1])
                
                //start point and end for the current letter's second line
                greenDot?.isHidden = true
                blueDot?.isHidden = false
                redDot?.isHidden = true
                orangeDot?.isHidden = false
                
                if coin1Collected == false {
                    blackDot3?.isHidden = false
                }
                if coin2Collected == false {
                    blackDot4?.isHidden = false
                }
            }

        case Line3:
            //count the points in the array to determine how many lines there will be (4 dots = 1 line...)
            let arraySize = activityPoints.count
            blackDot3?.isHidden = true
            blackDot4?.isHidden = true
            
            if arraySize > 8 {
                //start point and end for the current letter's third line
                startingPoint = CGPoint(x: bounds.maxX * activityPoints[8][0], y: bounds.maxY * activityPoints[8][1])
                middlePoint1 = CGPoint(x: bounds.maxX * activityPoints[9][0], y: bounds.maxY * activityPoints[11][1])
                middlePoint2 = CGPoint(x: bounds.maxX * activityPoints[10][0], y: bounds.maxY * activityPoints[10][1])
                targetPoint = CGPoint(x: bounds.maxX * activityPoints[11][0], y: bounds.maxY * activityPoints[11][1])
                
                blueDot?.isHidden = true
                purpleDot?.isHidden = false
                orangeDot?.isHidden = true
                yellowDot?.isHidden = false
                
                if coin1Collected == false {
                    blackDot5?.isHidden = false
                }
                if coin2Collected == false {
                    blackDot6?.isHidden = false
                }
            }

        case Line4:
            //count the points in the array to determine how many lines there will be (4 dots = 1 line...)
            let arraySize = activityPoints.count
            blackDot5?.isHidden = true
            blackDot6?.isHidden = true

            if arraySize > 12 {
                startingPoint = CGPoint(x: bounds.maxX * activityPoints[12][0], y: bounds.maxY * activityPoints[12][1])
                middlePoint1 = CGPoint(x: bounds.maxX * activityPoints[13][0], y: bounds.maxY * activityPoints[13][1])
                middlePoint2 = CGPoint(x: bounds.maxX * activityPoints[14][0], y: bounds.maxY * activityPoints[14][1])
                targetPoint = CGPoint(x: bounds.maxX * activityPoints[15][0], y: bounds.maxY * activityPoints[15][1])
                
                purpleDot?.isHidden = true
                pinkDot?.isHidden = false
                yellowDot?.isHidden = true
                whiteDot?.isHidden = false
                
                if coin1Collected == false {
                    blackDot7?.isHidden = false
                }
                if coin2Collected == false {
                    blackDot8?.isHidden = false
                }
            }
        default:
            break
        }
        
        //        if !AtoB {
        //
        //            //make first dot
        //            aStartPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.15)
        //            aEndPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.15)
        //            //context.move(to: aStartPoint)
        //            //context.addLine(to: aEndPoint)
        //            greenDot?.isHidden = false
        //
        //            //make second dot
        //            bStartPoint = CGPoint(x: bounds.maxX * 0.1, y: bounds.maxY * 0.85)
        //            bEndPoint = CGPoint(x: bounds.maxX * 0.1, y: bounds.maxY * 0.85)
        //            //context.move(to: bStartPoint)
        //            //context.addLine(to: bEndPoint)
        //            redDot?.isHidden = false
        //        }
        //        else if AtoB && !AtoC {
        //            //make first dot
        //            self.aStartPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.15)
        //            self.aEndPoint = CGPoint(x: bounds.maxX * 0.5, y: bounds.maxY * 0.15)
        //            //context.move(to: aStartPoint)
        //            //context.addLine(to: aEndPoint)
        //            greenDot?.isHidden = true
        //            blueDot?.isHidden = false
        //
        //            //make second dot
        //            self.cStartPoint = CGPoint(x: bounds.maxX * 0.9, y: bounds.maxY * 0.85)
        //            self.cEndPoint = CGPoint(x: bounds.maxX * 0.9, y: bounds.maxY * 0.85)
        //            //context.move(to: cStartPoint)
        //            //context.addLine(to: cEndPoint)
        //            orangeDot?.isHidden = false
        //            redDot?.isHidden = true
        //        }
        //        else {
        //            self.dStartPoint = CGPoint(x: bounds.maxX * 0.2, y: bounds.maxY * 0.65)
        //            self.dEndPoint = CGPoint(x: bounds.maxX * 0.2, y: bounds.maxY * 0.65)
        //            //context.move(to: dStartPoint)
        //            //context.addLine(to: dEndPoint)
        //            purpleDot?.isHidden = false
        //            blueDot?.isHidden = true
        //
        //            self.eStartPoint = CGPoint(x: bounds.maxX * 0.8, y: bounds.maxY * 0.65)
        //            self.eEndPoint = CGPoint(x: bounds.maxX * 0.8, y: bounds.maxY * 0.65)
        //            //context.move(to: eStartPoint)
        //            //context.addLine(to: eEndPoint)
        //            yellowDot?.isHidden = false
        //            orangeDot?.isHidden = true
        //        }
        
        if needsFullRedraw {
            setFrozenImageNeedsUpdate()
            frozenContext.clear(bounds)
            for array in [finishedLines, lines] {
                for line in array {
                    line.drawCommitedPoints(in: frozenContext, isDebuggingEnabled: isDebuggingEnabled, usePreciseLocation: usePreciseLocations)
                }
            }
            needsFullRedraw = false
        }
        
        frozenImage = frozenImage ?? frozenContext.makeImage()
        
        if let frozenImage = frozenImage {
            context.draw(frozenImage, in: bounds)
        }
        
        for line in lines {
            line.drawInContext(context, isDebuggingEnabled: isDebuggingEnabled, usePreciseLocation: usePreciseLocations)
        }
        context.setStrokeColor(dotPointColor)
        context.setLineCap(.round)
        context.setLineWidth(20)
        
        context.strokePath()
    }
    
    private func setFrozenImageNeedsUpdate() {
        frozenImage = nil
    }
    
    // MARK: Actions
    
    func clear() {
        activeLines.removeAllObjects()
        pendingLines.removeAllObjects()
        lines.removeAll()
        finishedLines.removeAll()
        needsFullRedraw = true
        setNeedsDisplay()
    }
    
    // MARK: Convenience
    
    func drawTouches(_ touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var updateRect = CGRect.null
        
        for touch in touches {
            // Retrieve a line from `activeLines`. If no line exists, create one.
            let line: Line = activeLines.object(forKey: touch) ?? addActiveLineForTouch(touch)
            
            /*
             Remove prior predicted points and update the `updateRect` based on the removals. The touches
             used to create these points are predictions provided to offer additional data. They are stale
             by the time of the next event for this touch.
             */
            updateRect = updateRect.union(line.removePointsWithType(.predicted))
            
            /*
             Incorporate coalesced touch data. The data in the last touch in the returned array will match
             the data of the touch supplied to `coalescedTouchesForTouch(_:)`
             */
            let coalescedTouches = event?.coalescedTouches(for: touch) ?? []
            let coalescedRect = addPointsOfType(.coalesced, for: coalescedTouches, to: line, in: updateRect)
            updateRect = updateRect.union(coalescedRect)
            
            /*
             Incorporate predicted touch data. This sample draws predicted touches differently; however,
             you may want to use them as inputs to smoothing algorithms rather than directly drawing them.
             Points derived from predicted touches should be removed from the line at the next event for
             this touch.
             */
            let predictedTouches = event?.predictedTouches(for: touch) ?? []
            let predictedRect = addPointsOfType(.predicted, for: predictedTouches, to: line, in: updateRect)
            updateRect = updateRect.union(predictedRect)
        }
        
        setNeedsDisplay(updateRect)
    }
    
    private func addActiveLineForTouch(_ touch: UITouch) -> Line {
        let newLine = Line()
        
        activeLines.setObject(newLine, forKey: touch)
        
        lines.append(newLine)
        
        return newLine
    }
    
    private func addPointsOfType(_ type: LinePoint.PointType, for touches: [UITouch], to line: Line, in updateRect: CGRect) -> CGRect {
        var accumulatedRect = CGRect.null
        var type = type
        
        for (idx, touch) in touches.enumerated() {
            let isPencil = touch.type == .pencil
            
            // The visualization displays non-`.pencil` touches differently.
            if !isPencil {
                type.formUnion(.finger)
            }
            
            // Touches with estimated properties require updates; add this information to the `PointType`.
            if !touch.estimatedProperties.isEmpty {
                type.formUnion(.needsUpdate)
            }
            
            // The last touch in a set of `.coalesced` touches is the originating touch. Track it differently.
            if type.contains(.coalesced) && idx == touches.count - 1 {
                type.subtract(.coalesced)
                type.formUnion(.standard)
            }
            
            let touchRect = line.addPointOfType(type, for: touch, in: self)
            accumulatedRect = accumulatedRect.union(touchRect)
            
            commitLine(line)
        }
        
        return updateRect.union(accumulatedRect)
    }
    
    
    func endTouches(_ touches: Set<UITouch>, cancel: Bool) {
        var updateRect = CGRect.null
        goodTouch = false
        guard let lastPoint = touches.first?.location(in: self) else { return }
        
        for touch in touches {
            // Skip over touches that do not correspond to an active line.
            guard let line = activeLines.object(forKey: touch) else { continue }
            
            // If this is a touch cancellation, cancel the associated line.
            if cancel { updateRect = updateRect.union(line.cancel()) }
            
            // If the line is complete (no points needing updates) or updating isn't enabled, move the line to the `frozenImage`.
            if line.isComplete {
                finishLine(line)
            }
                // Otherwise, add the line to our map of touches to lines pending update.
            else {
                pendingLines.setObject(line, forKey: touch)
            }
            
            // This touch is ending, remove the line corresponding to it from `activeLines`.
            activeLines.removeObject(forKey: touch)
        }
        
        if CGPointDistance(from: lastPoint, to: targetPoint) > 50 {
            lines.removeAll()
            needsFullRedraw = true
            setNeedsDisplay()
        }
        else {
            switch letterState {
            case .P1_P2:
                //A1GreenLine?.isHidden = false
                
                playAudioFile(file: "RockBreak1", type: "wav")
                //wait 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playAudioFile(file: "Line5", type: "mp3")
                    
                    //wait 1 second
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.playAudioFile(file: "Line6", type: "mp3")
                        
                        //wait 3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.blueDot?.pulsate(duration: 0.6)
                            
                            //wait 2 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                self.orangeDot?.pulsate(duration: 0.6)
                            })
                        })
                    })
                })
                letterState = .P3_P4
                Line1 = false
                Line2 = true
                Line3 = false
                Line4 = false
                if activityPoints.count < 5 {
                    letterComplete = true
                }
                
            case .P3_P4:
                //A2GreenLine?.isHidden = false
                
                playAudioFile(file: "RockBreak2", type: "aiff")
                //wait 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playAudioFile(file: "Line7", type: "mp3")
                    
                    //wait 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.purpleDot?.pulsate(duration: 0.6)
                        
                        //wait 2 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.yellowDot?.pulsate(duration: 0.6)
                        })
                    })
                })
                letterState = .P5_P6
                Line1 = false
                Line2 = false
                Line3 = true
                Line4 = false
                if activityPoints.count < 9 {
                    letterComplete = true
                }
                
            case .P5_P6:
                //A3GreenLine?.isHidden = false
                
                playAudioFile(file: "RockExplode", type: "wav")
                
                //wait 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playAudioFile(file: "Line8", type: "mp3")
                    self.purpleDot?.isHidden = true
                    self.yellowDot?.isHidden = true
                })
                letterState = .P7_P8
                Line1 = false
                Line2 = false
                Line3 = false
                Line4 = true
                if activityPoints.count < 13 {
                    letterComplete = true
                }
                
            case .P7_P8:
                //A4GreenLine?.isHidden = false
                
                //possible fourth line stuff
                print("reached .P7_P8")
                Line1 = false
                Line2 = false
                Line3 = false
                Line4 = false
                letterComplete = true
            }
        }
    }
    
    func updateEstimatedPropertiesForTouches(_ touches: Set<UITouch>) {
        for touch in touches {
            var isPending = false
            
            // Look to retrieve a line from `activeLines`. If no line exists, look it up in `pendingLines`.
            let possibleLine: Line? = activeLines.object(forKey: touch) ?? {
                let pendingLine = pendingLines.object(forKey: touch)
                isPending = pendingLine != nil
                return pendingLine
                }()
            
            // If no line is related to the touch, return as there is no additional work to do.
            guard let line = possibleLine else { return }
            
            switch line.updateWithTouch(touch) {
            case (true, let updateRect):
                setNeedsDisplay(updateRect)
            default:
                ()
            }
            
            // If this update updated the last point requiring an update, move the line to the `frozenImage`.
            if isPending && line.isComplete {
                finishLine(line)
                pendingLines.removeObject(forKey: touch)
            }
                // Otherwise, have the line add any points no longer requiring updates to the `frozenImage`.
            else {
                commitLine(line)
            }
        }
    }
    
    private func commitLine(_ line: Line) {
        // Have the line draw any segments between points no longer being updated into the `frozenContext` and remove them from the line.
        line.drawFixedPointsInContext(frozenContext, isDebuggingEnabled: isDebuggingEnabled, usePreciseLocation: usePreciseLocations)
        setFrozenImageNeedsUpdate()
    }
    
    private func finishLine(_ line: Line) {
        // Have the line draw any remaining segments into the `frozenContext`. All should be fixed now.
        if goodLine == true {
            line.drawFixedPointsInContext(frozenContext, isDebuggingEnabled: isDebuggingEnabled, usePreciseLocation: usePreciseLocations, commitAll: true)
            setFrozenImageNeedsUpdate()
            
            // Cease tracking this line now that it is finished.
            lines.remove(at: lines.firstIndex(of: line)!)
            
            // Store into finished lines to allow for a full redraw on option changes.
            finishedLines.append(line)
            print("good line")
        } else {
            print("not a good line")
            
            //            for line in lines {
            //                line.cancel()
            //            }
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
    
    //MARK: AUDIO STUFF
    
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
