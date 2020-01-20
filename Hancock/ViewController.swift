//
//  ViewController.swift
//  Hancock
//
//  Created by Chris Ross on 5/3/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

// MARK: - Game State
enum GameState: Int16 {
    case detectSurface
    case hitStartToPlay
    case playGame
}

enum GameProgress: Int16 {
    case toLetter1
    case toLetter2
    case toLetter3
    case toLetter4
    case toLetter5
    case toLetter6
    case chapterFinished
}

//By adopting the UITextFieldDelegate protocol, you tell the compiler that the ViewController class can act as a valid text field delegate. This means you can implement the protocol’s methods to handle text input, and you can assign instances of the ViewController class as the delegate of the text field.
class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var stuNameTextFeild: UITextField!
    @IBOutlet weak var stuDOBTextField: UITextField!
    @IBOutlet weak var stuGradeTextField: UITextField!
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var showAllBtn: UIButton!
    
    //MARK: - ACTIONS
    @IBAction func goToActivity(_ sender: Any) {
        //let activityBoardView = self.storyboard?.instantiateViewController(withIdentifier: "ActivityBoardViewController") as! activityViewController
        //self.present(activityBoardView, animated: true)
        
        stopWalkAnimation()
    }
    @IBAction func setStudentInfo(_ sender: UIButton) {
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        self.startGame()
        
        //while game is playing we need a go back button to return to the beginning
        resetButton.isHidden = false
        
        switch true {
        case chapterOne:
            showAllBtn.isHidden = false
        case chapterTwo:
            //don't need to hide everything in this scene
            showAllBtn.isHidden = true
        case chapterThree:
            //don't need to hide everything in this scene
            showAllBtn.isHidden = true
        case chapterFour:
            showAllBtn.isHidden = true
        case chapterFive:
            showAllBtn.isHidden = true
        default:
            break
        }
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        self.resetGame()
    }
    
    @IBAction func showAllButtonPressed(_ sender: Any) {
        //toggle the showall button
        if storymask.isHidden == true {
            storymask.isHidden = false
            //while showing all the environment set btn to show brighter
            showAllBtn.alpha = 1
        }
        else{
            storymask.isHidden = true
            //while not showing all the environment set btn to hardly show
            showAllBtn.alpha = 0.3
        }
        
    }
    
    // MARK: - VARIABLES
    var trackingStatus: String = ""
    var statusMessage: String = ""
    var gameState: GameState = .detectSurface
    var gameProgress: GameProgress = .toLetter1
    var focusPoint: CGPoint!
    var focusNode: SCNNode!
    var chapterNodeArray: [SCNNode]!
    
    //main movement nodes for every story
    var rootStoryNode: SCNNode!
    var mainCharacterIdle: SCNNode!
    var charcterOneIdle: SCNNode!
    var charcterTwoIdle: SCNNode!
    var charcterThreeIdle: SCNNode!
    var charcterFourIdle: SCNNode!
    var charcterFiveIdle: SCNNode!
    var mainCharacterMoving: SCNNode!
    var mainFloor: SCNNode!
    var storymask: SCNNode!
    
    //last screen tap item
    var lastTapped: SCNNode?
    var outfitSelected: String?
    
    //main letters (possibly six)
    var letterOne: SCNNode?
    var letterTwo: SCNNode?
    var letterThree: SCNNode?
    var letterFour: SCNNode?
    var letterFive: SCNNode?
    var letterSix: SCNNode?
    
    //trigger variables for shattering letters
    var shatterLetterOne: Bool = false
    var shatterLetterTwo: Bool = false
    var shatterLetterThree: Bool = false
    var shatterLetterFour: Bool = false
    var shatterLetterFive: Bool = false
    var shatterLetterSix: Bool = false
    
    //Bools for movement (temporary; will replace animation system in future)
    var idle: Bool = true
    var isMoving: Bool = false
    
    //variables for sound files and audio players
    var walkPlayer = AVAudioPlayer()
    var birdsPlayer = AVAudioPlayer()
    
    var narrationPlayer = AVAudioPlayer()
    var FXPlayer = AVAudioPlayer()
    var BGPlayer = AVAudioPlayer()
    var CharacterPlayer = AVAudioPlayer()

    // MARK: - Start Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterNodeArray = chapterSelectedNodeArray
        self.initSceneView()
        self.initScene()
        self.initARSession()
        self.loadModels(chapterNode: chapterNodeArray!)
        self.referenceMainNodes()
        
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //select number of taps needed to trigger
        tapGestureRecognizer.numberOfTapsRequired = 1
        //add the gesture recognizer to the scene view
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        
//        //setup audio player by loading an file address into the variable
//        let backgroundAudioPath = Bundle.main.path(forResource: (chapterSelectedSoundDict!["Background2"]), ofType: "wav", inDirectory: "art.scnassets/Sounds")
//        do
//        {
//            //assign the file address to the AVAudioPlayer
//            try BGPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: backgroundAudioPath!))
//
//        } catch {
//            print("WalkPlayer not available!")
//        }
        
        if shatterLetterOne == false {
            //pause the Letter Shatter animation
            letterOne?.isPaused = true
            letterTwo?.isPaused = true
            letterThree?.isPaused = true
            letterFour?.isPaused = true
            letterFive?.isPaused = true
            letterSix?.isPaused = true
            
            print("Shatter Animation Paused")
            //you can also pause individual animations
            //storyNode?.childNode(withName: "shard2", recursively: true)?.animationPlayer(forKey: "shard2-Matrix-animation-transform")?.paused = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("*** ViewWillAppear()")
        
        //attempt to shatter a letter when the viuew loads
        //(will only happen if a letter shatter boolean is true and ready)
        playShatterAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("*** ViewWillDisappear()")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("*** DidReceiveMemoryWarning()")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    // MARK: - Init Functions
    
    func initSceneView() {
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.showsStatistics = true
        sceneView.preferredFramesPerSecond = 60
        sceneView.antialiasingMode = .multisampling2X
        sceneView.debugOptions = [
            //ARSCNDebugOptions.showFeaturePoints,
            //ARSCNDebugOptions.showWorldOrigin,
            //SCNDebugOptions.showPhysicsShapes,
            //SCNDebugOptions.showBoundingBoxes
        ]
        focusPoint = CGPoint(x: view.center.x, y: view.center.y + view.center.y * 0.25)
    }
    
    func initScene() {
        let scene = SCNScene()
        //scene.lightingEnvironment.contents = "Hancock.scnassets/Textures/Environment_CUBE.jpg"
        scene.lightingEnvironment.intensity = 2
        scene.physicsWorld.speed = 1
        scene.isPaused = false
        sceneView.scene = scene
    }
    
    func initARSession() {
        
        guard ARWorldTrackingConfiguration.isSupported else {
            print("*** ARConfig: AR World Tracking Not Supported")
            return
        }
        
        let config = ARWorldTrackingConfiguration()
        //config.isLightEstimationEnabled = true
        config.planeDetection = .horizontal
        config.worldAlignment = .gravity
        config.providesAudioData = false
        sceneView.session.run(config)
    }
    
    func resetARSession() {
        let config = sceneView.session.configuration as! ARWorldTrackingConfiguration
        config.planeDetection = .horizontal
        sceneView.session.run(config,
                              options: [.resetTracking,
                                        .removeExistingAnchors])
    }
    
    func suspendARPlaneDetection() {
        let config = sceneView.session.configuration as! ARWorldTrackingConfiguration
        config.planeDetection = []
        sceneView.session.run(config)
    }
    
    // MARK: - Helper Functions
    
    func createARPlaneNode(planeAnchor: ARPlaneAnchor, color: UIColor) -> SCNNode {
        
        // 1 - Create plane geometry using anchor extents
        let planeGeometry = SCNPlane(width: CGFloat(planeAnchor.extent.x),
                                     height: CGFloat(planeAnchor.extent.z))
        
        // 2 - Create meterial with just a diffuse color
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = color
        planeGeometry.materials = [planeMaterial]
        
        // 3 - Create plane node
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        return planeNode
    }
    
    func updateARPlaneNode(planeNode: SCNNode, planeAchor: ARPlaneAnchor) {
        
        // 1 - Update plane geometry with planeAnchor details
        let planeGeometry = planeNode.geometry as! SCNPlane
        planeGeometry.width = CGFloat(planeAchor.extent.x)
        planeGeometry.height = CGFloat(planeAchor.extent.z)
        
        // 2 - Update plane position
        planeNode.position = SCNVector3Make(planeAchor.center.x, 0, planeAchor.center.z)
    }
    
    func removeARPlaneNode(node: SCNNode) {
        for childNode in node.childNodes {
            childNode.removeFromParentNode()
        }
    }
    
    func createFloorNode() -> SCNNode {
        let floorGeometry = SCNFloor()
        floorGeometry.reflectivity = 0.0
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIColor.white
        floorMaterial.blendMode = .multiply
        floorGeometry.materials = [floorMaterial]
        let floorNode = SCNNode(geometry: floorGeometry)
        floorNode.position = SCNVector3Zero
//        floorNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
//        floorNode.physicsBody?.restitution = 0.5
//        floorNode.physicsBody?.friction = 4.0
//        floorNode.physicsBody?.rollingFriction = 0.0
        return floorNode
    }
    
    //**************************
    //FUNCTION TO HANDLE TAP GESTURES
    @objc func handleTap( sender: UITapGestureRecognizer) {
        //get a CGpoint variable for our touch on the screen (x and y location)
        let tappedView = sender.view as! SCNView
        
        let touchLocation = sender.location(in: tappedView)
        
        let  hitTest = tappedView.hitTest(touchLocation, options: nil)
        
        if !hitTest.isEmpty {
            let hitTestResult = hitTest.first!
            let name = hitTestResult.node.name
            let geometry = hitTestResult.node.geometry
            print("Tapped \(String(describing: name)) with geometry: \(String(describing: geometry))")
            
            switch hitTestResult.node.parent?.name {
                case "SideCharacter1":
                    charcterOneIdle.isHidden = true
                    charcterTwoIdle.isHidden = true
                    charcterThreeIdle.isHidden = true
                    charcterFourIdle.isHidden = true
                    
                    //TO-DO: change Piper's cloths
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    //wait 4 seconds for the game intro1 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //move the main character to the first letter
                        self.playWalkAnimation()
                    })
                case "SideCharacter2":
                    charcterOneIdle.isHidden = true
                    charcterTwoIdle.isHidden = true
                    charcterThreeIdle.isHidden = true
                    charcterFourIdle.isHidden = true
                    
                    //TO-DO: change Piper's cloths
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    //wait 4 seconds for the game intro1 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //move the main character to the first letter
                        self.playWalkAnimation()
                    })
                case "SideCharacter3":
                    charcterOneIdle.isHidden = true
                    charcterTwoIdle.isHidden = true
                    charcterThreeIdle.isHidden = true
                    charcterFourIdle.isHidden = true
                    
                    //TO-DO: change Piper's cloths
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    //wait 4 seconds for the game intro1 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //move the main character to the first letter
                        self.playWalkAnimation()
                    })
                case "SideCharacter4":
                    charcterOneIdle.isHidden = true
                    charcterTwoIdle.isHidden = true
                    charcterThreeIdle.isHidden = true
                    charcterFourIdle.isHidden = true
                    
                    //TO-DO: change Piper's cloths
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    //wait 4 seconds for the game intro1 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //move the main character to the first letter
                        self.playWalkAnimation()
                    })
                default:
                    break
            }
        }
    }
    
    // MARK: - Update Functions
    
    func updateStatus() {
        switch gameState {
        case .detectSurface: statusMessage = "Detecting surfaces..."
        case .hitStartToPlay: statusMessage = "Hit START to play!"
        case .playGame: statusMessage = "Story Time!"
        }
        
        self.statusLabel.text = trackingStatus != "" ?
            "\(trackingStatus)" : "\(statusMessage)"
    }
    
    func updateFocusNode() {
        
        // Hide Focus Node
        if gameState == .playGame {
            self.focusNode.isHidden = true
            return
        }
        
        // Show Focus Node
        self.focusNode.isHidden = false
        let results = self.sceneView.hitTest(self.focusPoint, types: [.existingPlaneUsingExtent])
        
        if results.count >= 1 {
            if let match = results.first {
                let t = match.worldTransform
                self.focusNode.position = SCNVector3(x: t.columns.3.x, y: t.columns.3.y, z: t.columns.3.z)
                self.gameState = .hitStartToPlay
            }
        } else {
            self.gameState = .detectSurface
        }
    }
    
    func updatePositions() {
        // Update the story scene Node to where you put the focus node
        self.rootStoryNode.position = self.focusNode.position
    }
    
    // MARK: - Game Management
    
    func startGame() {
        //make sure the gamestate is ready and detecting a surface before it will let you hit play
        guard self.gameState == .hitStartToPlay else { return }
        DispatchQueue.main.async {
            self.updatePositions()
            self.rootStoryNode.isHidden = false
            self.mainCharacterIdle?.isHidden = false
            
            self.startButton.isHidden = true
            self.gameState = .playGame
            //player background music/ambient
            self.toggleAudioBGFile(file: chapterSelectedSoundDict!["BackgroundSound"]!, type: "mp3")
        }
        storyTime()
    }
    
    func resetGame(){
        guard self.gameState == .playGame else { return }
        
//        DispatchQueue.global().async {
//            //fade out the walking sound
//            self.FXPlayer.setVolume(0, fadeDuration: 1)
//            //stop playing the walking sound
//            self.FXPlayer.stop()
//            self.FXPlayer.setVolume(1, fadeDuration: 0)
//
//            //self.walkPlayer.stop()
//            self.narrationPlayer.stop()
//            self.BGPlayer.stop()
//            self.CharacterPlayer.stop()
//        }
        
        DispatchQueue.main.async {
            //hide the main nodes
            //self.rootStoryNode.isHidden = true
            //self.mainCharacterIdle.isHidden = true
            //self.mainCharacterMoving.isHidden = true
            
            //change game state and show start button
            self.startButton.isHidden = false
            self.gameState = .detectSurface
            
            //stop all sound
            self.toggleAudioBGFile(file: chapterSelectedSoundDict!["Stop"]!, type: "wav")
            self.toggleAudioFXFile(file: chapterSelectedSoundDict!["Stop"]!, type: "wav", rate: 1.5)
            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Stop"]!, type: "wav")
            self.toggleAudioCharacterFile(file: chapterSelectedSoundDict!["Stop"]!, type: "wav")
            
            //stop all animations
            //self.stopWalkAnimation()
            //self.stopAnimation2()
            //self.shatterLetterOne = false
            
            //reset positions/rotations of all moved nodes
            //self.mainFloor.position = SCNVector3(-0.749, 0, 2.292)
            //self.mainCharacterMoving.position = SCNVector3(0, 0, 0)
            //self.mainCharacterMoving.eulerAngles = SCNVector3(0, 0, 0)
            //self.mainCharacterIdle.position = SCNVector3(0, 0, 0)
            //self.mainCharacterIdle.eulerAngles = SCNVector3(0, 0, 0)
            
            self.removeModels(chapterNode: self.chapterNodeArray!)
            
            let chapterARView = self.storyboard?.instantiateViewController(withIdentifier: "bookARViewController") as! HomeViewController
            self.present(chapterARView, animated: true)
        }
    }
    
    func loadModels(chapterNode: [SCNNode]) {
        
        for child in chapterNode {
            sceneView.scene.rootNode.addChildNode(child)
        }
        
        // Load Focus Node second because we don't want it to be the root node
        let focusScene = SCNScene(named: "art.scnassets/FocusScene.scn")!
        focusNode = focusScene.rootNode.childNode(withName: "focus", recursively: false)
        focusNode.isHidden = true
        sceneView.scene.rootNode.addChildNode(focusNode)
    }
    func removeModels(chapterNode: [SCNNode]) {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in node.removeFromParentNode()}
    }
    
    func referenceMainNodes() {
        
        //generic variable story level container (hide initially)
        rootStoryNode = sceneView.scene.rootNode.childNode(withName: "LVLContainer", recursively: false)
        rootStoryNode.isHidden = true
        
        //generic variable for the area mask in the story
        storymask = sceneView.scene.rootNode.childNode(withName: "StoryMask", recursively: true)
        
        //generic story main character idle animation
        //mainCharacterIdle = sceneView.scene.rootNode.childNode(withName: "MainCharacter_Idle", recursively: true)
        mainCharacterIdle = sceneView.scene.rootNode.childNode(withName: "MainCharacter", recursively: true)
        mainCharacterIdle?.isHidden = false
        charcterOneIdle = sceneView.scene.rootNode.childNode(withName: "SideCharacter1", recursively: true)
        charcterOneIdle?.isHidden = false
        charcterTwoIdle = sceneView.scene.rootNode.childNode(withName: "SideCharacter2", recursively: true)
        charcterTwoIdle?.isHidden = false
        charcterThreeIdle = sceneView.scene.rootNode.childNode(withName: "SideCharacter3", recursively: true)
        charcterThreeIdle?.isHidden = false
        charcterFourIdle = sceneView.scene.rootNode.childNode(withName: "SideCharacter4", recursively: true)
        charcterFourIdle?.isHidden = false
        charcterFiveIdle = sceneView.scene.rootNode.childNode(withName: "SideCharacter5", recursively: true)
        charcterFiveIdle?.isHidden = false
        
        //generic variable for level floor
        mainFloor = sceneView.scene.rootNode.childNode(withName: "LVLFloor", recursively: true)
        print("-------------------mainFloor is now \(mainFloor!)")
        
        //generic variable for the first letter
        letterOne = sceneView.scene.rootNode.childNode(withName: "LetterOne", recursively: true)
        letterTwo = sceneView.scene.rootNode.childNode(withName: "LetterTwo", recursively: true)
        letterThree = sceneView.scene.rootNode.childNode(withName: "LetterThree", recursively: true)
        letterFour = sceneView.scene.rootNode.childNode(withName: "LetterFour", recursively: true)
        letterFive = sceneView.scene.rootNode.childNode(withName: "LetterFive", recursively: true)
        letterSix = sceneView.scene.rootNode.childNode(withName: "LetterSix", recursively: true)
        
        //load ambient sound for chapter (global variable)
    }
    
    func startTransitionAnimation(key: String) {
        //add the animation to start playing it right away
        //sceneView.scene.rootNode.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        print("Adding animation")
        mainCharacterIdle?.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
    }
    
    func stopTransitionAnimation(key: String) {
        //stop the animation with a smooth transition
        //sceneView.scene.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        print("Removing animation")
        mainCharacterIdle?.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
    }
    func startTransitionAnimationOnce(key: String) {
        print("Adding animation to play once")
        mainCharacterIdle?.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        chapterSelectedAnimationDict[key]!.repeatCount = 1
        chapterSelectedAnimationDict[key]!.isRemovedOnCompletion = false
    }
    
    func playWalkAnimation() {
        //Based on Letter
        switch gameProgress {
        //----------------------------------------------------
        //MARK: Letter 1
        case .toLetter1:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //move position for letter:
                //I (chapter1 - letter 1)
                
                //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
                startTransitionAnimation(key: "MainCharacterWalking")
                //play walk sound
                toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                //animate the mainFloor node to move and stop when the translation is complete
                mainFloor.runAction(SCNAction.moveBy(x:0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation)
                //animate the main character to rotate a bit on the y axis
                mainCharacterIdle?.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new chapter 1
                print("move floor for chapter one")
                
            case chapterTwo:
                //move position for letter:
                //P (chapter2 - letter1)

                startTransitionAnimationOnce(key: "MainCharacterSkating")
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                let rotate1 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 1)
                let move2 = SCNAction.move(to: SCNVector3(-0.195, 0.078, -0.021), duration: 2)  //P1 to P2
                let rotate2 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 0.5)
                let move3 = SCNAction.move(to: SCNVector3(-0.195, 0.078, -0.202), duration: 2)     //P2 to P3
                let rotate3 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 0.5)
                let move4 = SCNAction.move(to: SCNVector3(-0.337, 0.078, -0.274), duration: 1.5)  //P3 to P
                let rotate4 = SCNAction.rotateBy(x: 0, y: 2.25, z: 0, duration: 0.5)
                let chapter2Letter1MoveSeq = SCNAction.sequence([rotate1, move2, rotate2, move3, rotate3, move4, rotate4])
                mainCharacterIdle?.parent?.runAction((chapter2Letter1MoveSeq), completionHandler: stopWalkAnimation)

                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                })

                print("move character for chapter two")
            case chapterThree:
                //move position for letter:
                //G (chapter3 - letter1)
                
                startTransitionAnimation(key: "MainCharacterSwimming")
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                //let rotate1 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 1)
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 5)
                let chapter3Letter1RotationSeq = SCNAction.sequence([rotate1])
                mainCharacterIdle?.parent?.runAction(chapter3Letter1RotationSeq)
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 5)  //P1 to P2
                //let rotate2 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 0.5)
                let chapter3Letter1MoveSeq = SCNAction.sequence([move1])
                mainCharacterIdle?.parent?.runAction((chapter3Letter1MoveSeq), completionHandler: stopWalkAnimation)
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.9, execute: {
                    self.stopTransitionAnimation(key: "MainChracterSwimming")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                })
                
                print("move for chapter three, letter1")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                stopWalkAnimation()
                //move position for letter:
                //K

            
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                //play game intro 1
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    
                    //show busted Xylophone
                    let xylophone_1 = self.mainCharacterIdle.childNode(withName: "xylophone_1 reference", recursively: true)
                    xylophone_1!.isHidden = false
                    
                    //hide mallet head
                    let malletHead = self.mainCharacterIdle.childNode(withName: "Head", recursively: true)
                    malletHead!.isHidden = true
                    
                    //hide first xylophone
                    let xylophone_0 = self.mainCharacterIdle.childNode(withName: "xylophone_0 reference", recursively: true)
                    xylophone_0!.isHidden = true
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                    //TODO: ADD touches and raytracing to select Nails
                    
                    //look around for nails at teachers desk
                    DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute: {
                        //move the main character to the first letter
                        self.stopWalkAnimation()
                    })
                })
                //move position for letter:
                //N

                print("move floor for chapter five")
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 2
        case .toLetter2:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //T (chapter1 - letter 2)
                
                //show the main character as idle and hide the walking version of him
                startTransitionAnimation(key: "MainCharacterWalking")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for finishing letter 2
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration10"]!, type: "mp3")
                })
                
                mainFloor.runAction(SCNAction.moveBy(x: -0.1, y: 0, z: -1.3, duration: 10), completionHandler: stopWalkAnimation)
                
            case chapterTwo:
                //R (chapter2 - letter2)

                startTransitionAnimationOnce(key: "MainCharacterSkating")
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 2.25, z: 0, duration: 1)
                let move1 = SCNAction.move(to: SCNVector3(-0.26, 0.078, -0.371), duration: 1)   //P to R1
                //let rotate2 = SCNAction.rotateBy(x: 0, y: -0.75, z: 0, duration: 0.5)            //rotate down
                let move2 = SCNAction.move(to: SCNVector3(-0.211, 0, -0.451), duration: 1)      //R1 to R2 slopping down
                //let rotate3 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 0.5)           //rotate up (level out)
                let move3 = SCNAction.move(to: SCNVector3(-0.046, 0, -0.649), duration: 3)      //R2 to R3
                let rotate4 = SCNAction.rotateBy(x: 0, y: -0.75, z: 0, duration: 0.5)
                let move4 = SCNAction.move(to: SCNVector3(0.033, 0, -0.649), duration: 1)       //R3 to R
                let rotate5 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 0.5)
                let chapter2Letter2MoveSeq = SCNAction.sequence([rotate1, move1,  move2, move3, rotate4, move4, rotate5])
                mainCharacterIdle?.parent?.runAction((chapter2Letter2MoveSeq), completionHandler: stopWalkAnimation)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                })
                
                print("move floor for chapter two")
            case chapterThree:
                //Q (chapter3 - letter2)
                
                startTransitionAnimation(key: "MainCharacterSwimming")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(1.768)), y: CGFloat(GLKMathDegreesToRadians(-4.909)), z: CGFloat(GLKMathDegreesToRadians(-19.836)), duration: 3)
                let chapter3Letter2RotationSeq = SCNAction.sequence([rotate1])
                mainCharacterIdle?.parent?.runAction(chapter3Letter2RotationSeq)
                
                let move1 = SCNAction.move(to: SCNVector3(-0.381, 0.096, 0.218), duration: 8)  //P1 to P2
                //let rotate2 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 0.5)
                let chapter3Letter2MoveSeq = SCNAction.sequence([move1])
                mainCharacterIdle?.parent?.runAction((chapter3Letter2MoveSeq), completionHandler: stopWalkAnimation)
                
                print("move for chapter three")
            case chapterFour:
                //V (chapter4 - letter2)
                stopTransitionAnimation(key: "MainCharacterWaving")
                startTransitionAnimation(key: "MainCharacterJogging")
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5)
                let move1 = SCNAction.move(to: SCNVector3(4.271 ,0 ,-15.979), duration: 3)
                let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move2 = SCNAction.move(to: SCNVector3(16.581 ,0 ,-15.979), duration: 3)
                let rotate3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(180)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move3 = SCNAction.move(to: SCNVector3(16.581 ,0 ,-19.666), duration: 2)
                let move4 = SCNAction.move(to: SCNVector3(16.581 ,2.7 ,-22.66), duration: 2)
                let move5 = SCNAction.move(to: SCNVector3(16.581 ,2.7 ,-31.334), duration: 2)
                let rotate6 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(135)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move6 = SCNAction.move(to: SCNVector3(22.279 ,2.7 ,-37.032), duration: 2)
                let rotate7 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(60)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move7 = SCNAction.move(to: SCNVector3(34.781 ,2.7 ,-29.814), duration: 2)
                let rotate8 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move8 = SCNAction.move(to: SCNVector3(38.264 ,2.7 ,-29.814), duration: 2)
                let chapter4Letter2RotationSeq = SCNAction.sequence([rotate1, move1, rotate2, move2, rotate3, move3, move4, move5, rotate6, move6, rotate7, move7, rotate8, move8])
                mainCharacterIdle?.parent?.runAction((chapter4Letter2RotationSeq), completionHandler: stopWalkAnimation)
                
                print("move floor for chapter four")
            case chapterFive:
                //(chapter5 -- letter2)
                
                    //TODO: ADD touches and raytracing to select Nails
                    
                    //look around for nails at teachers desk
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //move the main character to the first letter
                        self.stopWalkAnimation()
                    })
                    
                //Z
                
                print("move floor for chapter five")
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 3
        case .toLetter3:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //L (chapter1 - letter 3)
                //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
                startTransitionAnimation(key: "MainCharacterWalking")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for finishing letter 2
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration17"]!, type: "mp3")
                })
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                // x= (-)west/(+)east, z= (-)north/(+)south
                let move1 = SCNAction.moveBy(x: 0.05, y: 0, z: -1.5, duration: 8)
                let move2 = SCNAction.moveBy(x: 0.5, y: 0, z: -0.02, duration: 5)
                let chapter1Letter3MoveSeq = SCNAction.sequence([move1, move2])
                mainFloor.runAction((chapter1Letter3MoveSeq), completionHandler: stopWalkAnimation)
                
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 7)
                let rotate2 = SCNAction.rotateBy(x: 0, y: -1.75, z: 0, duration: 1)
                let chapter1Letter3RotSeq = SCNAction.sequence([rotate1, rotate2])
                mainCharacterIdle?.runAction(chapter1Letter3RotSeq)

                
            case chapterTwo:
                //B (chapter2 - letter3)
                
                startTransitionAnimationOnce(key: "MainCharacterSkating")
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 1)
                let move1 = SCNAction.move(to: SCNVector3(-0.125, 0, -0.653), duration: 2) //R to B
                let rotate2 = SCNAction.rotateBy(x: 0, y: 1.5, z: 0, duration: 0.5)

                let chapter2Letter3MoveSeq = SCNAction.sequence([rotate1, move1, rotate2])
                mainCharacterIdle?.parent?.runAction((chapter2Letter3MoveSeq), completionHandler: stopWalkAnimation)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                })
                
            case chapterThree:
                //S (chapter3 - letter3)
                
                startTransitionAnimation(key: "MainCharacterSwimming")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(30)), y: CGFloat(GLKMathDegreesToRadians(-53.596)), z: CGFloat(GLKMathDegreesToRadians(-36)), duration: 3)
                let chapter3Letter3RotationSeq = SCNAction.sequence([rotate1])
                mainCharacterIdle?.parent?.runAction(chapter3Letter3RotationSeq)
                let move1 = SCNAction.move(to: SCNVector3(0.335, 0.281, 0.479), duration: 8)  //P1 to P2
                let chapter3Letter3MoveSeq = SCNAction.sequence([move1])
                mainCharacterIdle?.parent?.runAction((chapter3Letter3MoveSeq), completionHandler: stopWalkAnimation)
                
                print("move for chapter three")
            case chapterFour:
                //W (chapter4 - letter3)
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                })
                
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterJogging")
//                //animate the mainFloor node to move and stop when the translation is complete
//                //animate the main character to rotate
                let rotate8 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move7 = SCNAction.move(to: SCNVector3(34.781 ,2.7 ,-29.814), duration: 2)
                let rotate7 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-120)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move6 = SCNAction.move(to: SCNVector3(22.279 ,2.7 ,-37.032), duration: 2)
                let rotate6 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y:  CGFloat(GLKMathDegreesToRadians(-45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move5 = SCNAction.move(to: SCNVector3(16.581 ,2.7 ,-31.334), duration: 2)
                let rotate3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move4 = SCNAction.move(to: SCNVector3(16.581 ,2.7 ,-22.66), duration: 2)
                let move3 = SCNAction.move(to: SCNVector3(16.581 ,0 ,-19.666), duration: 2)
                let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y:  CGFloat(GLKMathDegreesToRadians(-60)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move2 = SCNAction.move(to: SCNVector3(-25.313,0 ,4.524), duration: 5)
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y:  CGFloat(GLKMathDegreesToRadians(-90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move1 = SCNAction.move(to: SCNVector3(-53,0 ,4.5), duration: 3)
                let chapter4Letter3RotationSeq = SCNAction.sequence([rotate8, move7, rotate7, move6, rotate6, move5, rotate3, move4, move3, rotate2, move2, rotate1, move1])
                mainCharacterIdle?.parent?.runAction((chapter4Letter3RotationSeq), completionHandler: stopWalkAnimation)
                
                //W
                
                print("move floor for chapter four")
            case chapterFive:
                //(chapter5 -- letter3)
                
                //TODO: ADD touches and raytracing to select Yarn
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //move the main character to the first letter
                    self.stopWalkAnimation()
                })
                
                //Y
                
                print("move floor for chapter five")
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 4
        case .toLetter4:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //F (chapter1 - letter 4)
                
                //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                // x= (-)west/(+)east, z= (-)north/(+)south
                let move1 = SCNAction.moveBy(x: 0.3, y: 0, z: 0.1, duration: 2)
                let move2 = SCNAction.moveBy(x: 0.0, y: 0, z: 1.8, duration: 7)
                let move3 = SCNAction.moveBy(x: 0.6, y: 0, z: 0.2, duration: 3)
                let chapter1Letter4MoveSeq = SCNAction.sequence([move1, move2, move3])
                mainFloor.runAction((chapter1Letter4MoveSeq), completionHandler: stopWalkAnimation)
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)
                let rotate2 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 1)
                let rotate3 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 7)
                let rotate4 = SCNAction.rotateBy(x: 0, y: 1.75, z: 0, duration: 1)
                let chapter1Letter4RotSeq = SCNAction.sequence([rotate1, rotate2, rotate3, rotate4])
                mainCharacterIdle?.runAction(chapter1Letter4RotSeq)
                
            case chapterTwo:
                //C (chapter2 - letter4)
                
                startTransitionAnimationOnce(key: "MainCharacterSkating")
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 2.25, z: 0, duration: 1)
                let move1 = SCNAction.move(to: SCNVector3(-0.081, 0, -0.713), duration: 0.75) //B to C1
                //let rotate2 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)
                let move2 = SCNAction.move(to: SCNVector3(-0.041, 0.078, -0.814), duration: 1) //C1 to C2 slopping up
                let rotate3 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 0.25)
                let move3 = SCNAction.move(to: SCNVector3(-0.041, 0.091, -0.912), duration: 0.75) //C2 to C3
                let rotate4 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 0.5)
                let move4 = SCNAction.move(to: SCNVector3(0.012, 0.092, -0.912), duration: 0.5) //C3 to C4
                //let rotate5 = SCNAction.rotateBy(x: 0, y: 0, z: 0.35, duration: 0.25) //up
                let move5 = SCNAction.move(to: SCNVector3(0.319, 0.216, -0.912), duration: 2) //C4 to C5
                //let rotate6 = SCNAction.rotateBy(x: 0, y: -0.35, z: 0, duration: 0.25) //down (level out)
                let move6 = SCNAction.move(to: SCNVector3(0.375, 0.216, -0.912), duration: 0.5) //C5 to C
                let rotate7 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 0.5)
                let chapter2Letter1MoveSeq = SCNAction.sequence([rotate1, move1, move2, rotate3, move3, rotate4, move4, move5, move6, rotate7])
                mainCharacterIdle?.parent?.runAction((chapter2Letter1MoveSeq), completionHandler: stopWalkAnimation)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                })

            case chapterThree:
                //J (chapter3 - letter4)
                
                startTransitionAnimation(key: "MainCharacterSwimming")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-163.287)), y: CGFloat(GLKMathDegreesToRadians(27.438)), z: CGFloat(GLKMathDegreesToRadians(-146.911)), duration: 3)
                let chapter3Letter4RotationSeq = SCNAction.sequence([rotate1])
                mainCharacterIdle?.parent?.runAction(chapter3Letter4RotationSeq)
                let move1 = SCNAction.move(to: SCNVector3(-0.246, 0.254, -0.371), duration: 8)  //P1 to P2
                let chapter3Letter4MoveSeq = SCNAction.sequence([move1])
                mainCharacterIdle?.parent?.runAction((chapter3Letter4MoveSeq), completionHandler: stopWalkAnimation)
                
                print("move for chapter three, letter 4")
            case chapterFour:
                //M (chapter4 - letter4)
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration30"]!, type: "mp3")
                
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterJogging")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5)
                let move1 = SCNAction.move(to: SCNVector3(23.5 ,0 ,4.5), duration: 7)
                let chapter4Letter4RotationSeq = SCNAction.sequence([rotate1, move1])
                mainCharacterIdle?.parent?.runAction((chapter4Letter4RotationSeq), completionHandler: stopWalkAnimation)
                
                //M
                print("move floor for chapter four")
                
            case chapterFive:
                //(chapter5 -- letter4)
                
                //TODO: ADD touches and raytracing to put the Xylophone together
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //move the main character to the first letter
                    self.stopWalkAnimation()
                })
                //X
                
                print("move floor for chapter five")
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 5
        case .toLetter5:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //E (chapter1 - letter 5)
                
                //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                // x= (-)west/(+)east, z= (-)north/(+)south
                let move1 = SCNAction.moveBy(x: 0, y: 0, z: 0, duration: 1)
                let move2 = SCNAction.moveBy(x: 0.5, y: 0, z: -0.2, duration: 2)
                let move3 = SCNAction.moveBy(x: 0.15, y: 0, z: -0.8, duration: 6)
                let chapter1Letter5MoveSeq = SCNAction.sequence([move1, move2, move3])
                mainFloor.runAction((chapter1Letter5MoveSeq), completionHandler: stopWalkAnimation)
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 0.6, z: 0, duration: 1)
                let rotate2 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)
                let rotate3 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 1)
                let chapter1Letter5RotSeq = SCNAction.sequence([rotate1, rotate2, rotate3])
                mainCharacterIdle?.runAction(chapter1Letter5RotSeq)
                
            case chapterTwo:
                //D (chapter2 - letter5)
                
                startTransitionAnimationOnce(key: "MainCharacterSkating")
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 1)
                let move1 = SCNAction.move(to: SCNVector3(0.488, 0.216, -0.726), duration: 2)       //C to D1
                let rotate2 = SCNAction.rotateBy(x: 0, y: -0.75, z: 0, duration: 0.5)
                let move2 = SCNAction.move(to: SCNVector3(0.488, 0.216, -0.513), duration: 1)    //D1 to D2 slopping up
                let move3 = SCNAction.move(to: SCNVector3(0.488, 0.194, -0.35), duration: 2)      //D2 to D
                let chapter2Letter1MoveSeq = SCNAction.sequence([rotate1, move1, rotate2, move2, move3])
                mainCharacterIdle?.parent?.runAction((chapter2Letter1MoveSeq), completionHandler: stopWalkAnimation)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                })
                
                print("move floor for chapter two")
            case chapterThree:
                //O (chapter3 - letter5)
                
                startTransitionAnimation(key: "MainCharacterSwimming")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 8)
                let chapter3Letter5RotationSeq = SCNAction.sequence([rotate1])
                mainCharacterIdle?.parent?.runAction(chapter3Letter5RotationSeq)
                
                let move1 = SCNAction.move(to: SCNVector3(-0.264, 01.353, 0.165), duration:8)  //P1 to P2
                //let rotate2 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 0.5)
                let chapter3Letter5MoveSeq = SCNAction.sequence([move1])
                mainCharacterIdle?.parent?.runAction((chapter3Letter5MoveSeq), completionHandler: stopWalkAnimation)
                
                print("move for chapter three")
            case chapterFour:
                //A (chapter4 - letter5)
                //start narration for the Ashton
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration41"]!, type: "mp3")
                })
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterJogging")
                
                //walking route to ashton
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-50)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5)
                let move1 = SCNAction.move(to: SCNVector3(-1.615 ,0 ,25.576), duration: 5)
                let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(41)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.25)
                let move2 = SCNAction.move(to: SCNVector3(28.919 ,0 ,60.701), duration: 5)
                let chapter4Letter5RotationSeq = SCNAction.sequence([rotate1, move1, rotate2, move2])
                mainCharacterIdle?.parent?.runAction((chapter4Letter5RotationSeq), completionHandler: stopWalkAnimation)
                
                //A
                print("move floor for chapter four")
                
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //-----
                
                print("move floor for chapter five")
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 6
        case .toLetter6:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //H (chapter1 - letter 6)
                
                //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                // x= (-)west/(+)east, z= (-)north/(+)south
                let rotate1 = SCNAction.rotateBy(x: 0, y: -0.1, z: 0, duration: 0.5)
                let rotatePause = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 3.5)
                let rotate2 = SCNAction.rotateBy(x: 0, y: -1.25, z: 0, duration: 0.5)
                
                let move1 = SCNAction.move(by: SCNVector3(x: 0.3,y: -0.1,z: -0.5), duration: 2)
                let move2 = SCNAction.move(by: SCNVector3(x: 0.2,y: 0.1,z: -0.5), duration: 2)
                let move3 = SCNAction.move(by: SCNVector3(x: 0.2,y: 0,z: 0), duration: 2)
                
                //Indy walking to Hannah
                let chapter1Letter6MoveSeq1_0 = SCNAction.sequence([move1, move2, move3])
                mainFloor.runAction(chapter1Letter6MoveSeq1_0)
                
                //Indy rotating to Hannah
                let chapter1Letter6MoveSeq1_1 = SCNAction.sequence([rotate1, rotatePause, rotate2])
                self.mainCharacterIdle.parent?.runAction((chapter1Letter6MoveSeq1_1))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5, execute: {
                    //Hannah stop dancing and Idle till narration done
                    [weak self] in self?.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration42"]!, type: "mp3")
                    self?.charcterFiveIdle.parent?.runAction(SCNAction.rotateBy(x: 0, y: -1.9, z: 0, duration: 0.5))
                    self?.stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    //fade out the walking sound
                    self?.FXPlayer.setVolume(0, fadeDuration: 1)
                    //stop playing the walking sound
                    self?.FXPlayer.stop()
                    self?.FXPlayer.setVolume(1, fadeDuration: 0)
                    
                    self?.stopAnimateSideCharacter(key: "SideCharacter5Dancing", sideCharacter: "Hannah")
                    self?.startAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                        //Hannah and Indy walk together to the Tree
                        
                        //hannah sequence
                        self?.stopAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
                        self?.startAnimateSideCharacter(key: "SideCharacter5Walk", sideCharacter: "Hannah")
                        self?.startTransitionAnimation(key: "MainCharacterWalking")
                        
                        //start walking sound
                        self?.toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                        
                        let hannahRotate1 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 1)
                        let hannahMove1 = SCNAction.move(to: SCNVector3(x: 21.5,y: 1.1,z: -11.2), duration: 2)
                        let hannahMove2 = SCNAction.move(to: SCNVector3(x: 19.75,y: 1.7,z: -0.65), duration: 4)
                        let hannahMove3 = SCNAction.move(to: SCNVector3(x: 21.4,y: 1.4,z: 4.7), duration: 4)
                        
                        let hannahLetter6MoveSeq = SCNAction.sequence([hannahRotate1, hannahMove1, hannahMove2, hannahMove3])
                        self?.charcterFiveIdle.parent?.runAction(hannahLetter6MoveSeq)
                        
                        //Indy sequence
                        let rotate3 = SCNAction.rotateBy(x: 0, y: -1.50, z: 0, duration: 0.5)
                        let rotatePause1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1.5)
                        let rotate4 = SCNAction.rotateBy(x: 0, y: -0.40, z: 0, duration: 0.5)
                        
                        let move3 = SCNAction.move(by: SCNVector3(x: 0.2,y: -0.1,z: 0.4), duration: 2)
                        let move4 = SCNAction.move(by: SCNVector3(x: 0.1,y: 0,z: 0.5), duration: 4)
                        let move5 = SCNAction.move(by: SCNVector3(x: -0.1,y: 0,z: 0.6), duration: 4)
                        
                        //Indy rotating to H
                        let chapter1Letter6MoveSeq2_0 = SCNAction.sequence([rotate3, rotatePause1, rotate4])
                        self?.mainCharacterIdle.parent?.runAction((chapter1Letter6MoveSeq2_0))
                        //Indy walking to H
                        let chapter1Letter6MoveSeq2 = SCNAction.sequence([move3, move4, move5])
                        self?.mainFloor.runAction((chapter1Letter6MoveSeq2), completionHandler: self?.stopWalkAnimation)

                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
                            self?.stopAnimateSideCharacter(key: "SideCharacter5Walk", sideCharacter: "Hannah")
                            self?.startAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")

                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                self?.stopAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
                                self?.startAnimateSideCharacter(key: "SideCharacter5Surprise", sideCharacter: "Hannah")
                            })
                            
                        })
                    })
                })
                
                //H
                
            case chapterTwo:
                //U (chapter2 - letter6)
                
                startTransitionAnimationOnce(key: "MainCharacterSkating")
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                // (-) = clockwise, (+) = couter-clockwise
                let move1 = SCNAction.move(to: SCNVector3(0.488, 0.194, -0.301), duration: 0.5) //D to U1
                //let rotate2 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 0.25) //rotate up
                let move2 = SCNAction.move(to: SCNVector3(0.494, 0.238, -0.21), duration: 1) //U1 to U2 slopping up
                //let rotate3 = SCNAction.rotateBy(x: 0, y: -0.75, z: 0, duration: 0.25) //rotate down (to level)
                let move3 = SCNAction.move(to: SCNVector3(0.494, 0.238, -0.189), duration: 0.25) //U2 to U
                let chapter2Letter1MoveSeq = SCNAction.sequence([move1, move2, move3])
                mainCharacterIdle?.parent?.runAction((chapter2Letter1MoveSeq), completionHandler: stopWalkAnimation)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                })
                
                print("move floor for chapter two")
            case chapterThree:
                //S (chapter3 - letter3)
                print("no letter 6 for chapter 3")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //----
                
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //---
                
                print("move floor for chapter five")
            default:
                break
            }
            
        //Finish
        //----------------------------------------------------
        //MARK: Chapter Finish
        case .chapterFinished:
            
            print("Reached the end of the chapter")
            
            switch true {
            case chapterOne:
                print("end sequence for chapter one")
            case chapterTwo:
                print("end sequence for chapter two")
            case chapterThree:
                print("end sequence for chapter three")
            case chapterFour:
                print("end sequence for chapter four")
            case chapterFive:
                print("end sequence for chapter five")
            default:
                break
            }
        }
    }
    
    func stopWalkAnimation() {
        switch gameProgress {
        //----------------------------------------------------
        //MARK: Letter 1
        case .toLetter1:
            switch true {
            case chapterFive:
                print("Prepare to shatter letter 1")
                self.shatterLetterOne = true
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        //load first letter for activityView page
                        print("Loading activity \(chapterSelectedLetterArray![0])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration5"]!, type: "mp3")
                    })
                
            case chapterFour:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //stopTransitionAnimation(key: "MainCharacterWalking")
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 1")
                    self.shatterLetterOne = true
                    //load first letter for activityView page
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                })
            case chapterThree:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro part 2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 22, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterOne = true
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2_1"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            //trasition to the activity page for the first letter
                            print("Loading activity \(chapterSelectedLetterArray![0])")
                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                            
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                        })
                    })
                })
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro part 2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2_1"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterOne = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![0])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                            
                            //wait 1 seconds for the activity page to load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                //play narration for the first audio instructions for the activity
                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                            })
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro part 2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterOne = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![0])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }

            gameProgress = .toLetter2
        //----------------------------------------------------
        //MARK: Letter 2
        case .toLetter2:
            switch true {
            case chapterFive:
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    print("Prepare to shatter letter 2")
                    self.shatterLetterTwo = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![1])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                    
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration13"]!, type: "mp3")
                    })
                
            case chapterFour:
                //transition the animation from walking to idle
                stopTransitionAnimation(key: "MainCharacterJogging")
                startTransitionAnimation(key: "MainCharacterIdle")
                //play narration for the second audio instructions for the activity
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                self.shatterLetterTwo = true
                //wait 10 seconds for the intro narration to finish
                DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                    //trasition to the activity page for the second letter
                    print("Loading activity \(chapterSelectedLetterArray![1])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                    
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration13"]!, type: "mp3")
                })
                
            case chapterThree:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopTransitionAnimation(key: "MainChracterSwimming")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterTwo = true
                        
                        self.stopTransitionAnimation(key: "MainChracterIdle")
                        self.startTransitionAnimation(key: "MainCharacterSwimming")
                        self.stopAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
                        self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
                        
                        //move to Ollie
                        let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
                        let chapter3Letter1RotationSeq = SCNAction.sequence([rotate1])
                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter1RotationSeq)
                        let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P2 to P1
                        let chapter3Letter2MoveSeq = SCNAction.sequence([move1])
                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter2MoveSeq)
                        
                        //move Quinn to Ollie
                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(79.606)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                        let chapter3Letter2RotationSeq2 = SCNAction.sequence([rotate2])
                        self.charcterTwoIdle?.parent?.runAction(chapter3Letter2RotationSeq2)
                        let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)  //P2 to P1
                        let chapter3Letter2MoveSeq2 = SCNAction.sequence([move2])
                        self.charcterTwoIdle?.parent?.runAction(chapter3Letter2MoveSeq2)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
                            self.stopTransitionAnimation(key: "MainChracterSwimming")
                            self.startTransitionAnimation(key: "MainCharacterIdle")
                            
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                            
                            //wait 1 seconds for the activity page to load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                                //trasition to the activity page for the first letter
                                print("Loading activity \(chapterSelectedLetterArray![1])")
                                self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                                
                                //play narration for the first audio instructions for the activity
                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration13"]!, type: "mp3")
                            })
                        })
                    })
                })
                
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterTwo = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![1])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    [weak self] in self?.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 2")
                        self?.shatterLetterTwo = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self?.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self?.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter3
        //----------------------------------------------------
        //MARK: Letter 3
        case .toLetter3:
            switch true {
            case chapterFive:
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    print("Prepare to shatter letter 3")
                    self.shatterLetterThree = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![2])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                    
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                })
                
            case chapterFour:
                stopTransitionAnimation(key: "MainCharacterJogging")
                startTransitionAnimation(key: "MainCharacterIdle")
                    
                //wait 1 seconds for the activity page to load
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                    print("Prepare to shatter letter 3")
                    self.shatterLetterThree = true
                    
                    //wait 6 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                    })
                })
            case chapterThree:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopTransitionAnimation(key: "MainChracterSwimming")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    //play game intro part 2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {

                        print("Set up trigger for after activityView")
                        self.shatterLetterThree = true
                        
                        self.stopTransitionAnimation(key: "MainChracterIdle")
                        self.startTransitionAnimation(key: "MainCharacterSwimming")
                        
                        //move to Ollie
                        let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
                        let chapter3Letter3RotationSeq = SCNAction.sequence([rotate1])
                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter3RotationSeq)
                        let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P1 to P2
                        let chapter3Letter3MoveSeq = SCNAction.sequence([move1])
                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter3MoveSeq)
                        
                        //move Simon to Ollie
                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(79.606)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 3)
                        let chapter3Letter3RotationSeq2 = SCNAction.sequence([rotate2])
                        self.charcterThreeIdle?.parent?.runAction(chapter3Letter3RotationSeq2)
                        let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)  //P1 to P2
                        let chapter3Letter3MoveSeq2 = SCNAction.sequence([move2])
                        self.charcterThreeIdle?.parent?.runAction(chapter3Letter3MoveSeq2)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
                            self.stopTransitionAnimation(key: "MainChracterSwimming")
                            self.startTransitionAnimation(key: "MainCharacterIdle")
                            
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                            
                            //wait 1 seconds for the activity page to load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                                //trasition to the activity page for the first letter
                                print("Loading activity \(chapterSelectedLetterArray![2])")
                                self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                                
                                //play narration for the first audio instructions for the activity
                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                            })
                        })
                    })
                })
             
                
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterThree = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![2])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 3")
                        self.shatterLetterThree = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter4
        //----------------------------------------------------
        //MARK: Letter 4
        case .toLetter4:
            switch true {
            case chapterFive:
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration30"]!, type: "mp3")
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    print("Prepare to shatter letter 4")
                    self.shatterLetterFour = true
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration31"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                    })
                })
                
            case chapterFour:
                stopTransitionAnimation(key: "MainCharacterJogging")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //wait 1 seconds for the activity page to load
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration31"]!, type: "mp3")
                    print("Prepare to shatter letter 4")
                    self.shatterLetterFour = true
                    
                    //wait 6 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                    })
                })
                
            case chapterThree:
                //Jillian the Jellyfish
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopTransitionAnimation(key: "MainChracterSwimming")
                    self.startTransitionAnimation(key: "MainCharacterIdle")

                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration24"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                        
                        print("Set up trigger for after activityView")
                        self.shatterLetterFour = true
                        
                        //Gary touches Jillian
                        let ratationGary1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-173.658)), y: CGFloat(GLKMathDegreesToRadians(54.663)), z: CGFloat(GLKMathDegreesToRadians(-165.956)), duration: 1)
                        let moveGary1 = SCNAction.move(to: SCNVector3(-0.299,0.21,-0.435), duration: 1)
                        let moveToJillian = SCNAction.sequence([ratationGary1, moveGary1])
                        self.mainCharacterIdle?.parent?.runAction(moveToJillian)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            //Gary is shocked
                            //self.mainCharacterIdle.animationPlayer(forKey: "MainCharacterShocked")?.speed = 3.0
                            self.stopTransitionAnimation(key: "MainCharacterSwimming")
                            self.startTransitionAnimation(key: "MainCharacterShocked")
                            self.toggleAudioFXFile(file: "Electrocuted", type: "mp3", rate: 1)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                //Gary and Jillian move back away from each other
                                self.stopTransitionAnimation(key: "MainCharacterShocked")
                                self.startTransitionAnimation(key: "MainCharacterSwimming")
                                self.stopAnimateSideCharacter(key: "SideCharacter4Sleeping", sideCharacter: "Jillian")
                                self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                                //Gary move
                                let rotationGary2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-163.287)), y: CGFloat(GLKMathDegreesToRadians(27.438)), z: CGFloat(GLKMathDegreesToRadians(-146.911)), duration: 1)
                                let moveGary2 = SCNAction.move(to: SCNVector3(-0.246, 0.254, -0.371), duration: 1)
                                let moveAwayfromJillian = SCNAction.sequence([moveGary2, rotationGary2])
                                self.mainCharacterIdle?.parent?.runAction(moveAwayfromJillian)
                                //Jillian move
                                let moveJillian = SCNAction.move(to: SCNVector3(-0.396,0.198,-0.466), duration: 1)
                                let rotationJillian = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                                let moveAwayfromGary = SCNAction.sequence([moveJillian, rotationJillian])
                                self.charcterFourIdle?.parent?.runAction(moveAwayfromGary)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration25"]!, type: "mp3")
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 25, execute: {
                                        //move to Gary to Top
                                        self.stopTransitionAnimation(key: "MainCharacterIdle")
                                        self.startTransitionAnimation(key: "MainCharacterSwimming")
                                        let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
                                        let chapter3Letter4RotationSeq = SCNAction.sequence([rotate1])
                                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter4RotationSeq)
                                        let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P1 to P2
                                        let chapter3Letter4MoveSeq = SCNAction.sequence([move1])
                                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter4MoveSeq)
                                        
                                        //move Jillian to Top
                                        self.stopAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                                        self.startAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
                                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 3)
                                        let chapter3Letter4RotationSeq2 = SCNAction.sequence([rotate2])
                                        self.charcterFourIdle?.parent?.runAction(chapter3Letter4RotationSeq2)
                                        let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)
                                        let chapter3Letter4MoveSeq2 = SCNAction.sequence([move2])
                                        self.charcterFourIdle?.parent?.runAction(chapter3Letter4MoveSeq2)
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
                                            self.stopTransitionAnimation(key: "MainChracterSwimming")
                                            self.startTransitionAnimation(key: "MainCharacterIdle")
                                            self.stopAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
                                            self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                                            
                                            //play narration for the first audio instructions for the activity
                                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration26"]!, type: "mp3")
                                            
                                            //wait 1 seconds for the activity page to load
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                                                //trasition to the activity page for the first letter
                                                print("Loading activity \(chapterSelectedLetterArray![3])")
                                                self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                                                
                                                //play narration for the first audio instructions for the activity
                                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration27"]!, type: "mp3")
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
                
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterFour = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![3])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration24"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration25"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                ///wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration24"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 4")
                        self.shatterLetterFour = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration25"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter5
        //----------------------------------------------------
        //MARK: Letter 5
        case .toLetter5:
            switch true {
            case chapterFive:
                stopTransitionAnimation(key: "MainCharacterWalking")
            case chapterFour:
                stopTransitionAnimation(key: "MainCharacterJogging")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //wait 1 seconds for the activity page to load
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration42"]!, type: "mp3")
                    print("Prepare to shatter letter 5")
                    self.shatterLetterFive = true
                    
                    //wait 6 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        //trasition to the activity page for the fifth letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration43"]!, type: "mp3")
                    })
                })
                
            case chapterThree:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //convince Ollie to swimm
                    print("Prepare to shatter letter 1")
                    self.shatterLetterFive = true
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                    
                    //wait 3 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration33"]!, type: "mp3")
                    })
                })
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterFive = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![4])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration33"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                //wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 5")
                        self.shatterLetterFive = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])

                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration33"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter6
        //----------------------------------------------------
        //MARK: Letter 6
        case .toLetter6:
            switch true {
            case chapterFive:
                stopTransitionAnimation(key: "MainCharacterWalking")
            case chapterFour:
                stopTransitionAnimation(key: "MainCharacterWalking")
            case chapterThree:
                stopTransitionAnimation(key: "MainCharacterWalking")
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterSix = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![5])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration44"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration45"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration44"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 6")
                        self.shatterLetterSix = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![5])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration45"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .chapterFinished
        //----------------------------------------------------
        case .chapterFinished:
            
            //finish chapter stuff
            print("Finish Chapter after animation stopped")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish"]!, type: "mp3")
