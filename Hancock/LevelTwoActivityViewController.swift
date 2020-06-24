//
//  LevelTwoViewController.swift
//  Hancock
//
//  Created by Jasmine Young on 6/17/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit
import AVKit // for the video player

class LevelTwoActivityViewController: UIViewController {
    
    // MARK: - Variables
    @IBOutlet weak var doneBtn: UIButton! // to return to level 2 menu
    @IBOutlet weak var letterLabel: UILabel! // shows the letter to draw
    @IBOutlet weak var letterVideoView: UIView! // shows letter video
    @IBOutlet weak var replaySoundBtn: UIButton! // replay the video
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var resetCanvasBtn: UIButton! // clears lines from canvas
    private var player = AVPlayer() // video player IF VIDEOS AND NOT GIFS
    var letterToDraw:String? // set in LevelTwoMenuVC in prepare: forSegue
    
    // TODO: Get videos or gifs and link them
    // dictionary to grab letter video
    private let videoDictionary = [
        "a":"RemoveMeAfterTesting",
        "b":"RemoveMeAfterTesting",
        "c":"RemoveMeAfterTesting",
        "d":"RemoveMeAfterTesting",
        "e":"RemoveMeAfterTesting",
        "f":"RemoveMeAfterTesting",
        "g":"RemoveMeAfterTesting",
        "h":"RemoveMeAfterTesting",
        "i":"RemoveMeAfterTesting",
        "j":"RemoveMeAfterTesting",
        "k":"RemoveMeAfterTesting",
        "l":"RemoveMeAfterTesting",
        "m":"RemoveMeAfterTesting",
        "n":"RemoveMeAfterTesting",
        "o":"RemoveMeAfterTesting",
        "p":"RemoveMeAfterTesting",
        "q":"RemoveMeAfterTesting",
        "r":"RemoveMeAfterTesting",
        "s":"RemoveMeAfterTesting",
        "t":"RemoveMeAfterTesting",
        "u":"RemoveMeAfterTesting",
        "v":"RemoveMeAfterTesting",
        "w":"RemoveMeAfterTesting",
        "x":"RemoveMeAfterTesting",
        "y":"RemoveMeAfterTesting",
        "z":"RemoveMeAfterTesting",
            "A":"RemoveMeAfterTesting",
            "B":"RemoveMeAfterTesting",
            "C":"RemoveMeAfterTesting",
            "D":"RemoveMeAfterTesting",
            "E":"RemoveMeAfterTesting",
            "F":"RemoveMeAfterTesting",
            "G":"RemoveMeAfterTesting",
            "H":"RemoveMeAfterTesting",
            "I":"RemoveMeAfterTesting",
            "J":"RemoveMeAfterTesting",
            "K":"RemoveMeAfterTesting",
            "L":"RemoveMeAfterTesting",
            "M":"RemoveMeAfterTesting",
            "N":"RemoveMeAfterTesting",
            "O":"RemoveMeAfterTesting",
            "P":"RemoveMeAfterTesting",
            "Q":"RemoveMeAfterTesting",
            "R":"RemoveMeAfterTesting",
            "S":"RemoveMeAfterTesting",
            "T":"RemoveMeAfterTesting",
            "U":"RemoveMeAfterTesting",
            "V":"RemoveMeAfterTesting",
            "W":"RemoveMeAfterTesting",
            "X":"RemoveMeAfterTesting",
            "Y":"RemoveMeAfterTesting",
            "Z":"RemoveMeAfterTesting"]
    
    
    // MARK: - ViewDidLoad and Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if letterToDraw != nil {
            setUp()
        }
        
        // make button corners rounded
        doneBtn.layer.cornerRadius = 10
        
        // Canvas setup
        canvasView.backgroundColor = UIColor(white: 1, alpha: 1)
        //this enables autolayout for our canvas
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        canvasView.widthAnchor.constraint(equalToConstant: view.bounds.width / 2).isActive = true
        // added to stop line clearing after finger/pencil lifts
        canvasView.freeDraw = true
    }
    
    private func setUp() {
        print("Setup Letter \(letterToDraw!)")
        // show letter to draw
        letterLabel.text = "Let's Draw \"\(letterToDraw!)\" Together!"
        // find video name for letter
        guard let video = videoDictionary[letterToDraw!] else {
            print("No value for key \(letterToDraw!)")
            return
        }
        // find video path in the main bundle
        guard let path = Bundle.main.path(forResource: video, ofType: ".mp4") else {
            print("Could not find path for video")
            return
        }
        
        // FOR VIDEOS AND NOT GIFS
        
        // create local url with the path
        let url = URL(fileURLWithPath: path)
        // assign AVPlayer to play the video
        player = AVPlayer(url: url)
        // create a layer to put the player on so it doesn't take up the whole screen
        let playerLayer = AVPlayerLayer(player: player)
        // the the frame to the sized view in the storyboard
        playerLayer.frame = letterVideoView.bounds
        // add the player layer to the sized view
        letterVideoView.layer.addSublayer(playerLayer)
        // play the video
        player.play()
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
        canvasView.endTouches(touches, cancel: false)
    }
    
    // MARK: - Actions
    @IBAction func replayVideo(_ sender: UIButton) {
        
        // FOR VIDEOS AND NOT GIFS
        
        // set the player's video time position to zero and play
        player.seek(to: .zero)
        player.play()
    }
    
    @IBAction func resetCanvas(_ sender: UIButton) {
        // removes all lines from canvas view
        canvasView.clear()
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        // done with letter so send data return to menu selection
        // TODO: Send data to backend
        // this is a screenshot of the canvas view
        if let image = screenShot() {
            // we could try saving a 'png'
            // there is also a jpeg option
            if let pngData = image.pngData() {
                // did some testing and this pngData can be successfully written to a .png file
                // i'm thinking that we can send the pngData as Data to the db and then be able to display it on the website
                // but we could also try a base64EncodedString if that doesn't work
//                let base64String = pngData.base64EncodedString()
                print("Did screenshot Level2 and this is the pngData: \(pngData)")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute:{
            self.dismiss(animated: false, completion: nil)
        })
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
