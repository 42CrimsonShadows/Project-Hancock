
import Foundation
import UIKit

public var currentStep = [[CGPoint]]()
public var activityPoints = [[CGFloat(0),CGFloat(0)]]
public var letterUnderlay = UIImageView()

public class ActivitySelection {
   
    public func loadActivityA() {

        print("Called loadActivityA")
        
        //add the A CGpoints that will be used as startingpoint, midPoint1, midPoint2, and target point to an array
        
                        //Line #1
        activityPoints = [[CGFloat(0.5),CGFloat(0.15)], //first point x, y
                        [CGFloat(0.37),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.24),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.1),CGFloat(0.85)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.5),CGFloat(0.15)], //third point x, y... (actually first point again)
                        [CGFloat(0.65),CGFloat(0.35)], //third MidPoint1 x, y
                        [CGFloat(0.78),CGFloat(0.6)], //third MidPoint2 x, y
                        [CGFloat(0.9),CGFloat(0.85)], //fourth point
            
                        //Line #3
                        [CGFloat(0.25),CGFloat(0.585)], //fifth point
                        [CGFloat(0.42),CGFloat(0.585)], //fifth MidPoint1 x, y
                        [CGFloat(0.58),CGFloat(0.585)], //fifth MidPoint2 x, y
                        [CGFloat(0.75),CGFloat(0.585)]] //sixth point
        
        //Green Dot #1
        letterOffset1X = 0
        letterOffset1Y = -300
        //Red Dot #2
        letterOffset2X = -225
        letterOffset2Y = 300
        //Blue Dot #3
        letterOffset3X = 10
        letterOffset3Y = -300
        //Orange Dot #4
        letterOffset4X = 235
        letterOffset4Y = 300
        //Purple Dot #5
        letterOffset5X = -150
        letterOffset5Y = 75
        //Yellow Dot #6
        letterOffset6X = 165
        letterOffset6Y = 75
        //Pink Dot #7
        letterOffset7X = 0
        letterOffset7Y = 0
        //White Dot #8
        letterOffset8X = 0
        letterOffset8Y = 0
        
        //Set the underlay variables
        let UnderlayA = UIImage(named: "art.scnassets/LetterImages/A.png")
        letterUnderlay = UIImageView(image: UnderlayA)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
        
        //TODO: add the sounds to dictionary with a key ["name":"audiofile"]
    }
    public func loadActivityB() {
        print("Called loadActivityB")
        
        //add the B CGpoints that will be used as startingpoint, midPoint1, midPoint2, and target point to an array
        
                        //Line #1
        activityPoints = [[CGFloat(0.2),CGFloat(0.1)], //first point x, y
                        [CGFloat(0.23),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.23),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.23),CGFloat(0.85)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.22),CGFloat(0.1)], //third point x, y... (actually first point again)
                        [CGFloat(0.6),CGFloat(0.15)], //third MidPoint1 x, y
                        [CGFloat(0.6),CGFloat(0.45)], //third MidPoint2 x, y
                        [CGFloat(0.22),CGFloat(0.5)], //fourth point
            
                        //Line #3
                        [CGFloat(0.22),CGFloat(0.5)], //fifth point
                        [CGFloat(0.7),CGFloat(0.55)], //fifth MidPoint1 x, y
                        [CGFloat(0.6),CGFloat(0.84)], //fifth MidPoint2 x, y
                        [CGFloat(0.22),CGFloat(0.85)]] //sixth point
        
        //Green Dot #1
        letterOffset1X = -155
        letterOffset1Y = -350
        //Red Dot #2
        letterOffset2X = -155
        letterOffset2Y = 325
        //Blue Dot #3
        letterOffset3X = -150
        letterOffset3Y = -350
        //Orange Dot #4
        letterOffset4X = -150
        letterOffset4Y = 0
        //Purple Dot #5
        letterOffset5X = -150
        letterOffset5Y = 0
        //Yellow Dot #6
        letterOffset6X = -150
        letterOffset6Y = 325
        //Pink Dot #7
        letterOffset7X = 0
        letterOffset7Y = 0
        //White Dot #8
        letterOffset8X = 0
        letterOffset8Y = 0
        
        let UnderlayB = UIImage(named: "art.scnassets/LetterImages/B.png")
        letterUnderlay = UIImageView(image: UnderlayB)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityC() {
        print("Called loadActivityC")
        
        //add the C CGpoints that will be used as startingpoint, midPoint1, midPoint2, and target point to an array
        
        //Line #1
        activityPoints = [[CGFloat(0.55),CGFloat(0.15)], //first point x, y
                        [CGFloat(0.15),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.3),CGFloat(0.8)], //first MidPoint2 x, y
                        [CGFloat(0.85),CGFloat(0.75)]] //second point x, y
        
        //Dot #1
        letterOffset1X = 25
        letterOffset1Y = -300
        //Dot #2
        letterOffset2X = 200
        letterOffset2Y = 250
        //Dot #3
        letterOffset3X = 0
        letterOffset3Y = 0
        //Dot #4
        letterOffset4X = 0
        letterOffset4Y = 0
        //Dot #5
        letterOffset5X = 0
        letterOffset5Y = 0
        //Dot #6
        letterOffset6X = 0
        letterOffset6Y = 0
        //Dot #7
        letterOffset7X = 0
        letterOffset7Y = 0
        //Dot #8
        letterOffset8X = 0
        letterOffset8Y = 0
        
        let UnderlayC = UIImage(named: "art.scnassets/LetterImages/C.png")
        letterUnderlay = UIImageView(image: UnderlayC)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityD() {
        print("Called loadActivityD")
        
                        //Line #1
        activityPoints = [[CGFloat(0.2),CGFloat(0.1)], //first point x, y
                        [CGFloat(0.2),CGFloat(0.3)], //first MidPoint1 x, y
                        [CGFloat(0.2),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.2),CGFloat(0.85)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.2),CGFloat(0.1)], //fifth point
                        [CGFloat(0.74),CGFloat(0.25)], //fifth MidPoint1 x, y
                        [CGFloat(0.74),CGFloat(0.75)], //fifth MidPoint2 x, y
                        [CGFloat(0.2),CGFloat(0.85)]] //sixth point
        
        //Green Dot #1
        letterOffset1X = -175
        letterOffset1Y = -350
        //Red Dot #2
        letterOffset2X = -175
        letterOffset2Y = 325
        //Blue Dot #3
        letterOffset3X = -175
        letterOffset3Y = -350
        //Orange Dot #4
        letterOffset4X = -175
        letterOffset4Y = 325
        //Purple Dot #5
        letterOffset5X = 0
        letterOffset5Y = 0
        //Yellow Dot #6
        letterOffset6X = 0
        letterOffset6Y = 0
        //Pink Dot #7
        letterOffset7X = 0
        letterOffset7Y = 0
        //White Dot #8
        letterOffset8X = 0
        letterOffset8Y = 0
        
        let UnderlayD = UIImage(named: "art.scnassets/LetterImages/D.png")
        letterUnderlay = UIImageView(image: UnderlayD)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityE() {
        print("Called loadActivityE")
        
                        //Line #1
        activityPoints = [[CGFloat(0.27),CGFloat(0.15)], //first point x, y
                        [CGFloat(0.27),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.27),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.27),CGFloat(0.9)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.27),CGFloat(0.11)], //fifth point
                        [CGFloat(0.41),CGFloat(0.11)], //fifth MidPoint1 x, y
                        [CGFloat(0.51),CGFloat(0.11)], //fifth MidPoint2 x, y
                        [CGFloat(0.65),CGFloat(0.11)], //sixth point
        
                        //Line #3
                        [CGFloat(0.27),CGFloat(0.5)], //fifth point
                        [CGFloat(0.38),CGFloat(0.5)], //fifth MidPoint1 x, y
                        [CGFloat(0.48),CGFloat(0.5)], //fifth MidPoint2 x, y
                        [CGFloat(0.55),CGFloat(0.5)], //sixth point
        
                        //Line #4
                        [CGFloat(0.27),CGFloat(0.86)], //fifth point
                        [CGFloat(0.42),CGFloat(0.86)], //fifth MidPoint1 x, y
                        [CGFloat(0.52),CGFloat(0.86)], //fifth MidPoint2 x, y
                        [CGFloat(0.65),CGFloat(0.86)]] //sixth point
        
        //Green Dot #1
        letterOffset1X = -140
        letterOffset1Y = -350
        //Red Dot #2
        letterOffset2X = -140
        letterOffset2Y = 325
        //Blue Dot #3
        letterOffset3X = -140
        letterOffset3Y = -350
        //OrangeDot #4
        letterOffset4X = 75
        letterOffset4Y = -350
        //Purple Dot #5
        letterOffset5X = -140
        letterOffset5Y = 0
        //Yellow Dot #6
        letterOffset6X = 50
        letterOffset6Y = 0
        //Pink Dot #7
        letterOffset7X = -140
        letterOffset7Y = 325
        //White Dot #8
        letterOffset8X = 100
        letterOffset8Y = 325
        
        let UnderlayE = UIImage(named: "art.scnassets/LetterImages/E.png")
        letterUnderlay = UIImageView(image: UnderlayE)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityF() {
        print("Called loadActivityF")
        
                        //Line #1
        activityPoints = [[CGFloat(0.27),CGFloat(0.15)], //first point x, y
                        [CGFloat(0.27),CGFloat(0.3)], //first MidPoint1 x, y
                        [CGFloat(0.27),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.27),CGFloat(0.85)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.27),CGFloat(0.11)], //fifth point
                        [CGFloat(0.41),CGFloat(0.11)], //fifth MidPoint1 x, y
                        [CGFloat(0.51),CGFloat(0.11)], //fifth MidPoint2 x, y
                        [CGFloat(0.65),CGFloat(0.11)], //sixth point
        
                        //Line #3
                        [CGFloat(0.27),CGFloat(0.5)], //fifth point
                        [CGFloat(0.38),CGFloat(0.5)], //fifth MidPoint1 x, y
                        [CGFloat(0.48),CGFloat(0.5)], //fifth MidPoint2 x, y
                        [CGFloat(0.6),CGFloat(0.5)]] //sixth point
        
        //Green Dot #1
        letterOffset1X = -140
        letterOffset1Y = -350
        //Red Dot #2
        letterOffset2X = -140
        letterOffset2Y = 325
        //Blue Dot #3
        letterOffset3X = -140
        letterOffset3Y = -350
        //Orange Dot #4
        letterOffset4X = 75
        letterOffset4Y = -350
        //Purple Dot #5
        letterOffset5X = -140
        letterOffset5Y = 0
        //Yellow Dot #6
        letterOffset6X = 50
        letterOffset6Y = 0
        //Pink Dot #7
        letterOffset7X = 0
        letterOffset7Y = 0
        //White Dot #8
        letterOffset8X = 0
        letterOffset8Y = 0
        
        let UnderlayF = UIImage(named: "art.scnassets/LetterImages/F.png")
        letterUnderlay = UIImageView(image: UnderlayF)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityG() {
        print("Called loadActivityG")
        
        
        
        let UnderlayG = UIImage(named: "art.scnassets/LetterImages/G.png")
        letterUnderlay = UIImageView(image: UnderlayG)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityH() {
        print("Called loadActivityH")
        
        
        
        let UnderlayH = UIImage(named: "art.scnassets/LetterImages/H.png")
        letterUnderlay = UIImageView(image: UnderlayH)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityI() {
        print("Called loadActivityI")
        
        
        
        let UnderlayI = UIImage(named: "art.scnassets/LetterImages/I.png")
        letterUnderlay = UIImageView(image: UnderlayI)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityJ() {
        print("Called loadActivityJ")
        
        
        
        let UnderlayJ = UIImage(named: "art.scnassets/LetterImages/J.png")
        letterUnderlay = UIImageView(image: UnderlayJ)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityK() {
        print("Called loadActivityK")
        
        
        
        let UnderlayK = UIImage(named: "art.scnassets/LetterImages/K.png")
        letterUnderlay = UIImageView(image: UnderlayK)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityL() {
        print("Called loadActivityL")
        
        
        
        let UnderlayL = UIImage(named: "art.scnassets/LetterImages/L.png")
        letterUnderlay = UIImageView(image: UnderlayL)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityM() {
        print("Called loadActivityM")
        
        
        
        let UnderlayM = UIImage(named: "art.scnassets/LetterImages/M.png")
        letterUnderlay = UIImageView(image: UnderlayM)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityN() {
        print("Called loadActivityN")
        
        
        
        let UnderlayN = UIImage(named: "art.scnassets/LetterImages/N.png")
        letterUnderlay = UIImageView(image: UnderlayN)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityO() {
        print("Called loadActivityO")
        
        
        
        let UnderlayO = UIImage(named: "art.scnassets/LetterImages/O.png")
        letterUnderlay = UIImageView(image: UnderlayO)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityP() {
        print("Called loadActivityP")
        
        
        
        let UnderlayP = UIImage(named: "art.scnassets/LetterImages/P.png")
        letterUnderlay = UIImageView(image: UnderlayP)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityQ() {
        print("Called loadActivityQ")
        
        
        
        let UnderlayQ = UIImage(named: "art.scnassets/LetterImages/Q.png")
        letterUnderlay = UIImageView(image: UnderlayQ)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityR() {
        print("Called loadActivityR")
        
        
        
        let UnderlayR = UIImage(named: "art.scnassets/LetterImages/R.png")
        letterUnderlay = UIImageView(image: UnderlayR)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityS() {
        print("Called loadActivityS")
        
        
        
        let UnderlayS = UIImage(named: "art.scnassets/LetterImages/S.png")
        letterUnderlay = UIImageView(image: UnderlayS)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityT() {
        print("Called loadActivityT")
        
        
        
        let UnderlayT = UIImage(named: "art.scnassets/LetterImages/T.png")
        letterUnderlay = UIImageView(image: UnderlayT)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityU() {
        print("Called loadActivityU")
        
        
        
        let UnderlayU = UIImage(named: "art.scnassets/LetterImages/U.png")
        letterUnderlay = UIImageView(image: UnderlayU)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityV() {
        print("Called loadActivityV")
        
        
        
        let UnderlayV = UIImage(named: "art.scnassets/LetterImages/V.png")
        letterUnderlay = UIImageView(image: UnderlayV)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityW() {
        print("Called loadActivityW")
        
        
        
        let UnderlayW = UIImage(named: "art.scnassets/LetterImages/W.png")
        letterUnderlay = UIImageView(image: UnderlayW)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityX() {
        print("Called loadActivityX")
        
        
        
        
        let UnderlayX = UIImage(named: "art.scnassets/LetterImages/X.png")
        letterUnderlay = UIImageView(image: UnderlayX)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityY() {
        print("Called loadActivityY")
        
        
        
        let UnderlayY = UIImage(named: "art.scnassets/LetterImages/Y.png")
        letterUnderlay = UIImageView(image: UnderlayY)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityZ() {
        print("Called loadActivityZ")
        
        
        
        let UnderlayZ = UIImage(named: "art.scnassets/LetterImages/Z.png")
        letterUnderlay = UIImageView(image: UnderlayZ)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
}