//            })
            
            //TODO: trigger finishing event
        }
    }
    
    func playShatterAnimation() {
        switch true {
        //----------------------------------------------------
        //MARK: Letter 6
        case shatterLetterSix:
            switch true{
            case chapterFive:
                letterOne!.isPaused = false
                animateLetterHide(fadeThis: letterOne!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            case chapterFour:
                letterOne!.isPaused = false
                animateLetterHide(fadeThis: letterOne!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            case chapterThree:
                print("Nothing to shatter for this chapter")
                print("not 6 letters in this chapter")

            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterU")
                        
                        //after the U trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                            //after the final animation, play the fishing narration
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish"]!, type: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
                                    self.resetGame()
                            })
                        })
                    })
                })
            case chapterOne:
                //francine stop idle /dancing
                self.stopAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Francine")
                self.startAnimateSideCharacter(key: "SideCharacter3Dance2", sideCharacter: "Francine")
                
                //maincharacter start dancing
                self.startTransitionAnimation(key: "MainCharacterDance")
                
                //hanna stop surprise/start dancing
                self.stopAnimateSideCharacter(key: "SideCharacter5Surprise", sideCharacter: "Hannah")
                self.startAnimateSideCharacter(key: "SideCharacter5Dance", sideCharacter: "Hannah")
                
                //terry stop waving and start dancing
                self.stopAnimateSideCharacter(key: "SideCharacter1Waving", sideCharacter: "Terry")
                self.startAnimateSideCharacter(key: "SideCharacter1Dancing", sideCharacter: "Terry")
                
                letterSix!.isPaused = false
                animateLetterHide(fadeThis: letterSix!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 5
        case shatterLetterFive:
            switch true{
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone gets put back together again")
                
            case chapterFour:
                //letter A completed, finishing chapter narration
                print("Nothing to shatter for this chapter")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish1"]!, type: "mp3")
                    //Keelie fixed Ashton
                    self.stopAnimateSideCharacter(key: "SideCharacter5Problem", sideCharacter: "Ashton")
                    self.startAnimateSideCharacter(key: "SideCharacter5Happy", sideCharacter: "Ashton")
                    
                    //show brace on Ashton
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        let brace = self.charcterFiveIdle.childNode(withName: "Brace", recursively: true)
                        brace!.isHidden = false
                        
                        //play last narration for chapter
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish2"]!, type: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                                self.resetGame()
                            })
                        })
                    })
                })
            case chapterThree:
                //letter J completed, finishing narration
                print("Nothing to shatter for this chapter")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish1"]!, type: "mp3")
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle4", sideCharacter: "Ollie")
                    self.startAnimateSideCharacter(key: "SideCharacter1Idle5", sideCharacter: "Ollie")
                    
                    self.charcterOneIdle.parent?.runAction(SCNAction.rotateBy(x: CGFloat(GLKMathDegreesToRadians(-5)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5))
                    let moveOllieFinish = SCNVector3(x: 0, y: 1.339, z: 0.168)
                    self.charcterOneIdle.parent?.runAction(SCNAction.move(to: moveOllieFinish, duration: 2))
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish2"]!, type: "mp3")
                        self.stopAnimateSideCharacter(key: "SideCharacter1Idle5", sideCharacter: "Ollie")
                        self.startAnimateSideCharacter(key: "SideCharacter1Twirl", sideCharacter: "Ollie")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                            self.resetGame()
                        })
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterD")
                        
                        //after the D trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15.5, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
                //drop Eric down from letter E
                self.startAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
                //play for 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.5, execute: {
                    //set new position for Eric's transform where the next animation will begin
                    //self.charcterFourIdle.parent?.position = SCNVector3(6.25, 1.2, -4.7)
                    
                    //play Eric through a sequence of movements so he turns and then walks to the Letter H
