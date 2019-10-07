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
    
    //MARK: ACTIONS
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterNodeArray = chapterSelectedNodeArray
        self.initSceneView()
        self.initScene()
        self.initARSession()
        self.loadModels(chapterNode: chapterNodeArray!)
        self.referenceMainNodes()
        
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
    
    // MARK: Init Functions
    
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
            self.mainCharacterIdle?.isHidden = false
            self.startTransitionAnimation(key: "MainCharacterIdle")
            
            self.startButton.isHidden = true
            self.gameState = .playGame
            //player background music/ambient
            self.toggleAudioBGFile(file: chapterSelectedSoundDict!["Background2"]!, type: "wav")
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
        mainCharacterIdle?.isHidden = true
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
        
        //generic story main character moving animation
        //mainCharacterMoving = sceneView.scene.rootNode.childNode(withName: "MainCharacter_Walk", recursively: true)
        //mainCharacterMoving.isHidden = true
        
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
    
//    func MainCharacterWalk() {
//        if(idle) {
//            playAnimation()
//            startTransitionAnimation(key: "MainCharacterWalking")
//            isMoving = true
//        }
//        else {
//            stopAnimation()
//            stopTransitionAnimation(key: "MainCharacterWalking")
//            isMoving = false
//        }
//        idle = !idle
//        return
//    }
    
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
    
    //func playAnimation1() {
    func playWalkAnimation() {
        //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
        startTransitionAnimation(key: "MainCharacterWalking")
        //play walk sound
        self.toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
        
        switch gameProgress {
        case .toLetter1:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //move position for letter:
                //I
                //animate the mainFloor node to move and stop when the translation is complete
                
                //mainFloor.runAction(SCNAction.moveBy(x: -0.1, y: 0, z: -0.8, duration: 15), completionHandler: stopWalkAnimation) //old chapter 1
                mainFloor.runAction(SCNAction.moveBy(x:0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation)
                
                //animate the main character to rotate a bit on the y axis
                //mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: 0.3, z: 0, duration: 15))
                //mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: 0.3, z: 0, duration: 15)) //old chapter 1
                mainCharacterIdle?.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new chapter 1
                //mainCharacterIdle.position = mainCharacterMoving.position
                //mainCharacterIdle.eulerAngles = SCNVector3(0, 0.3, 0)
                
                print("move floor for chapter one")
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                mainFloor.runAction(SCNAction.moveBy(x: 0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation) //old ch 1
                //mainFloor.runAction(SCNAction.move(to: SCNVector3(x: -18.8, y: 1.25, z: 3.2), duration: 7), completionHandler: stopWalkAnimation) //new ch 1
                //animate the main character to rotate a bit on the y axis
                //mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //old ch 1
                mainCharacterIdle?.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new ch 1
                //mainCharacterIdle.position = mainCharacterMoving.position
                //mainCharacterIdle.eulerAngles = mainCharacterMoving.eulerAngles
                
                //move position for letter:
                //P

                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //move position for letter:
                //G

                
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //move position for letter:
                //K

            
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //move position for letter:
                //N

                print("move floor for chapter five")
            default:
                break
            }
            
        case .toLetter2:
            //change points based on Chapter
            switch true {
            case chapterOne:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for finishing letter 2
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration10"]!, type: "mp3")
                })
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                mainFloor.runAction(SCNAction.moveBy(x: -0.1, y: 0, z: -1.3, duration: 10), completionHandler: stopWalkAnimation) //old ch 1
                //startAnimation(key: "walking")
                //mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: -0.3, z: 0, duration: 15))
                //mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: -0.3, z: 0, duration: 15)) //old ch 1
                
                //mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1))
                //set the idle animation position to be at the new main character location and rotation
                //mainCharacterIdle.position = mainCharacterMoving.position
                //mainCharacterIdle.eulerAngles = SCNVector3(0, 0, 0)
                
                //T
                
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //R
                
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //O
                
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //V
                
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //Z
                
                print("move floor for chapter five")
            default:
                break
            }
            
        case .toLetter3:
            //change points based on Chapter
            switch true {
            case chapterOne:
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
                
                //L
                
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //B
                
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //Q
                
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //W
                
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //Y
                
                print("move floor for chapter five")
            default:
                break
            }
            
        case .toLetter4:
            //change points based on Chapter
            switch true {
            case chapterOne:
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

                //F
                
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //C
                
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //S
                
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //M
                
                print("move floor for chapter four")
            case chapterFive:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //X
                
                print("move floor for chapter five")
            default:
                break
            }
            
        case .toLetter5:
            //change points based on Chapter
            switch true {
            case chapterOne:
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
                
                //E
                
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //D
                
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //J
                
                print("move floor for chapter three")
            case chapterFour:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
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
            
        case .toLetter6:
            //change points based on Chapter
            switch true {
            case chapterOne:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                // x= (-)west/(+)east, z= (-)north/(+)south
                let move1 = SCNAction.moveBy(x: 0.1, y: 0, z: -0.95, duration: 6)
                let move2 = SCNAction.moveBy(x: 0.6, y: 0, z: -0.1, duration: 3)
                //TO-Do: invite Hannah to go to the tree for the surprise party (sound file)
                //pause to go through idny's dialog to hannah
                let pauseMove = SCNAction.moveBy(x: 0, y: 0, z: 0, duration: 10)
                let move3 = SCNAction.moveBy(x: 0.3, y: 0, z: 0.1, duration: 2)
                let move4 = SCNAction.moveBy(x: 0, y: -0.1, z: 1.9, duration: 6)
                let chapter1Letter6MoveSeq = SCNAction.sequence([move1, move2, pauseMove, move3, move4])
                mainFloor.runAction((chapter1Letter6MoveSeq), completionHandler: stopWalkAnimation)
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 5)
                let rotate2 = SCNAction.rotateBy(x: 0, y: -1.75, z: 0, duration: 1)
                let pauseRotation1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 13)
                let rotate3 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)
                let rotate4 = SCNAction.rotateBy(x: 0, y: -1.75, z: 0, duration: 1)
                let chapter1Letter6RotSeq = SCNAction.sequence([rotate1, rotate2, pauseRotation1, rotate3, rotate4])
                mainCharacterIdle?.runAction(chapter1Letter6RotSeq)
                
                //H
                
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //U
                
                print("move floor for chapter two")
            case chapterThree:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //----
                
                print("move floor for chapter three")
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
        case .chapterFinished:
            
            //TODO: Do stuff that wraps up the chapter
            print("Reached the end of the chapter")
            
            switch true {
            case chapterOne:
                mainFloor.runAction(SCNAction.move(to: SCNVector3(x: 0, y: 0, z: 0), duration: 7)) //new ch 1
                mainCharacterIdle?.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)) //new ch 1
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
        //mainCharacterIdle.isHidden = false
        //mainCharacterMoving.isHidden = true
        //idle = true
        stopTransitionAnimation(key: "MainCharacterWalking")
        
        //fade out the walking sound
        FXPlayer.setVolume(0, fadeDuration: 1)
        
        //stop playing the walking sound
        FXPlayer.stop()
        FXPlayer.setVolume(1, fadeDuration: 0)
        
        switch gameProgress {
        case .toLetter1:
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
            gameProgress = .toLetter2
            
        case .toLetter2:
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
            gameProgress = .toLetter3
            
        case .toLetter3:
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
            gameProgress = .toLetter4
            
        case .toLetter4:
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
            gameProgress = .toLetter5
            
        case .toLetter5:
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
            gameProgress = .toLetter6
            
        case .toLetter6:
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
            gameProgress = .chapterFinished
            
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
        case shatterLetterSix:
            letterSix!.isPaused = false
            animateLetterHide(fadeThis: letterSix!)
            toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            
        case shatterLetterFive:
            //letterFive!.isPaused = false
            //animateLetterHide(fadeThis: letterFive!)
            //playAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            
            //drop side Eric down from letter E
            self.charcterThreeIdle.parent?.runAction(SCNAction.moveBy(x:0, y: 0, z: 1, duration: 12.3))
            self.startAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
            
                //play for 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.3, execute: {
                    //play Lin through a sequence of movements so he turns and then walks to the Letter H
                    //let rotate1 = SCNAction.rotateBy(x: 0.0, y: 0.0, z: 0.0, duration: 0.5)
                    let endSpot = SCNVector3(x: 19.5, y: 2.5, z: 7.5)
                    let move1 = SCNAction.move(to: endSpot, duration: 10)
                    let rotate2 = SCNAction.rotateBy(x: 0.0, y: 1.75, z: 0.0, duration: 0.5)
                    let ericMoveSeq = SCNAction.sequence([move1, rotate2])
                    self.charcterFourIdle.parent?.runAction(ericMoveSeq)
                
                    //play side character animation
                    self.stopAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
                    self.startAnimateSideCharacter(key: "SideCharacter4Walk", sideCharacter: "Eric")
                    
                    //wait 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                        self.stopAnimateSideCharacter(key: "SideCharacter4Walk", sideCharacter: "Eric")
                        self.startAnimateSideCharacter(key: "SideCharacter4Dance1", sideCharacter: "Eric")
                    })
                })
            
        case shatterLetterFour:
            letterFour!.isPaused = false
            animateLetterHide(fadeThis: letterFour!)
            toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            
            //drop side Francine down from letter F
            //self.charcterThreeIdle.parent?.runAction(SCNAction.moveBy(x:0, y: 0, z: -2.1, duration: 1.5))
            //let intermediateSpot = SCNVector3(x: 4.4, y: 1.1, z: 8.8)
            //let moveOut = SCNAction.move(to: intermediateSpot, duration: 0.5)
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

        case shatterLetterThree:
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
            
        case shatterLetterTwo:
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
      
        case shatterLetterOne:
            letterOne!.isPaused = false
            animateLetterHide(fadeThis: letterOne!)
            toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
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
                self.playWalkAnimation()
            })
        })
    }
    
    func storyTime(){
        //Wait 3 second for game to load completely
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
            //play game intro 1
            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
        })
        
        //wait 7 seconds for the game intro1 to finsh
        DispatchQueue.main.asyncAfter(deadline: .now() + 14, execute: {
            
            //move the main character to the first letter
            self.playWalkAnimation()
        })
    }
    
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
        case "Terry":
            print("Do Terry stuff")
            charcterOneIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Lin":
            print("Do Lin stuff")
            charcterTwoIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Francine":
            print("Do Francine stuff")
            charcterThreeIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Eric":
            print("Do Eric stuff")
            charcterFourIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Hannah":
            print("Do Hannah stuff")
            charcterFiveIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Indy":
            print("Do Indy stuff")
            mainCharacterIdle?.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        default:
            break
        }
    }
    func stopAnimateSideCharacter(key: String, sideCharacter: String) {
        switch sideCharacter {
        case "Terry":
            print("Remove stuff")
            charcterOneIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
            //charcterOneIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Lin":
            print("Remove stuff")
            //charcterTwoIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterTwoIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Francine":
            print("Remove stuff")
            //charcterThreeIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterThreeIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Eric":
            print("Remove stuff")
            //charcterFourIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterFourIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Hannah":
            print("Remove stuff")
            //charcterFiveIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterFiveIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Indy":
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
