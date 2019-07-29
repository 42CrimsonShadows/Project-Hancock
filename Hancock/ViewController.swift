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
    
    let chapSelection = ChapterSelection()
    
    //MARK: - OUTLETS
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var stuNameTextFeild: UITextField!
    @IBOutlet weak var stuDOBTextField: UITextField!
    @IBOutlet weak var stuGradeTextField: UITextField!
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
    //MARK: ACTIONS
    @IBAction func goToActivity(_ sender: Any) {
        //let activityBoardView = self.storyboard?.instantiateViewController(withIdentifier: "ActivityBoardViewController") as! activityViewController
        //self.present(activityBoardView, animated: true)
        
        stopAnimation()
    }
    @IBAction func setStudentInfo(_ sender: UIButton) {
    }
    @IBAction func startButtonPressed(_ sender: Any) {
        self.startGame()
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        self.resetGame()
    }
    
    @IBAction func showAllButtonPressed(_ sender: Any) {
        //toggle the showall button
        if storymask.isHidden == true {
            storymask.isHidden = false
        }
        else{
            storymask.isHidden = true
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
    var mainCharacterMoving: SCNNode!
    var mainFloor: SCNNode!
    var storymask: SCNNode!
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterNodeArray = chapterSelectedNodeArray
        self.initSceneView()
        self.initScene()
        self.initARSession()
        self.loadModels(chapterNode: chapterNodeArray!)
        self.referenceMainNodes()
        
        //setup audio player
        let walkAudioPath = Bundle.main.path(forResource: "Gravel and Grass Walk", ofType: "wav", inDirectory: "art.scnassets/Sounds")
        let birdsAudioPath = Bundle.main.path(forResource: "Birds2", ofType: "wav", inDirectory: "art.scnassets/Sounds")
        do
        {
            try walkPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: walkAudioPath!))
            walkPlayer.enableRate = true
            walkPlayer.rate = 0.5
            
            try birdsPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: birdsAudioPath!))
            
        } catch {
            print("WalkPlayer not available!")
        }
        
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
        //(will only happen is a letter shatter boolean is true and ready)
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
    
    // MARK: Init Functions
    
    func initSceneView() {
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.showsStatistics = true
        sceneView.preferredFramesPerSecond = 60
        sceneView.antialiasingMode = .multisampling2X
        sceneView.debugOptions = [
            ARSCNDebugOptions.showFeaturePoints,
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
    
    // MARK: Helper Functions
    
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
    
    // MARK: Update Functions
    
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
    
    // MARK: Game Management
    
    func startGame() {
        guard self.gameState == .hitStartToPlay else { return }
        DispatchQueue.main.async {
            self.updatePositions()
            self.rootStoryNode.isHidden = false
            self.mainCharacterIdle.isHidden = false
            
            self.startButton.isHidden = true
            self.gameState = .playGame
            self.birdsPlayer.play()
            //set birdsplayer to play infinitly (-1)
            self.birdsPlayer.numberOfLoops = -1
        }
        storyTime()
    }
    
    func resetGame(){
        guard self.gameState == .playGame else { return }
        DispatchQueue.main.async {
            //hide the main nodes
            self.rootStoryNode.isHidden = true
            self.mainCharacterIdle.isHidden = true
            self.mainCharacterMoving.isHidden = true
            
            //change game state and show start button
            self.startButton.isHidden = false
            self.gameState = .detectSurface
            
            //stop all sound
            self.birdsPlayer.stop()
            self.walkPlayer.stop()
            self.narrationPlayer.stop()
            
            //stop all animations
            self.stopAnimation()
            //self.stopAnimation2()
            self.shatterLetterOne = false
            
            //reset positions/rotations of all moved nodes
            self.mainFloor.position = SCNVector3(-0.749, 0, 2.292)
            self.mainCharacterMoving.position = SCNVector3(0, 0, 0)
            self.mainCharacterMoving.eulerAngles = SCNVector3(0, 0, 0)
            self.mainCharacterIdle.position = SCNVector3(0, 0, 0)
            self.mainCharacterIdle.eulerAngles = SCNVector3(0, 0, 0)
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
    
    func referenceMainNodes() {
        
        //generic variable story level container (hide initially)
        rootStoryNode = sceneView.scene.rootNode.childNode(withName: "LVLContainer", recursively: false)
        rootStoryNode.isHidden = true
        
        //generic variable for the area mask in the story
        storymask = sceneView.scene.rootNode.childNode(withName: "StoryMask", recursively: true)
        
        //generic story main character idle animation
        mainCharacterIdle = sceneView.scene.rootNode.childNode(withName: "MainCharacter_Idle", recursively: true)
        mainCharacterIdle.isHidden = true
        
        //generic story main character moving animation
        mainCharacterMoving = sceneView.scene.rootNode.childNode(withName: "MainCharacter_Walk", recursively: true)
        mainCharacterMoving.isHidden = true
        
        //generic variable for level floor
        mainFloor = sceneView.scene.rootNode.childNode(withName: "LVLFloor", recursively: true)
        
        //generic variable for the first letter
        letterOne = sceneView.scene.rootNode.childNode(withName: "LetterOne", recursively: true)
    }
    
    func anthonyWalk() {
        if(idle) {
            //playAnimation1()
            playAnimation()
            isMoving = true
        }
        else {
            stopAnimation()
            isMoving = false
        }
        idle = !idle
        return
    }
    
    //func playAnimation1() {
    func playAnimation() {
        //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
        mainCharacterMoving.isHidden = false
        mainCharacterIdle.isHidden = true
        
        //start playing the walking sound
        walkPlayer.setVolume(0.5, fadeDuration: 0)
        walkPlayer.play()
        
        //TODO: Load unique floor movement locations for particular chapter
        switch gameProgress {
            
        //A
        case .toLetter1:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //animate the mainFloor node to move and stop when the translation is complete
                mainFloor.runAction(SCNAction.moveBy(x: -0.1, y: 0, z: -0.8, duration: 15), completionHandler: stopAnimation)
                //animate the main character to rotate a bit on the y axis
                mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: 0.3, z: 0, duration: 15))
                mainCharacterIdle.position = mainCharacterMoving.position
                mainCharacterIdle.eulerAngles = SCNVector3(0, 0.3, 0)
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter five")
            default:
                break
            }
            
        //B
        case .toLetter2:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                mainFloor.runAction(SCNAction.moveBy(x: 0.25, y: 0, z: -1.4, duration: 15), completionHandler: stopAnimation)
                mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: -0.3, z: 0, duration: 15))
                //set the idle animation position to be at the new main character location and rotation
                mainCharacterIdle.position = mainCharacterMoving.position
                mainCharacterIdle.eulerAngles = SCNVector3(0, 0, 0)
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter five")
            default:
                break
            }
            
        //C
        case .toLetter3:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                mainFloor.runAction(SCNAction.moveBy(x: -0.15, y: 0, z: -1.45, duration: 15), completionHandler: stopAnimation)
                mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: -0.5, z: 0, duration: 15))
                //set the idle animation position to be at the new main character location and rotation
                mainCharacterIdle.position = mainCharacterMoving.position
                mainCharacterIdle.eulerAngles = SCNVector3(0, -0.5, 0)
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter five")
            default:
                break
            }
            
        //D
        case .toLetter4:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                mainFloor.runAction(SCNAction.moveBy(x: 1.4, y: 0, z: -0.2, duration: 15), completionHandler: stopAnimation)
                mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: -2.5, z: 0, duration: 15))
                //set the idle animation position to be at the new main character location and rotation
                mainCharacterIdle.position = mainCharacterMoving.position
                mainCharacterIdle.eulerAngles = SCNVector3(0, -3, 0)
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter five")
            default:
                break
            }
            
        //E
        case .toLetter5:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                mainFloor.runAction(SCNAction.moveBy(x: 0.35, y: 0, z: 1.65, duration: 15), completionHandler: stopAnimation)
                mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 15))
                //set the idle animation position to be at the new main character location and rotation
                mainCharacterIdle.position = mainCharacterMoving.position
                //mainCharacterIdle.eulerAngles = SCNVector3(0, 0, 0)
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter five")
            default:
                break
            }
            
        //F
        case .toLetter6:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                mainFloor.runAction(SCNAction.moveBy(x: -0.35, y: 0, z: 1.5, duration: 15), completionHandler: stopAnimation)
                mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: -0.5, z: 0, duration: 15))
                //set the idle animation position to be at the new main character location and rotation
                mainCharacterIdle.position = mainCharacterMoving.position
                mainCharacterIdle.eulerAngles = SCNVector3(0, -3.5, 0)
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                print("move floor for chapter five")
            default:
                break
            }
            
        //Finish
        case .chapterFinished:
            
            //TODO: Do stuff that wraps up the chapter
            print("Reached the end of the chapter")
            
        }
    }
    
    func stopAnimation() {
        mainCharacterIdle.isHidden = false
        mainCharacterMoving.isHidden = true
        
        //fade out the walking sound
        walkPlayer.setVolume(0, fadeDuration: 1)
        
        //stop playing the walking sound
        walkPlayer.stop()
        walkPlayer.setVolume(1, fadeDuration: 0)
        
        switch gameProgress {
        case .toLetter1:
            
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: "Line3", type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 1")
                    self.shatterLetterOne = true
                    
                    //TODO: Make the letter passed in change based on the Book/Chapter Selected
                    
                    print("Loading activity A")
                    //self.loadActivityLetter(activityString: "A")
                    self.loadActivityLetter(activityString: "S")
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: "Line4", type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter2
            
        case .toLetter2:
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: "Line3", type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 2")
                    self.shatterLetterTwo = true
                    
                    print("Loading activity B")
                    //self.loadActivityLetter(activityString: "B")
                    self.loadActivityLetter(activityString: "Y")
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: "Line4", type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter3
            
        case .toLetter3:
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: "Line3", type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 3")
                    self.shatterLetterThree = true
                    
                    print("Loading activity C")
                    
                    //self.loadActivityLetter(activityString: "C")
                    self.loadActivityLetter(activityString: "Z")
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: "Line4", type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter4
            
        case .toLetter4:
            ///wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: "Line3", type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 4")
                    self.shatterLetterFour = true
                    
                    print("Loading activity D")
                    //self.loadActivityLetter(activityString: "D")
                    self.loadActivityLetter(activityString: "V")
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: "Line4", type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter5
            
        case .toLetter5:
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: "Line3", type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 5")
                    self.shatterLetterFive = true
                    
                    print("Loading activity E")
                    //self.loadActivityLetter(activityString: "E")
                    self.loadActivityLetter(activityString: "W")
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: "Line4", type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter6
            
        case .toLetter6:
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: "Line3", type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 6")
                    self.shatterLetterSix = true
                    
                    print("Loading activity F")
                    //self.loadActivityLetter(activityString: "F")
                    self.loadActivityLetter(activityString: "X")
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: "Line4", type: "mp3")
                    })
                })
            })
            gameProgress = .chapterFinished
            
        case .chapterFinished:
            //finish chapter stuff
            print("Finish Chapter after animation stopped")
            
            //TODO: trigger finishing event
        }
    }
    
    func playShatterAnimation () {
        switch true {
        case shatterLetterOne:
            letterOne!.isPaused = false
            animateLetterHide(fadeThis: letterOne!)
        case shatterLetterTwo:
            letterTwo!.isPaused = false
            animateLetterHide(fadeThis: letterTwo!)
        case shatterLetterThree:
            letterThree!.isPaused = false
            animateLetterHide(fadeThis: letterThree!)
        case shatterLetterFour:
            letterFour!.isPaused = false
            animateLetterHide(fadeThis: letterFour!)
        case shatterLetterFive:
            letterFive!.isPaused = false
            animateLetterHide(fadeThis: letterFive!)
        case shatterLetterSix:
            letterSix!.isPaused = false
            animateLetterHide(fadeThis: letterSix!)
        default:
            break
        }
    }
    
    func animateLetterHide(fadeThis: SCNNode){
        //wait 3 seconds and then fade the letter out to 0 opacity
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            fadeThis.runAction(SCNAction.fadeOpacity(to: 0, duration: 4))
            
            //have the main character walk to the next letter
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                self.playAnimation()
            })
        })
    }
    
    func storyTime(){
        //Wait 2 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.playAudioNarrationFile(file: "Line1", type: "mp3")
        })
        
        //wait 7 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
            
            self.anthonyWalk()
            
            //wait 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.playAudioNarrationFile(file: "Line2", type: "mp3")
            })
        })
    }
    
    //pass it an audiofile and it will play it!
    public func playAudioNarrationFile(file: String, type: String) {
        let audioPath = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        do
        {
            try narrationPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        } catch {
            print("AudioPlayer not available!")
        }
        self.narrationPlayer.play()
    }
    
    func loadActivityLetter(activityString: String) {
        
        print("loadActivityLetter is loading ", activityString)
        selectedActivity = activityString
        
        //switch to the Letter A ViewController
        let activityBoardView = self.storyboard?.instantiateViewController(withIdentifier: "ActivityBoardViewController") as! activityViewController
        self.present(activityBoardView, animated: true)
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