//                    let endSpot = SCNVector3(x: 19.5, y: 2.5, z: 7.5)
//                    let move1 = SCNAction.move(to: endSpot, duration: 10)
//                    let rotate2 = SCNAction.rotateBy(x: 0.0, y: 1.75, z: 0.0, duration: 0.5)
//                    let ericMoveSeq = SCNAction.sequence([move1, rotate2])
//                    self.charcterFourIdle.parent?.runAction(ericMoveSeq)
                
                    //play side character animation
//                    self.stopAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
//                    self.startAnimateSideCharacter(key: "SideCharacter4Walk", sideCharacter: "Eric")
                    
                    self.letterFive!.isPaused = false
                    self.animateLetterHide(fadeThis: self.letterFive!)
                    self.toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
                    
                    //wait 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                        self.stopAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
                        self.startAnimateSideCharacter(key: "SideCharacter4Dance1", sideCharacter: "Eric")
                        self.charcterFourIdle.parent?.position = SCNVector3(x: 19.5, y: 2, z: 7.5)
                        self.charcterFourIdle.parent?.eulerAngles = SCNVector3(x: 0, y: GLKMathDegreesToRadians(180), z: 0)
                    })
                })
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 4
        case shatterLetterFour:
            switch true{
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone gets put back together again")
                
                //show empty Xylophone
                let xylophone_4 = self.mainCharacterIdle.childNode(withName: "xylophone_4 reference", recursively: true)
                xylophone_4!.isHidden = false
                
                //hide busted xylophone
                let xylophone_3 = self.mainCharacterIdle.childNode(withName: "xylophone_3 reference", recursively: true)
                xylophone_3!.isHidden = true
                
                //"xylophone back together"
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish1"]!, type: "mp3")
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish2"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        self.resetGame()
                    })
                })
            case chapterFour:
                //letter M completed, starting letter A
                print("Nothing to shatter for this chapter")
                print("Keelie fixes Manny")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration40"]!, type: "mp3")
                    
                    self.stopAnimateSideCharacter(key: "SideCharacter4Problem", sideCharacter: "Manny")
                    self.startAnimateSideCharacter(key: "SideCharacter4Happy", sideCharacter: "Manny")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterThree:
                //letter J completed, starting letter O
                print("Nothing to shatter for this chapter")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration31"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                    self.startAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
                    //Jillian leaves
                    let rotateJillian = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                    let chapter3Letter4RotationJillian = SCNAction.sequence([rotateJillian])
                    self.charcterFourIdle?.parent?.runAction(chapter3Letter4RotationJillian)
                        
                    let moveJillian = SCNAction.move(to: SCNVector3(-0.369, 0.198, -0.445), duration: 8)  //P1 to P2
                    let chapter3Letter4MoveJillian = SCNAction.sequence([moveJillian])
                    self.charcterFourIdle?.parent?.runAction(chapter3Letter4MoveJillian)
                    
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        print("Starting MainCharacterC trick")
                        self.startTransitionAnimationOnce(key: "MainCharacterC")
                        
                        //after the C trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 13.5, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
                letterFour!.isPaused = false
                animateLetterHide(fadeThis: letterFour!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
                
                //drop side Francine down from letter F
                let rotateTo0 = SCNAction.rotateTo(x: 0, y: 3.5, z: 0, duration: 0.1)
                let moveOut = SCNAction.moveBy(x:0, y: 0, z: -2.5, duration: 0.5)
                let moveDown = SCNAction.moveBy(x:0, y: -2.2, z: -0.5, duration: 0.5)
                let francineMoveSeq0 = SCNAction.sequence([rotateTo0, moveOut, moveDown])
                self.charcterThreeIdle.parent?.runAction(francineMoveSeq0)
                self.startAnimateSideCharacter(key: "SideCharacter3Jump", sideCharacter: "Francine")
                
                //play for 2.5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter3Jump", sideCharacter: "Francine")
                    self.startAnimateSideCharacter(key: "SideCharacter3Walk", sideCharacter: "Francine")
                    
                    //Francine walks to Indy after the jump - Left turn and walk for 0.5 seconds
                    let rotate1 = SCNAction.rotateBy(x: 0.0, y: 1.5, z: 0.0, duration: 0.5)
                    let endSpot1 = SCNVector3(x: 2, y: 1.5, z: 9.0)
                    let move1 = SCNAction.move(to: endSpot1, duration: 1.5)
                    let francineMoveSeq1 = SCNAction.sequence([rotate1, move1])
                    self.charcterThreeIdle.parent?.runAction(francineMoveSeq1)
                    
                    //play for 3 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.1, execute: {
                        self.stopAnimateSideCharacter(key: "SideCharacter3Walk", sideCharacter: "Francine")
                        self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Francine")
                        
                        //wait 5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //play Lin through a sequence of movements so he turns and then walks to the Letter H
                            let rotate2 = SCNAction.rotateBy(x: 0.0, y: -2.9, z: 0.0, duration: 0.5)
                            let endSpot2p2 = SCNVector3(x: 18.5, y: 2.25, z: 12.25)
                            let move2 = SCNAction.moveBy(x:10, y: 0, z: 0, duration: 5)
                            let move3 = SCNAction.move(to: endSpot2p2, duration: 5)
                            let rotate3 = SCNAction.rotateBy(x: 0.0, y: 1.75, z: 0.0, duration: 0.5)
                            let francineMoveSeq2 = SCNAction.sequence([rotate2, move2, move3, rotate3])
                            self.charcterThreeIdle.parent?.runAction(francineMoveSeq2)
                            //play side character animation
                            self.stopAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Francine")
                            self.startAnimateSideCharacter(key: "SideCharacter3Walk", sideCharacter: "Francine")
                            
                            //wait 5 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                                self.stopAnimateSideCharacter(key: "SideCharacter3Walk", sideCharacter: "Francine")
                                self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Francine")
                            })
                        })
                    })
                })
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 3
        case shatterLetterThree:
            switch true{
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone gets Yarn for mallet")
                //show mallet head
                let malletHead = self.mainCharacterIdle.childNode(withName: "Head", recursively: true)
                malletHead!.isHidden = false
                
                //"we now have all the yarn we need"
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration29"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    self.playWalkAnimation()
                })
            case chapterFour:
                //letter W completed, starting letter M
                print("Nothing to shatter for this chapter")
                print("Keelie fixes Wallace")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration29"]!, type: "mp3")
                    
                    //Keelie helps Velma
                    self.stopAnimateSideCharacter(key: "SideCharacter2Problem", sideCharacter: "Wallace")
                    self.startAnimateSideCharacter(key: "SideCharacter2Happy", sideCharacter: "Wallace")
                    
                    self.stopAnimateSideCharacter(key: "SideCharacter3Comforting", sideCharacter: "Winona")
                    self.startAnimateSideCharacter(key: "SideCharacter3Clapping", sideCharacter: "Winona")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterThree:
                //letter S completed, starting letter J
                print("Nothing to shatter for this chapter")
                print("Ollie relaxes a little")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle3", sideCharacter: "Ollie")
                    self.startAnimateSideCharacter(key: "SideCharacter1Idle4", sideCharacter: "Ollie")
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration23"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 27, execute: {
                    //Simon leaves
                    let rotateSimon = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 8)
                    let chapter3Letter3RotationSimon = SCNAction.sequence([rotateSimon])
                    self.charcterThreeIdle?.parent?.runAction(chapter3Letter3RotationSimon)
                    let moveSimon = SCNAction.move(to: SCNVector3(0.41, 0.23, 0.6), duration: 8)  //P2 to P1
                    let chapter3Letter3MoveSimon = SCNAction.sequence([moveSimon])
                    self.charcterThreeIdle?.parent?.runAction(chapter3Letter3MoveSimon)
                    
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterB")
                        
                        //after the B trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
                letterThree!.isPaused = false
                animateLetterHide(fadeThis: letterThree!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    //drop side Lin down from letter L
                    self.charcterTwoIdle.parent?.runAction(SCNAction.moveBy(x:0, y: -0.8, z: 0, duration: 0.5))
                    
                    //wait 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                        //play Lin through a sequence of movements so he turns and then walks to the Letter H
                        let rotate1 = SCNAction.rotateBy(x: 0.0, y: 1.5, z: 0.0, duration: 0.5)
                        let endSpot = SCNVector3(x: 21, y: 2, z: 9.5)
                        let move1 = SCNAction.move(to: endSpot, duration: 15)
                        let rotate2 = SCNAction.rotateBy(x: 0.0, y: 2, z: 0.0, duration: 0.5)
                        let linMoveSeq = SCNAction.sequence([rotate1, move1, rotate2])
                        self.charcterTwoIdle.parent?.runAction(linMoveSeq)
                        
                        //play side character animation
                        //self.startAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Lin")
                        //TO-DO: Fix Bone structure for Lin so that transitions of animations work correctly
                        
                        //wait 5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                            
                            //TO-DO: Fix Bone structure for Lin so that transitions of animations work correctly
                            //self.stopAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Lin")
                            //self.startAnimateSideCharacter(key: "SideCharacter2Dancing", sideCharacter: "Lin")
                        })
                    })
                })
            default:
                break
            }
       //----------------------------------------------------
        //MARK: Letter 2
        case shatterLetterTwo:
            switch true{
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone gets zebra stripes")
                
                //show empty Xylophone
                let xylophone_3 = self.mainCharacterIdle.childNode(withName: "xylophone_3 reference", recursively: true)
                xylophone_3!.isHidden = false
                
                //hide busted xylophone
                let xylophone_2 = self.mainCharacterIdle.childNode(withName: "xylophone_2 reference", recursively: true)
                xylophone_2!.isHidden = true
                
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                    self.playWalkAnimation()
                })
                
            case chapterFour:
                print("Nothing to shatter for this chapter")
                print("Keelie fixes Velma")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                    
                    //Keelie helps Velma
                    self.stopAnimateSideCharacter(key: "SideCharacter1Problem", sideCharacter: "Velma")
                    self.startAnimateSideCharacter(key: "SideCharacter1Happy", sideCharacter: "Velma")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        self.playWalkAnimation()
                    })
                })
                
            case chapterThree:
                //letter Q completed, starting letter S
                print("Nothing to shatter for this chapter")
                print("Ollie relaxes a little")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle2", sideCharacter: "Ollie")
                    self.startAnimateSideCharacter(key: "SideCharacter1Idle3", sideCharacter: "Ollie")
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                    self.stopAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
                    self.startAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                        self.stopAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
                        self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                            //Quinn leaves
                            let rotateQuinn = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                            let chapter3Letter2RotationQuinn = SCNAction.sequence([rotateQuinn])
                            self.charcterTwoIdle?.parent?.runAction(chapter3Letter2RotationQuinn)
                            let moveQuinn = SCNAction.move(to: SCNVector3(-0.226, 0.05, 0.237), duration: 8)  //P1 to P2
                            let chapter3Letter2MoveQuinn = SCNAction.sequence([moveQuinn])
                            self.charcterTwoIdle?.parent?.runAction(chapter3Letter2MoveQuinn)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                self.playWalkAnimation()
                            })
                        })
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterR")
                        
                        //after the R trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
                letterTwo!.isPaused = false
                animateLetterHide(fadeThis: letterTwo!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    //drop side terry down from the top of the letter T
                    self.charcterOneIdle.parent?.runAction(SCNAction.moveBy(x:0, y: -4.1, z: 0.2, duration: 1))

                    //wait 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        //play Terry through a sequence of movements so he turns and then walks to the Letter H
                        let rotate1 = SCNAction.rotateBy(x: 0.0, y: 1.75, z: 0.0, duration: 0.5)
                        let endSpot = SCNVector3(x: 18, y: 2.5, z: 10)
                        let move1 = SCNAction.move(to: endSpot, duration: 15)
                        let rotate2 = SCNAction.rotateBy(x: 0.0, y: 1.75, z: 0.0, duration: 0.5)
                        let terryMoveSeq = SCNAction.sequence([rotate1, move1, rotate2])
                        self.charcterOneIdle.parent?.runAction(terryMoveSeq)
                        
                        //play side character animation
                        self.startAnimateSideCharacter(key: "SideCharacter1Walking", sideCharacter: "Terry")
                        
                        //wait 5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                            self.stopAnimateSideCharacter(key: "SideCharacter1Walking", sideCharacter: "Terry")
                            self.startAnimateSideCharacter(key: "SideCharacter1Waving", sideCharacter: "Terry")
                        })
                    })
                })
            default:
                break
            }
        //----------------------------------------------------
        //MARK: Letter 1
        case shatterLetterOne:
            switch true{
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone get nail pegs")
                
                    //show empty Xylophone
                    let xylophone_2 = self.mainCharacterIdle.childNode(withName: "xylophone_2 reference", recursively: true)
                    xylophone_2!.isHidden = false
                    
                    //hide busted xylophone
                    let xylophone_1 = self.mainCharacterIdle.childNode(withName: "xylophone_1 reference", recursively: true)
                    xylophone_1!.isHidden = true
            
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
                        self.playWalkAnimation()
                    })
            case chapterFour:
                print("Nothing to shatter for this chapter")
                print("Character gets coat on")
                //letterOne!.isPaused = false
                //animateLetterHide(fadeThis: letterOne!)
                //toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    let coat = self.mainCharacterIdle.childNode(withName: "Coat", recursively: true)
                    coat?.isHidden = false
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterThree:
                //letter G completed, starting letter Q
                print("Nothing to shatter for this chapter")
                print("Ollie relaxes a little")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle1", sideCharacter: "Ollie")
                    self.startAnimateSideCharacter(key: "SideCharacter1Idle2", sideCharacter: "Ollie")
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration10"]!, type: "mp3")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterP")
                        
                        //after the P trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
                            self.playWalkAnimation()
                            })
                        })
                    })
            case chapterOne:
                letterOne!.isPaused = false
                animateLetterHide(fadeThis: letterOne!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            default:
                break
            }
            
        default:
            break
        }
    }
    
    func animateLetterHide(fadeThis: SCNNode){
        //Play finishing narration for each letter
        switch self.gameProgress {
        case .toLetter1 :
            print("Do nothing")
        case .toLetter2:
            print("Do nothing")
        case .toLetter3:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                //play game intro 1
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["letter2Finish"]!, type: "mp3")
            })
        case .toLetter4:
            //play narration for finishing letter 4
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["letter3Finish"]!, type: "mp3")
                })
        case .toLetter5:
            //play narration for finishing letter 5
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["letter4Finish"]!, type: "mp3")
                    })
        case .toLetter6:
            //play narration for finishing letter 6
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["letter5Finish"]!, type: "mp3")
                    })
        case .chapterFinished :
            //play narration for finishing the chapter
           DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["letter6Finish"]!, type: "mp3")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish"]!, type: "mp3")
                    })
            })
        }

        //wait 3 seconds and then fade the letter out to 0 opacity
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            fadeThis.runAction(SCNAction.fadeOpacity(to: 0, duration: 4))
            
            //have the main character walk to the next letter
            DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                if self.gameProgress != .chapterFinished {
                    self.playWalkAnimation()
                }
                else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
                        self.resetGame()
                        })
                }
            })
        })
    }
    
    func storyTime(){
        //Wait 3 second for game to load completely
        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
            
            //add extra narration based on chapter
            switch true {
            case chapterOne:
                self.startTransitionAnimation(key: "MainCharacterIdle")
                print(self.mainCharacterIdle.name!, "is now idle")
                //play game intro 1
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
                
                //wait 7 seconds for the game intro1 to finish
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    //move the main character to the first letter
                    self.playWalkAnimation()
                })
            case chapterTwo:
                self.startTransitionAnimation(key: "MainCharacterIdle")

                //play game intro 1
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
               DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                    //show the different outfits that you can pick
                    for node in self.charcterOneIdle.childNodes {
                        node.isHidden = false
                    }
                    for node in self.charcterTwoIdle.childNodes {
                        node.isHidden = false
                    }
                    for node in self.charcterThreeIdle.childNodes {
                        node.isHidden = false
                    }
                    for node in self.charcterFourIdle.childNodes {
                        node.isHidden = false
                    }
                })
                
            case chapterThree:
                self.startTransitionAnimation(key: "MainCharacterIdle")
                //play game intro 1
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                        //move the main character to the first letter
                        self.playWalkAnimation()
                })
                print("Starting chapter three")
            case chapterFour:
                self.startTransitionAnimation(key: "MainCharacterWaving")
                //play game intro 1
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
                    //move the main character to the first letter
                    self.playWalkAnimation()
                })
                print("Starting chapter four")
            case chapterFive:
                //play game intro 1
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    //move the main character to the first letter
                    self.playWalkAnimation()
                })
                
            default:
                break
            }
        })
    }
    
