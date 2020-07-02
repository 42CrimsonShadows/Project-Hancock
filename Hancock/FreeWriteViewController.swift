//
//  FreeWriteViewController.swift
//  Hancock
//
//  Created by Jasmine Young on 7/1/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class FreeWriteViewController: UIViewController {
    
    // MARK: - Variables
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var writingView: UIView!
    @IBOutlet weak var backgroundIV: UIImageView!
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var paperTypeBtn1: UIButton!
    @IBOutlet weak var paperTypeBtn2: UIButton!
    @IBOutlet weak var paperTypeBtn3: UIButton!
    @IBOutlet weak var paperScaleBtn1: UIButton!
    @IBOutlet weak var paperScaleBtn2: UIButton!
    @IBOutlet weak var paperScaleBtn3: UIButton!
    @IBOutlet weak var penScaleBtn1: UIButton!
    @IBOutlet weak var penScaleBtn2: UIButton!
    @IBOutlet weak var penScaleBtn3: UIButton!
    @IBOutlet weak var penScaleBtn4: UIButton!
    
        
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // make button corners rounded
        doneBtn.layer.cornerRadius = 10
        paperTypeBtn1.layer.borderWidth = 3
        paperScaleBtn1.layer.borderWidth = 3
        penScaleBtn2.layer.borderWidth = 3

        
        // Canvas setup
        canvasView.backgroundColor = UIColor(white: 0.5, alpha: 0)
        //this enables autolayout for our canvas
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        writingView.heightAnchor.constraint(lessThanOrEqualToConstant: 1000).isActive = true
        writingView.widthAnchor.constraint(greaterThanOrEqualToConstant: 1000)
        // added to stop line clearing after finger/pencil lifts
        canvasView.freeDraw = true
        
        //Add the letter A underlay image to the UIView under the canvas
//        view.insertSubview(pageUnderlay, belowSubview: canvasView)
//        pageUnderlay.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
//        pageUnderlay.widthAnchor.constraint(equalToConstant: 1000).isActive = true
//        pageUnderlay.heightAnchor.constraint(equalToConstant: 1050).isActive = true
    }
    
    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard (touches.first?.location(in: canvasView)) != nil else { return }
        canvasView.drawTouches(touches, withEvent: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard (touches.first?.location(in: canvasView)) != nil else { return }
        canvasView.drawTouches(touches, withEvent: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard (touches.first?.location(in: canvasView)) != nil else { return }
        canvasView.drawTouches(touches, withEvent: event)
        canvasView.goodLine = true // stops the line width from changing the end of each line regardless of line's line width
        canvasView.endTouches(touches, cancel: false)
    }
    
    // MARK: - Actions
    @IBAction func changePaperPressed(_ sender: UIButton) {
        // if(sender.currentImage == #imageLiteral(resourceName: "UpperCase_Temp"))
        if(sender.currentTitle == "Paper1") {
            // change background image
            paperTypeBtn1.layer.borderWidth = 3
            paperTypeBtn2.layer.borderWidth = 0
            paperTypeBtn3.layer.borderWidth = 0
            backgroundIV.image = UIImage(named: "art.scnassets/UI-art/AntFace.png")
        }
        else if (sender.currentTitle == "Paper2") {
            paperTypeBtn1.layer.borderWidth = 0
            paperTypeBtn2.layer.borderWidth = 3
            paperTypeBtn3.layer.borderWidth = 0
            backgroundIV.image = UIImage(named: "art.scnassets/UI-art/PlayBtn.png")
        }
        else if (sender.currentTitle == "Paper3") {
            backgroundIV.image = UIImage(named: "art.scnassets/UI-art/Book Cover Image Upper.png")
            paperTypeBtn1.layer.borderWidth = 0
            paperTypeBtn2.layer.borderWidth = 0
            paperTypeBtn3.layer.borderWidth = 3
        }
        else {
            print("No Paper Button Title Match: \(sender.currentTitle)")
            backgroundIV.image = nil
        }
    }
    
    @IBAction func lineScalePressed(_ sender: UIButton) {
        // if(sender.currentImage == #imageLiteral(resourceName: "UpperCase_Temp"))
        if(sender.currentTitle == "Scale1") {
            // change background image
            paperScaleBtn1.layer.borderWidth = 3
            paperScaleBtn2.layer.borderWidth = 0
            paperScaleBtn3.layer.borderWidth = 0
            backgroundIV.image = UIImage(named: "art.scnassets/UI-art/AntFace.png")
        }
        else if (sender.currentTitle == "Scale2") {
            paperScaleBtn1.layer.borderWidth = 0
            paperScaleBtn2.layer.borderWidth = 3
            paperScaleBtn3.layer.borderWidth = 0
            backgroundIV.image = UIImage(named: "art.scnassets/UI-art/PlayBtn.png")
        }
        else if (sender.currentTitle == "Scale3") {
            paperScaleBtn1.layer.borderWidth = 0
            paperScaleBtn2.layer.borderWidth = 0
            paperScaleBtn3.layer.borderWidth = 3
            backgroundIV.image = UIImage(named: "art.scnassets/UI-art/Book Cover Image Upper.png")
        }
        else {
            print("No Scale Button Title Match: \(sender.currentTitle)")
            backgroundIV.image = nil
            canvasView.backgroundColor = UIColor.systemGray
        }
    }
    
    @IBAction func penLinePressed(_ sender: UIButton) {
        // if(sender.currentImage == #imageLiteral(resourceName: "UpperCase_Temp"))
        if(sender.currentTitle == "Pen1") {
            penScaleBtn1.layer.borderWidth = 3
            penScaleBtn2.layer.borderWidth = 0
            penScaleBtn3.layer.borderWidth = 0
            penScaleBtn4.layer.borderWidth = 0
            canvasView.lineWidth = 10
        }
        else if (sender.currentTitle == "Pen2") {
            penScaleBtn1.layer.borderWidth = 0
            penScaleBtn2.layer.borderWidth = 3
            penScaleBtn3.layer.borderWidth = 0
            penScaleBtn4.layer.borderWidth = 0
            canvasView.lineWidth = 20
        }
        else if (sender.currentTitle == "Pen3") {
            penScaleBtn1.layer.borderWidth = 0
            penScaleBtn2.layer.borderWidth = 0
            penScaleBtn3.layer.borderWidth = 3
            penScaleBtn4.layer.borderWidth = 0
            canvasView.lineWidth = 30
        }
        else if (sender.currentTitle == "Pen4") {
            penScaleBtn1.layer.borderWidth = 0
            penScaleBtn2.layer.borderWidth = 0
            penScaleBtn3.layer.borderWidth = 0
            penScaleBtn4.layer.borderWidth = 3
            canvasView.lineWidth = 40
        }
        else {
            print("No Pen Button Title Match: \(sender.currentTitle)")
            canvasView.lineWidth = 20
        }
    }
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        // done with writing so send data return to menu selection
        // TODO: Send data to backend
        // this is a screenshot of the canvas view
        if let image = screenShot() {
            if let pngData = image.pngData() {
                // but we could also try a base64EncodedString
    //                let base64String = pngData.base64EncodedString()
                print("Did screenshot Free Write and this is the pngData: \(pngData)")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute:{
            self.dismiss(animated: false, completion: nil)
        })
    }

    @IBAction func clearPagePressed(_ sender: UIButton) {
        canvasView.clear()
    }
    
    // MARK: - Utilities
    private func screenShot() -> UIImage? {
        //Create the UIImage
        UIGraphicsBeginImageContext(canvasView.frame.size)
        canvasView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
