//
//  AssessmentSelection.swift
//  Hancock
//
//  Created by Lauren  Matthews on 8/17/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//


// Puzzle 0 : 6 pieces
// Puzzle 1 : 6 pieces
// Puzzle 2 : 5 pieces
// Puzzle 3 : 5 pieces
// Puzzle 4 : 4 pieces


import UIKit
import Foundation
import ARKit


//setting up variables
var assessmentArray: [UIImage]?


class AssessmentSelection: UIViewController {
    
    //setting up image Views
    @IBOutlet weak var cardOne: UIImageView!
    @IBOutlet weak var cardTwo: UIImageView!
    @IBOutlet weak var cardThree: UIImageView!
    @IBOutlet weak var cardFour: UIImageView!
    @IBOutlet weak var cardFive: UIImageView!
    @IBOutlet weak var cardSix: UIImageView!
    @IBOutlet weak var instructionCard: UIImageView!
    @IBOutlet weak var puzzleImageView: UIImageView!
    
    
    // for puzzle mask
    let cutOutPercent: CGFloat = 100/720
    private var radius: CGFloat?
    let maskPath = UIBezierPath()
    let shapemask = CAShapeLayer()
    var puzzleNum: Int?
    private var puzzlePieces = [6,6,5,5,4]
    private var puzzlePiecesShown : [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let letterArray = [  #imageLiteral(resourceName: "I") , #imageLiteral(resourceName: "T"), #imageLiteral(resourceName: "L") , #imageLiteral(resourceName: "E") , #imageLiteral(resourceName: "F") , #imageLiteral(resourceName: "H")]
        let UIImages = [cardOne, cardTwo, cardThree, cardFour, cardFive, cardSix]
        instructionCard.image = letterArray.randomElement()
        
        for UIImage in UIImages {
            UIImage?.image = letterArray.randomElement()
        }
        
        // Do any additional setup after loading the view.
        
        // puzzle mask setup
        print(puzzleImageView.bounds.size) // should be 648.0 x 864.0 important for the mask to work
        radius = puzzleImageView.bounds.size.width * cutOutPercent
        shapemask.frame = puzzleImageView.bounds
        shapemask.masksToBounds = true
        puzzleNum = 1
        
        createPieceMask(puzzle: puzzleNum!, piece: pieceToCreate())
        createPieceMask(puzzle: puzzleNum!, piece: pieceToCreate())
        createPieceMask(puzzle: puzzleNum!, piece: pieceToCreate())
//        createPieceMask(puzzle: puzzleNum!, piece: pieceToCreate())
//        createPieceMask(puzzle: puzzleNum!, piece: pieceToCreate())
//        createPieceMask(puzzle: puzzleNum!, piece: pieceToCreate())
    }
    
    // MARK: - CreatePiece Switch
    private func createPieceMask(puzzle:Int, piece:Int) {
        print("Asked to create piece \(piece) of puzzle \(puzzle)")
        var curve = UIBezierPath()
        
        switch puzzle {
            case 0:
                switch piece {
                    case 1:
                        curve = createPuzzle0Piece1()
                    case 2:
                        curve = createPuzzle0Piece2()
                    case 3:
                        curve = createPuzzle0Piece3()
                    case 4:
                        curve = createPuzzle0Piece4()
                    case 5:
                        curve = createPuzzle0Piece5()
                    case 6:
                        curve = createPuzzle0Piece6()
                    default:
                        print("Invalid Piece Index: \(piece)")
                        return
                }
            case 1:
                switch piece {
                    case 1:
                        curve = createPuzzle1Piece1()
                    case 2:
                        curve = createPuzzle1Piece2()
                    case 3:
                        curve = createPuzzle1Piece3()
                    case 4:
                        curve = createPuzzle1Piece4()
                    case 5:
                        curve = createPuzzle1Piece5()
                    case 6:
                        curve = createPuzzle1Piece6()
                    default:
                        print("Invalid Piece Index: \(piece)")
                        return
            }
            default:
                print("Invalid Puzzle Index: \(puzzle)")
                return
        }
        
        // add new piece to mask
        maskPath.append(curve)
        shapemask.path = maskPath.cgPath
        // add mask to image view
        puzzleImageView.layer.mask = shapemask
        // add shown piece to array (for randomization loop)
        puzzlePiecesShown.append(piece)
    }
    
    // MARK: - Puzzle0
    private func createPuzzle0Piece1() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 1")
        // -- COL 1 ROW 1
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: 0, y: 0))
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: 0))
        // E female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: (3 * .pi)/2, endAngle: .pi/2, clockwise: false)
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
        // S male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: 0, endAngle: .pi, clockwise: true)
        // to SW
        curve.addLine(to: CGPoint(x: 0, y:  puzzleImageView.bounds.size.height/3))
        // to NW
        curve.addLine(to: CGPoint(x: 0, y: 0))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle0Piece2() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 2")
        // -- COL 2 ROW 1
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: 0))
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: 0))
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height/3))
        // S female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width - puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: 0, endAngle: .pi, clockwise: false)
        // to SW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y:  puzzleImageView.bounds.size.height/3))
        // W male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: .pi/2, endAngle: (3 * .pi)/2, clockwise: true)
        // to NW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: 0))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle0Piece3() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 3")
        // -- COL 1 ROW 2
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: 0, y: puzzleImageView.bounds.size.height/3))
        // N female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: .pi, endAngle: 0, clockwise: false)
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/1.5))
        // to SW
        curve.addLine(to: CGPoint(x: 0, y:  puzzleImageView.bounds.size.height/1.5))
        // to NW
        curve.addLine(to: CGPoint(x: 0, y: puzzleImageView.bounds.size.height/3))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle0Piece4() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 4")
        // -- COL 2 ROW 2
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
        // N male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width - puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: .pi, endAngle: 0, clockwise: true)
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height/3))
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height/1.5))
        // to SW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y:  puzzleImageView.bounds.size.height/1.5))
        // to NW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle0Piece5() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 5")
        // -- COL 1 ROW 3
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: 0, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // E male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: (3 * .pi)/2, endAngle: .pi/2, clockwise: true)
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height))
        // to SW
        curve.addLine(to: CGPoint(x: 0, y:  puzzleImageView.bounds.size.height))
        // to NW
        curve.addLine(to: CGPoint(x: 0, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle0Piece6() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 6")
        // -- COL 2 ROW 3
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height))
        // to SW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y:  puzzleImageView.bounds.size.height))
        // W female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: .pi/2, endAngle: (3 * .pi)/2, clockwise: false)
        // to NW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // close shape
        curve.close()
        return curve
    }
    
    // MARK: - Puzzle1
    private func createPuzzle1Piece1() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 1")
        // -- COL 1 ROW 1
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: 0, y: 0))
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: 0))
        // E male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: (3 * .pi)/2, endAngle: .pi/2, clockwise: true)
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
        // S male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: 0, endAngle: .pi, clockwise: true)
        // to SW
        curve.addLine(to: CGPoint(x: 0, y:  puzzleImageView.bounds.size.height/3))
        // to NW
        curve.addLine(to: CGPoint(x: 0, y: 0))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle1Piece2() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 2")
        // -- COL 2 ROW 1
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: 0))
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: 0))
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height/3))
        // S female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width - puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: 0, endAngle: .pi, clockwise: false)
        // to SW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y:  puzzleImageView.bounds.size.height/3))
        // W female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: .pi/2, endAngle: (3 * .pi)/2, clockwise: false)
        // to NW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: 0))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle1Piece3() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 3")
        // -- COL 1 ROW 2
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: 0, y: puzzleImageView.bounds.size.height/3))
        // N female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: .pi, endAngle: 0, clockwise: false)
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
        // E female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/2), radius: radius!, startAngle: (3 * .pi)/2, endAngle: .pi/2, clockwise: false)
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/1.5))
        // S female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: 0, endAngle: .pi, clockwise: false)
        // to SW
        curve.addLine(to: CGPoint(x: 0, y:  puzzleImageView.bounds.size.height/1.5))
        // to NW
        curve.addLine(to: CGPoint(x: 0, y: puzzleImageView.bounds.size.height/3))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle1Piece4() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 4")
        // -- COL 2 ROW 2
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
        // N male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width - puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: .pi, endAngle: 0, clockwise: true)
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height/3))
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height/1.5))
        // S female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width - puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: 0, endAngle: .pi, clockwise: false)
        // to SW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y:  puzzleImageView.bounds.size.height/1.5))
        // W male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/2), radius: radius!, startAngle: .pi/2, endAngle: (3 * .pi)/2, clockwise: true)
        // to NW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle1Piece5() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 5")
        // -- COL 1 ROW 3
        
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: 0, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // N male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: .pi, endAngle: 0, clockwise: true)
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // E male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: (3 * .pi)/2, endAngle: .pi/2, clockwise: true)
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height))
        // to SW
        curve.addLine(to: CGPoint(x: 0, y:  puzzleImageView.bounds.size.height))
        // to NW
        curve.addLine(to: CGPoint(x: 0, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // close shape
        curve.close()
        return curve
    }
    
    private func createPuzzle1Piece6() -> UIBezierPath {
        print("Creating Puzzle 0 Piece 6")
        // -- COL 2 ROW 3
        let curve = UIBezierPath()
        // point NW
        curve.move(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // N male connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width - puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: .pi, endAngle: 0, clockwise: true)
        // to NE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // to SE
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width, y: puzzleImageView.bounds.size.height))
        // to SW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y:  puzzleImageView.bounds.size.height))
        // W female connector
        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: .pi/2, endAngle: (3 * .pi)/2, clockwise: false)
        // to NW
        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height - puzzleImageView.bounds.size.height/3))
        // close shape
        curve.close()
        return curve
    }
    
    // MARK: - Puzzle Helper Functions
    // create a random piece of the puzzle
    private func pieceToCreate() -> Int {
        // if the whole puzzle is shown return 0 ( it will hit the default in the switch in createPieceMask
        if(puzzlePiecesShown.count == puzzlePieces[puzzleNum!]) {
            return 0
        }
        // get random number from 1 through however many pieces are in the puzzle
        var num = Int.random(in: 1...puzzlePieces[puzzleNum!])
        // if the piece is already shown pick a new number
        while(puzzlePiecesShown.contains(num))
        {
            num = Int.random(in: 1...puzzlePieces[puzzleNum!])
        }
        return num
    }
    
    
}//end of class