//    func waitforOutfitPicked(){
//        //switch case setup for possible hit test results and the output for each to the debug log
//        print("The last item tapped was: \(String(describing: lastTapped))")
//
//        switch self.lastTapped?.parent?.name {
//        case "SideCharacter1":
//            //boxNode!.addChildNode(pcNode!)
//            //pcNode?.isHidden = false
//            //backButton?.isHidden = false
//            print("do stuff when you click on SideCharacter1")
//            return
//        case "SideCharacter2":
//            //boxNode!.addChildNode(pcNode!)
//            //pcNode?.isHidden = false
//            //backButton?.isHidden = false
//            print("do stuff when you click on SideCharacter2")
//            return
//        case "SideCharacter3":
//            //sphereNode!.addChildNode(exitNode!)
//            //exitNode?.isHidden = false
//            //backButton?.isHidden = false
//            print("do stuff when you click on SideCharacter3")
//            return
//        case "SideCharacter4":
//            //CM.isHidden = false
//            //backButton?.isHidden = false
//            print("do stuff when you click on SideCharacter4")
//            return
//        default:
//            return
//        }
//    }
    
    //pass it an audiofile and it will play it!
    func toggleAudioNarrationFile(file: String, type: String) {
        //get the url
        let audio1Path = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        //make sure we have the path, otherwise abort
        guard audio1Path != nil else { return }
        
        do
        {
            if narrationPlayer == AVPlayer(url: URL(fileURLWithPath: audio1Path!)){
                print("Stoping narrationPlayer")
                narrationPlayer.stop()
            }
            
            try narrationPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio1Path!))
            narrationPlayer.play()
            
        } catch {
            print("AudioPlayer not available!")
        }
    }
    
    //pass it an audiofile and it will play it!
    func toggleAudioFXFile(file: String, type: String, rate: Float) {
        let audio2Path = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        do
        {
            if FXPlayer == AVPlayer(url: URL(fileURLWithPath: audio2Path!)){
                print("Stoping FXPlayer")
                FXPlayer.stop()
            }
            
            try FXPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio2Path!))
            FXPlayer.enableRate = true
            FXPlayer.rate = rate
            FXPlayer.setVolume(0.5, fadeDuration: 0)
            self.FXPlayer.play()
            
        } catch {
            print("FXPlayer not available!")
        }
    }
    
    //pass it an audiofile and it will play/stop it!
    func toggleAudioBGFile(file: String, type: String) {
        var audio3Path = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        do
        {
            if BGPlayer == AVPlayer(url: URL(fileURLWithPath: audio3Path!)){
                print("Stoping BGPlayer")
                BGPlayer.stop()
            }
            
            try BGPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio3Path!))
            //set BGPlayer to play infinitly (-1)
            BGPlayer.numberOfLoops = -1
            BGPlayer.play()
            
        } catch {
            print("BGPlayer not available!")
        }
    }
    
    //pass it an audiofile and it will play it!
    func toggleAudioCharacterFile(file: String, type: String) {
        let audio4Path = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        do
        {
            if CharacterPlayer == AVPlayer(url: URL(fileURLWithPath: audio4Path!)){
                print("Stoping characterPlayer")
                CharacterPlayer.stop()
            }
            
            try CharacterPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio4Path!))
            self.CharacterPlayer.play()
            
        } catch {
            print("CharacterPlayer not available!")
        }
    }
    
    
    func loadActivityLetter(activityString: String) {
        
        print("loadActivityLetter is loading ", activityString)
        selectedActivity = activityString
        
        //switch to the Letter A ViewController
        let activityBoardView = self.storyboard?.instantiateViewController(withIdentifier: "ActivityBoardViewController") as! activityViewController
        self.present(activityBoardView, animated: true)
    }
    
    func startAnimateSideCharacter(key: String, sideCharacter: String) {
        print("Adding animation \(key) for \(sideCharacter)!")
        
        switch sideCharacter {
        case "Terry", "Ollie", "Velma":
            print("Do sideCharacter1 stuff")
            charcterOneIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Lin", "Quinn", "Wallace":
            print("Do sideCharacter2 stuff")
        charcterTwoIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Francine", "Simon", "Winona":
            print("Do sideCharacter3 stuff")
            charcterThreeIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Eric", "Jillian", "Manny":
            print("Do sideCharacter4 stuff")
            charcterFourIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Hannah", "InnerTube", "Ashton":
            print("Do sideCharacter5 stuff")
            charcterFiveIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Indy", "Gary", "Keelie":
            print("Do mainCharacter stuff")
            mainCharacterIdle?.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        default:
            break
        }
    }
    func stopAnimateSideCharacter(key: String, sideCharacter: String) {
        switch sideCharacter {
        case "Terry", "Ollie", "Velma":
            print("Remove stuff")
            charcterOneIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
            //charcterOneIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Lin", "Quinn", "Wallace":
            print("Remove stuff")
            //charcterTwoIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterTwoIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Francine", "Simon", "Winona":
            print("Remove stuff")
            //charcterThreeIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterThreeIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Eric", "Jillian", "Manny":
            print("Remove stuff")
            //charcterFourIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterFourIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Hannah", "InnerTube", "Ashton":
            print("Remove stuff")
            //charcterFiveIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterFiveIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Indy", "Gary", "Keelie":
            print("Remove stuff")
            //mainCharacterIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            mainCharacterIdle?.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        default:
            break
        }
    }
}

