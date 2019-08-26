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
        
        stopWalkAnimation()
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
            self.mainCharacterIdle.isHidden = false
            self.startTransitionAnimation(key: "MainCharacterIdle")
            
            self.startButton.isHidden = true
            self.gameState = .playGame
            //self.birdsPlayer.play()
            //player background music/ambient
            self.playAudioBGFile(file: chapterSelectedSoundDict!["Background2"]!, type: "wav")
        }
        storyTime()
    }
    
    func resetGame(){
        guard self.gameState == .playGame else { return }
        DispatchQueue.main.async {
            //hide the main nodes
            self.rootStoryNode.isHidden = true
            self.mainCharacterIdle.isHidden = true
            //self.mainCharacterMoving.isHidden = true
            
            //change game state and show start button
            self.startButton.isHidden = false
            self.gameState = .detectSurface
            
            //stop all sound
            //self.birdsPlayer.stop()
            //self.walkPlayer.stop()
            self.CharacterPlayer.stop()
            self.narrationPlayer.stop()
            self.BGPlayer.stop()
            self.FXPlayer.stop()

            
            //stop all animations
            self.stopWalkAnimation()
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
        //mainCharacterIdle = sceneView.scene.rootNode.childNode(withName: "MainCharacter_Idle", recursively: true)
        mainCharacterIdle = sceneView.scene.rootNode.childNode(withName: "MainCharacter", recursively: true)
        mainCharacterIdle.isHidden = true
        
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
        mainCharacterIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
    }
    
    func stopTransitionAnimation(key: String) {
        //stop the animation with a smooth transition
        //sceneView.scene.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        print("Removing animation)")
        mainCharacterIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
    }
    
    //func playAnimation1() {
    func playWalkAnimation() {
        //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
        //mainCharacterMoving.isHidden = false
        //mainCharacterIdle.isHidden = true
        startTransitionAnimation(key: "MainCharacterWalking")
        
        //start playing the walking sound
//        let walkAudioPath = Bundle.main.path(forResource: "Gravel and Grass Walk", ofType: "wav", inDirectory: "art.scnassets/Sounds")
//        do
//        {
//            try walkPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: walkAudioPath!))
//            walkPlayer.enableRate = true
//            walkPlayer.rate = 0.5
//        } catch {
//            print("WalkPlayer not available!")
//        }
//
//        walkPlayer.setVolume(0.5, fadeDuration: 0)
//        walkPlayer.play()
        
        self.playAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)

        //TODO: Load unique floor movement locations for particular chapter
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
                mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new chapter 1
                //mainCharacterIdle.position = mainCharacterMoving.position
                //mainCharacterIdle.eulerAngles = SCNVector3(0, 0.3, 0)
                
                print("move floor for chapter one")
            case chapterTwo:
                //animate the mainFloor node to move and stop when the translation is complete
                mainFloor.runAction(SCNAction.moveBy(x: 0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation) //old ch 1
                //mainFloor.runAction(SCNAction.move(to: SCNVector3(x: -18.8, y: 1.25, z: 3.2), duration: 7), completionHandler: stopWalkAnimation) //new ch 1
                //animate the main character to rotate a bit on the y axis
                //mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //old ch 1
                mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new ch 1
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
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                // x= (-)west/(+)east, z= (-)north/(+)south
                let move1 = SCNAction.moveBy(x: 0.05, y: 0, z: -1.5, duration: 8)
                let move2 = SCNAction.moveBy(x: 0.5, y: 0, z: -0.02, duration: 6)
                let chapter1Letter3MoveSeq = SCNAction.sequence([move1, move2])
                mainFloor.runAction((chapter1Letter3MoveSeq), completionHandler: stopWalkAnimation)
                
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 7)
                let rotate2 = SCNAction.rotateBy(x: 0, y: -1.75, z: 0, duration: 1)
                let chapter1Letter3RotSeq = SCNAction.sequence([rotate1, rotate2])
                mainCharacterIdle.runAction(chapter1Letter3RotSeq)
                
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
                let move1 = SCNAction.moveBy(x: 0.4, y: 0, z: 0.2, duration: 3)
                let move2 = SCNAction.moveBy(x: 0.0, y: 0, z: 2.25, duration: 6)
                let move3 = SCNAction.moveBy(x: 0.5, y: 0, z: 0, duration: 3)
                let chapter1Letter3MoveSeq = SCNAction.sequence([move1, move2, move3])
                mainFloor.runAction((chapter1Letter3MoveSeq), completionHandler: stopWalkAnimation)
                // (+) = clockwise, (-) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 2)
                let rotate2 = SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)
                let rotate3 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 6)
                let rotate4 = SCNAction.rotateBy(x: 0, y: -1.75, z: 0, duration: 1)
                let chapter1Letter3RotSeq = SCNAction.sequence([rotate1, rotate2, rotate3, rotate4])
                mainCharacterIdle.runAction(chapter1Letter3RotSeq)
                

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
                //mainFloor.runAction(SCNAction.moveBy(x: 0.35, y: 0, z: 1.65, duration: 15), completionHandler: stopWalkAnimation) //old chapter 1
                mainFloor.runAction(SCNAction.move(to: SCNVector3(x: 8, y: 1.25, z: -2.7), duration: 7), completionHandler: stopWalkAnimation) //new
                //mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 15))
                //mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 15)) //old chapter 1
                mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)) //new  ch 1
                //set the idle animation position to be at the new main character location and rotation
                //mainCharacterIdle.position = mainCharacterMoving.position
                //mainCharacterIdle.eulerAngles = SCNVector3(0, 0, 0)
                
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
                //mainFloor.runAction(SCNAction.moveBy(x: -0.35, y: 0, z: 1.5, duration: 15), completionHandler: stopWalkAnimation) //old ch 1
                mainFloor.runAction(SCNAction.move(to: SCNVector3(x: -17.5, y: 1.25, z: -15.2), duration: 7), completionHandler: stopWalkAnimation) //new ch 1
                //mainCharacterMoving.runAction(SCNAction.rotateBy(x: 0, y: -0.5, z: 0, duration: 15))
                mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)) //new ch 1
                //set the idle animation position to be at the new main character location and rotation
                //mainCharacterIdle.position = mainCharacterMoving.position
                //mainCharacterIdle.eulerAngles = SCNVector3(0, -3.5, 0)
                
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
                mainFloor.runAction(SCNAction.move(to: SCNVector3(x: 18.5, y: 1.9, z: 8.9), duration: 7)) //new ch 1
                mainCharacterIdle.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)) //new ch 1
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
            
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 1")
                    self.shatterLetterOne = true
                    
                    //TODO: Make the letter passed in change based on the Book/Chapter Selected
                    
                    print("Loading activity \(chapterSelectedLetterArray![0])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter2
            
        case .toLetter2:
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 2")
                    self.shatterLetterTwo = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![1])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter3
            
        case .toLetter3:
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 3")
                    self.shatterLetterThree = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![2])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter4
            
        case .toLetter4:
            ///wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 4")
                    self.shatterLetterFour = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![3])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter5
            
        case .toLetter5:
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 5")
                    self.shatterLetterFive = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![4])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])

                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                    })
                })
            })
            gameProgress = .toLetter6
            
        case .toLetter6:
            //wait 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                //wait 4 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    //get ready to shatter a when ViewDidAppear() is called
                    print("Prepare to shatter letter 6")
                    self.shatterLetterSix = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![5])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                    
                    //wait 6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
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
            //playAnimation(key: "ShatterA")
            animateLetterHide(fadeThis: letterOne!)
            playAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
        case shatterLetterTwo:
            letterTwo!.isPaused = false
            print("LetterTwo is now set to false - Shatter that letter Two!!")
            animateLetterHide(fadeThis: letterTwo!)
            playAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
        case shatterLetterThree:
            letterThree!.isPaused = false
            animateLetterHide(fadeThis: letterThree!)
            playAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
        case shatterLetterFour:
            letterFour!.isPaused = false
            animateLetterHide(fadeThis: letterFour!)
            playAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
        case shatterLetterFive:
            letterFive!.isPaused = false
            animateLetterHide(fadeThis: letterFive!)
            playAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
        case shatterLetterSix:
            letterSix!.isPaused = false
            animateLetterHide(fadeThis: letterSix!)
            playAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
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
                self.playWalkAnimation()
            })
        })
    }
    
    func storyTime(){
        //Wait 2 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
        })
        
        //wait 7 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
            
            //self.MainCharacterWalk()
            self.playWalkAnimation()
            
            //wait 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
            })
        })
    }
    
    //pass it an audiofile and it will play it!
    func playAudioNarrationFile(file: String, type: String) {
        let audio1Path = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        do
        {
            try narrationPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio1Path!))
            
        } catch {
            print("AudioPlayer not available!")
        }
        
        self.narrationPlayer.play()
    }
    
    //pass it an audiofile and it will play it!
    func playAudioFXFile(file: String, type: String, rate: Float) {
        let audio2Path = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        do
        {
            try FXPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio2Path!))
            
        } catch {
            print("FXPlayer not available!")
        }
        FXPlayer.enableRate = true
        FXPlayer.rate = rate
        FXPlayer.setVolume(0.5, fadeDuration: 0)
        self.FXPlayer.play()
    }
    
    //pass it an audiofile and it will play it!
    func playAudioBGFile(file: String, type: String) {
        let audio3Path = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        do
        {
            try BGPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio3Path!))
            
        } catch {
            print("BGPlayer not available!")
        }
        //set BGPlayer to play infinitly (-1)
        self.BGPlayer.numberOfLoops = -1
        self.BGPlayer.play()
    }
    
    //pass it an audiofile and it will play it!
    func playAudioCharacterFile(file: String, type: String) {
        let audio4Path = Bundle.main.path(forResource: file, ofType: type, inDirectory: "art.scnassets/Sounds")
        do
        {
            try CharacterPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio4Path!))
            
        } catch {
            print("CharacterPlayer not available!")
        }
        self.CharacterPlayer.play()
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