// MARK: - Puzzle Piece Template
//        // BASE
//        let curve = UIBezierPath()
//        // point NW
//        curve.move(to: CGPoint(x: 0, y: 0))
//        // to NE
//        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: 0))
//        // to SE
//        curve.addLine(to: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/3))
//        // to SW
//        curve.addLine(to: CGPoint(x: 0, y:  puzzleImageView.bounds.size.height/3))
//        // to NW
//        curve.addLine(to: CGPoint(x: 0, y: 0))
//         // close shape
//        curve.close()
//
//        // CONNECTORS
//        // N male connector
//        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: 0), radius: radius!, startAngle: .pi, endAngle: 0, clockwise: true)
//        // N female connector
//        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: 0), radius: radius!, startAngle: .pi, endAngle: 0, clockwise: false)
//
//        // E male connector
//        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: (3 * .pi)/2, endAngle: .pi/2, clockwise: true)
//        // E female connector
//        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/2, y: puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: (3 * .pi)/2, endAngle: .pi/2, clockwise: false)
//
//        // S male connector
//        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: 0, endAngle: .pi, clockwise: true)
//        // S female connector
//        curve.addArc(withCenter: CGPoint(x: puzzleImageView.bounds.size.width/4, y: puzzleImageView.bounds.size.height/3), radius: radius!, startAngle: 0, endAngle: .pi, clockwise: false)
//
//        // W male connector
//        curve.addArc(withCenter: CGPoint(x: 0, y: puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: .pi/2, endAngle: (3 * .pi)/2, clockwise: true)
//        // W female connector
//        curve.addArc(withCenter: CGPoint(x: 0, y: puzzleImageView.bounds.size.height/6), radius: radius!, startAngle: .pi/2, endAngle: (3 * .pi)/2, clockwise: false)