extension ViewController : ARSCNViewDelegate {
    
    // MARK: - SceneKit Management
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.updateStatus()
            self.updateFocusNode()
        }
    }
    
    // MARK: - AR Session State Management
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
            self.trackingStatus = "Tacking:  Not available!"
            break
        case .normal:
            self.trackingStatus = "" // Tracking Normal
            break
        case .limited(let reason):
            switch reason {
            case .excessiveMotion:
                self.trackingStatus = "Tracking: Limited due to excessive motion!"
                break
            case .insufficientFeatures:
                self.trackingStatus = "Tracking: Limited due to insufficient features!"
                break
            case .relocalizing:
                self.trackingStatus = "Tracking: Resuming..."
                break
            case .initializing:
                self.trackingStatus = "Tracking: Initializing..."
            default:
                break
            }
        }
    }
    
    // MARK: - AR Session Error Managent
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        self.trackingStatus = "AR Session Failure: \(error)"
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        self.trackingStatus = "AR Session Was Interrupted!"
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        self.trackingStatus = "AR Session Interruption Ended"
        self.resetGame()
    }
    
    // MARK: - Plane Management
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            let planeNode = self.createARPlaneNode(
                planeAnchor: planeAnchor,
                color: UIColor.blue.withAlphaComponent(0))
            node.addChildNode(planeNode)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            self.updateARPlaneNode(
                planeNode: node.childNodes[0],
                planeAchor: planeAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            self.removeARPlaneNode(node: node)
        }
    }
}
