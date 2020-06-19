//
//  LevelTwoViewController.swift
//  Hancock
//
//  Created by Jasmine Young on 6/17/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit
import AVKit // for the video player

class LevelTwoViewController: UIViewController {
    
    // MARK: - Variables
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var letterVideoView: UIView!
    @IBOutlet weak var replaySoundBtn: UIButton!
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var resetCanvasBtn: UIButton!
    private var isDoneDrawingLetter:Bool = false
    private var player = AVPlayer()
    private var letterToDraw:String = "A"
//    private var letterToDraw:String? {
//        didSet {
//            setUp()
//        }
//    }
    private let videoDictionary = ["A":"RemoveMeAfterTesting","B":"RemoveMeAfterTesting"]
    
    
    // MARK: - ViewDidLoad and Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        // Canvas setup
        canvasView.backgroundColor = UIColor(white: 1, alpha: 1)
        //this enables autolayout for our canvas
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        canvasView.widthAnchor.constraint(equalToConstant: view.bounds.width / 2).isActive = true
        canvasView.freeDraw = true
    }
    
    private func setUp() {
        print("Setup Letter \(letterToDraw)")
        letterLabel.text = "Let's Draw \"\(letterToDraw)\" Together!"
        guard let video = videoDictionary[letterToDraw] else {
            print("No value for key \(letterToDraw)")
            return
        }
        guard let path = Bundle.main.path(forResource: video, ofType: ".mp4") else {
            print("Could not find path for video")
            return
        }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = letterVideoView.bounds
        letterVideoView.layer.addSublayer(playerLayer)
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
        player.seek(to: .zero)
        player.play()
    }
    
    @IBAction func resetCanvas(_ sender: Any) {
        canvasView.clear()
    }
    
}
