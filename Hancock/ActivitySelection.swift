
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
                        [CGFloat(0.11),CGFloat(0.86)], //second point x, y
            
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
        activityPoints = [[CGFloat(0.23),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.23),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.23),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.23),CGFloat(0.85)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.22),CGFloat(0.12)], //third point x, y... (actually first point again)
                        [CGFloat(0.6),CGFloat(0.15)], //third MidPoint1 x, y
                        [CGFloat(0.6),CGFloat(0.45)], //third MidPoint2 x, y
                        [CGFloat(0.22),CGFloat(0.5)], //fourth point
            
                        //Line #3
                        [CGFloat(0.22),CGFloat(0.5)], //fifth point
                        [CGFloat(0.7),CGFloat(0.55)], //fifth MidPoint1 x, y
                        [CGFloat(0.6),CGFloat(0.84)], //fifth MidPoint2 x, y
                        [CGFloat(0.22),CGFloat(0.85)]] //sixth point
        
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
        
        let UnderlayF = UIImage(named: "art.scnassets/LetterImages/F.png")
        letterUnderlay = UIImageView(image: UnderlayF)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityG() {
        print("Called loadActivityG")
                        //Line #1
        activityPoints = [[CGFloat(0.7),CGFloat(0.15)], //first point x, y
                        [CGFloat(0.17),CGFloat(0.42)], //first MidPoint1 x, y
                        [CGFloat(0.47),CGFloat(0.86)], //first MidPoint2 x, y
                        [CGFloat(0.82),CGFloat(0.5)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.48),CGFloat(0.49)], //fifth point
                        [CGFloat(0.71),CGFloat(0.49)], //fifth MidPoint1 x, y
                        [CGFloat(0.58),CGFloat(0.49)], //fifth MidPoint2 x, y
                        [CGFloat(0.82),CGFloat(0.49)]] //sixth point
        
        let UnderlayG = UIImage(named: "art.scnassets/LetterImages/G.png")
        letterUnderlay = UIImageView(image: UnderlayG)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityH() {
        print("Called loadActivityH")
                        //Line #1
        activityPoints = [[CGFloat(0.22),CGFloat(0.11)], //first point x, y
                        [CGFloat(0.22),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.22),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.22),CGFloat(0.86)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.22),CGFloat(0.49)], //fifth point
                        [CGFloat(0.40),CGFloat(0.49)], //fifth MidPoint1 x, y
                        [CGFloat(0.58),CGFloat(0.49)], //fifth MidPoint2 x, y
                        [CGFloat(0.76),CGFloat(0.49)], //sixth point
            
                        //Line #3
                        [CGFloat(0.76),CGFloat(0.11)], //fifth point
                        [CGFloat(0.76),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.76),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.76),CGFloat(0.86)]] //sixth point
        
        let UnderlayH = UIImage(named: "art.scnassets/LetterImages/H.png")
        letterUnderlay = UIImageView(image: UnderlayH)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityI() {
        print("Called loadActivityI")
                        //Line #1
        activityPoints = [[CGFloat(0.48),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.48),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.48),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.48),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.27),CGFloat(0.12)], //fifth point
                        [CGFloat(0.42),CGFloat(0.12)], //fifth MidPoint1 x, y
                        [CGFloat(0.57),CGFloat(0.12)], //fifth MidPoint2 x, y
                        [CGFloat(0.73),CGFloat(0.12)], //sixth point
                        //Line #3
                        [CGFloat(0.27),CGFloat(0.86)], //fifth point
                        [CGFloat(0.42),CGFloat(0.86)], //fifth MidPoint1 x, y
                        [CGFloat(0.57),CGFloat(0.86)], //fifth MidPoint2 x, y
                        [CGFloat(0.73),CGFloat(0.86)]] //sixth point
        
        let UnderlayI = UIImage(named: "art.scnassets/LetterImages/I.png")
        letterUnderlay = UIImageView(image: UnderlayI)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityJ() {
        print("Called loadActivityJ")
                        //Line #1
        activityPoints = [[CGFloat(0.64),CGFloat(0.11)], //first point x, y
                        [CGFloat(0.66),CGFloat(0.6)], //first MidPoint1 x, y
                        [CGFloat(0.31),CGFloat(0.85)], //first MidPoint2 x, y
                        [CGFloat(0.13),CGFloat(0.52)], //second point x, y
                        //Line #2
                        [CGFloat(0.36),CGFloat(0.12)], //fifth point
                        [CGFloat(0.54),CGFloat(0.12)], //fifth MidPoint1 x, y
                        [CGFloat(0.71),CGFloat(0.12)], //fifth MidPoint2 x, y
                        [CGFloat(0.89),CGFloat(0.12)]] //sixth point
        
        let UnderlayJ = UIImage(named: "art.scnassets/LetterImages/J.png")
        letterUnderlay = UIImageView(image: UnderlayJ)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityK() {
        print("Called loadActivityK")
                        //Line #1
        activityPoints = [[CGFloat(0.25),CGFloat(0.11)], //first point x, y
                        [CGFloat(0.25),CGFloat(0.36)], //first MidPoint1 x, y
                        [CGFloat(0.25),CGFloat(0.61)], //first MidPoint2 x, y
                        [CGFloat(0.25),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.78),CGFloat(0.12)], //fifth point
                        [CGFloat(0.6),CGFloat(0.25)], //fifth MidPoint1 x, y
                        [CGFloat(0.43),CGFloat(0.39)], //fifth MidPoint2 x, y
                        [CGFloat(0.25),CGFloat(0.5)], //sixth point
                        //Line #3
                        [CGFloat(0.25),CGFloat(0.5)], //fifth point
                        [CGFloat(0.43),CGFloat(0.58)], //fifth MidPoint1 x, y
                        [CGFloat(0.62),CGFloat(0.73)], //fifth MidPoint2 x, y
                        [CGFloat(0.8),CGFloat(0.86)]] //sixth point
        
        let UnderlayK = UIImage(named: "art.scnassets/LetterImages/K.png")
        letterUnderlay = UIImageView(image: UnderlayK)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityL() {
        print("Called loadActivityL")
        
                        //Line #1
        activityPoints = [[CGFloat(0.25),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.25),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.25),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.25),CGFloat(0.86)], //second point x, y
            
                        //Line #2
                        [CGFloat(0.25),CGFloat(0.86)], //fifth point
                        [CGFloat(0.43),CGFloat(0.86)], //fifth MidPoint1 x, y
                        [CGFloat(0.6),CGFloat(0.86)], //fifth MidPoint2 x, y
                        [CGFloat(0.78),CGFloat(0.86)]] //sixth point
        
        let UnderlayL = UIImage(named: "art.scnassets/LetterImages/L.png")
        letterUnderlay = UIImageView(image: UnderlayL)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityM() {
        print("Called loadActivityM")
        
                        //Line #1
        activityPoints = [[CGFloat(0.14),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.14),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.14),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.14),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.14),CGFloat(0.11)], //fifth point
                        [CGFloat(0.24),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.37),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.49),CGFloat(0.86)], //sixth point
                        //Line #3
                        [CGFloat(0.49),CGFloat(0.86)], //fifth point
                        [CGFloat(0.61),CGFloat(0.6)], //fifth MidPoint1 x, y
                        [CGFloat(0.75),CGFloat(0.35)], //fifth MidPoint2 x, y
                        [CGFloat(0.87),CGFloat(0.12)], //sixth point
                        //Line #4
                        [CGFloat(0.87),CGFloat(0.12)], //fifth point
                        [CGFloat(0.87),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.87),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.87),CGFloat(0.86)]] //sixth point
        
        let UnderlayM = UIImage(named: "art.scnassets/LetterImages/M.png")
        letterUnderlay = UIImageView(image: UnderlayM)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityN() {
        print("Called loadActivityN")
                        //Line #1
        activityPoints = [[CGFloat(0.21),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.21),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.21),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.21),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.2),CGFloat(0.12)], //fifth point
                        [CGFloat(0.39),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.59),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.79),CGFloat(0.86)], //sixth point
                        //Line #3
                        [CGFloat(0.79),CGFloat(0.12)], //fifth point
                        [CGFloat(0.79),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.79),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.79),CGFloat(0.86)]] //sixth point
        
        let UnderlayN = UIImage(named: "art.scnassets/LetterImages/N.png")
        letterUnderlay = UIImageView(image: UnderlayN)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityO() {
        print("Called loadActivityO")
                        //Line #1
        activityPoints = [[CGFloat(0.49),CGFloat(0.11)], //first point x, y
                        [CGFloat(0.17),CGFloat(0.7)], //first MidPoint1 x, y
                        [CGFloat(0.83),CGFloat(0.7)], //first MidPoint2 x, y
                        [CGFloat(0.52),CGFloat(0.11)]] //second point x, y
        
        let UnderlayO = UIImage(named: "art.scnassets/LetterImages/O.png")
        letterUnderlay = UIImageView(image: UnderlayO)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityP() {
        print("Called loadActivityP")
                        //Line #1
        activityPoints = [[CGFloat(0.28),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.28),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.28),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.28),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.28),CGFloat(0.12)], //fifth point
                        [CGFloat(0.65),CGFloat(0.17)], //fifth MidPoint1 x, y
                        [CGFloat(0.64),CGFloat(0.47)], //fifth MidPoint2 x, y
                        [CGFloat(0.28),CGFloat(0.5)]] //sixth point
        
        let UnderlayP = UIImage(named: "art.scnassets/LetterImages/P.png")
        letterUnderlay = UIImageView(image: UnderlayP)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityQ() {
        print("Called loadActivityQ")
                        //Line #1
        activityPoints = [[CGFloat(0.49),CGFloat(0.11)], //first point x, y
                        [CGFloat(0.17),CGFloat(0.7)], //first MidPoint1 x, y
                        [CGFloat(0.83),CGFloat(0.7)], //first MidPoint2 x, y
                        [CGFloat(0.52),CGFloat(0.11)], //second point x, y
                        //Line #2
                        [CGFloat(0.62),CGFloat(0.71)], //fifth point
                        [CGFloat(0.67),CGFloat(0.76)], //fifth MidPoint1 x, y
                        [CGFloat(0.74),CGFloat(0.84)], //fifth MidPoint2 x, y
                        [CGFloat(0.78),CGFloat(0.88)]] //sixth point
        
        let UnderlayQ = UIImage(named: "art.scnassets/LetterImages/Q.png")
        letterUnderlay = UIImageView(image: UnderlayQ)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityR() {
        print("Called loadActivityR")
                        //Line #1
        activityPoints = [[CGFloat(0.27),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.27),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.27),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.27),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.27),CGFloat(0.12)], //fifth point
                        [CGFloat(0.65),CGFloat(0.17)], //fifth MidPoint1 x, y
                        [CGFloat(0.64),CGFloat(0.47)], //fifth MidPoint2 x, y
                        [CGFloat(0.27),CGFloat(0.5)], //sixth point
                        //Line #3
                        [CGFloat(0.27),CGFloat(0.5)], //fifth point
                        [CGFloat(0.43),CGFloat(0.6)], //fifth MidPoint1 x, y
                        [CGFloat(0.62),CGFloat(0.73)], //fifth MidPoint2 x, y
                        [CGFloat(0.78),CGFloat(0.86)]] //sixth point
        
        let UnderlayR = UIImage(named: "art.scnassets/LetterImages/R.png")
        letterUnderlay = UIImageView(image: UnderlayR)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityS() {
        print("Called loadActivityS")
                        //Line #1
        activityPoints = [[CGFloat(0.73),CGFloat(0.15)], //first point x, y
                        [CGFloat(0.34),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.7),CGFloat(0.8)], //first MidPoint2 x, y
                        [CGFloat(0.23),CGFloat(0.7)]] //second point x, y
        
        let UnderlayS = UIImage(named: "art.scnassets/LetterImages/S.png")
        letterUnderlay = UIImageView(image: UnderlayS)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityT() {
        print("Called loadActivityT")
                        //Line #1
        activityPoints = [[CGFloat(0.5),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.5),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.5),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.5),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.21),CGFloat(0.12)], //fifth point
                        [CGFloat(0.40),CGFloat(0.12)], //fifth MidPoint1 x, y
                        [CGFloat(0.6),CGFloat(0.12)], //fifth MidPoint2 x, y
                        [CGFloat(0.79),CGFloat(0.12)]] //sixth point
        
        let UnderlayT = UIImage(named: "art.scnassets/LetterImages/T.png")
        letterUnderlay = UIImageView(image: UnderlayT)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityU() {
        print("Called loadActivityU")
                        //Line #1
        activityPoints = [[CGFloat(0.12),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.21),CGFloat(0.7)], //first MidPoint1 x, y
                        [CGFloat(0.79),CGFloat(0.7)], //first MidPoint2 x, y
                        [CGFloat(0.87),CGFloat(0.12)]] //second point x, y
        
        let UnderlayU = UIImage(named: "art.scnassets/LetterImages/U.png")
        letterUnderlay = UIImageView(image: UnderlayU)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityV() {
        print("Called loadActivityV")
                        //Line #1
        activityPoints = [[CGFloat(0.14),CGFloat(0.13)], //first point x, y
                        [CGFloat(0.25),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.38),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.505),CGFloat(0.84)], //second point x, y
                        //Line #2
                        [CGFloat(0.505),CGFloat(0.84)], //fifth point
                        [CGFloat(0.63),CGFloat(0.6)], //fifth MidPoint1 x, y
                        [CGFloat(0.75),CGFloat(0.35)], //fifth MidPoint2 x, y
                        [CGFloat(0.855),CGFloat(0.13)]] //sixth point
        
        let UnderlayV = UIImage(named: "art.scnassets/LetterImages/V.png")
        letterUnderlay = UIImageView(image: UnderlayV)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityW() {
        print("Called loadActivityW")
                        //Line #1
        activityPoints = [[CGFloat(0.11),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.16),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.22),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.275),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.275),CGFloat(0.86)], //fifth point
                        [CGFloat(0.35),CGFloat(0.6)], //fifth MidPoint1 x, y
                        [CGFloat(0.44),CGFloat(0.35)], //fifth MidPoint2 x, y
                        [CGFloat(0.495),CGFloat(0.12)], //sixth point
                        //Line #3
                        [CGFloat(0.495),CGFloat(0.12)], //fifth point
                        [CGFloat(0.57),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.65),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.72),CGFloat(0.86)], //sixth point
                        //Line #4
                        [CGFloat(0.72),CGFloat(0.86)], //fifth point
                        [CGFloat(0.78),CGFloat(0.6)], //fifth MidPoint1 x, y
                        [CGFloat(0.84),CGFloat(0.35)], //fifth MidPoint2 x, y
                        [CGFloat(0.89),CGFloat(0.12)]] //sixth point
        
        let UnderlayW = UIImage(named: "art.scnassets/LetterImages/W.png")
        letterUnderlay = UIImageView(image: UnderlayW)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityX() {
        print("Called loadActivityX")
                        //Line #1
        activityPoints = [[CGFloat(0.22),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.4),CGFloat(0.35)], //first MidPoint1 x, y
                        [CGFloat(0.58),CGFloat(0.6)], //first MidPoint2 x, y
                        [CGFloat(0.77),CGFloat(0.86)], //second point x, y
                        //Line #2
                        [CGFloat(0.765),CGFloat(0.12)], //fifth point
                        [CGFloat(0.6),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.42),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.235),CGFloat(0.86)]] //sixth point
 
        let UnderlayX = UIImage(named: "art.scnassets/LetterImages/X.png")
        letterUnderlay = UIImageView(image: UnderlayX)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityY() {
        print("Called loadActivityY")
                        //Line #1
        activityPoints = [[CGFloat(0.16),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.25),CGFloat(0.23)], //first MidPoint1 x, y
                        [CGFloat(0.38),CGFloat(0.33)], //first MidPoint2 x, y
                        [CGFloat(0.52),CGFloat(0.47)], //second point x, y
                        //Line #2
                        [CGFloat(0.84),CGFloat(0.12)], //fifth point
                        [CGFloat(0.65),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.43),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.24),CGFloat(0.86)]] //sixth point
        
        let UnderlayY = UIImage(named: "art.scnassets/LetterImages/Y.png")
        letterUnderlay = UIImageView(image: UnderlayY)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityZ() {
        print("Called loadActivityZ")
                        //Line #1
        activityPoints = [[CGFloat(0.28),CGFloat(0.12)], //first point x, y
                        [CGFloat(0.44),CGFloat(0.12)], //first MidPoint1 x, y
                        [CGFloat(0.59),CGFloat(0.12)], //first MidPoint2 x, y
                        [CGFloat(0.75),CGFloat(0.12)], //second point x, y
                        //Line #2
                        [CGFloat(0.74),CGFloat(0.12)], //fifth point
                        [CGFloat(0.6),CGFloat(0.35)], //fifth MidPoint1 x, y
                        [CGFloat(0.43),CGFloat(0.6)], //fifth MidPoint2 x, y
                        [CGFloat(0.26),CGFloat(0.86)], //sixth point
                        //Line #3
                        [CGFloat(0.26),CGFloat(0.86)], //fifth point
                        [CGFloat(0.42),CGFloat(0.86)], //fifth MidPoint1 x, y
                        [CGFloat(0.59),CGFloat(0.86)], //fifth MidPoint2 x, y
                        [CGFloat(0.73),CGFloat(0.86)]] //sixth point

        let UnderlayZ = UIImage(named: "art.scnassets/LetterImages/Z.png")
        letterUnderlay = UIImageView(image: UnderlayZ)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
}
