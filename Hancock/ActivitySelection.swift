
import Foundation
import UIKit

public var currentStep = [[CGPoint]]()
public var activityPoints = [[CGFloat(0),CGFloat(0)]]
public var letterUnderlay = UIImageView()

public class ActivitySelection {
   
    public func loadActivityA() {
        //MARK: -- Questions
            // How to we make a system to change steps modularly?
        print("Called loadActivityA")
        //add the A CGpoints that will be used as startingpoint and target point to an array
        activityPoints = [[CGFloat(0.5),CGFloat(0.15)], //first point x, y
                          [CGFloat(0.1),CGFloat(0.85)], //second point x, y
                          [CGFloat(0.5),CGFloat(0.15)], //third point x, y... (actually first point again)
                          [CGFloat(0.9),CGFloat(0.85)], //fourth point
                          [CGFloat(0.2),CGFloat(0.65)], //fifth point
                          [CGFloat(0.8),CGFloat(0.65)]] //sixth point
        
        //print("The activity has points at: ", activityPoints)
        
        //Set the underlay variables
        let UnderlayA = UIImage(named: "art.scnassets/LetterImages/A.png")
        letterUnderlay = UIImageView(image: UnderlayA)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
        
        //add the sounds to dictionary with a key ["name":"audiofile"]
    }
    public func loadActivityB() {
        print("Called loadActivityB")
        let UnderlayB = UIImage(named: "art.scnassets/LetterImages/B.png")
        letterUnderlay = UIImageView(image: UnderlayB)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityC() {
        print("Called loadActivityC")
        let UnderlayC = UIImage(named: "art.scnassets/LetterImages/C.png")
        letterUnderlay = UIImageView(image: UnderlayC)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityD() {
        print("Called loadActivityD")
        let UnderlayD = UIImage(named: "art.scnassets/LetterImages/D.png")
        letterUnderlay = UIImageView(image: UnderlayD)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityE() {
        print("Called loadActivityE")
        let UnderlayE = UIImage(named: "art.scnassets/LetterImages/E.png")
        letterUnderlay = UIImageView(image: UnderlayE)
        //this enables autolayout for our letter1UnderlayView
        letterUnderlay.translatesAutoresizingMaskIntoConstraints = false
    }
    public func loadActivityF() {
        print("Called loadActivityF")
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
