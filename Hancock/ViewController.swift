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

enum AudioType: String {
    case Background
    case Effect
    case Narration
    case Character
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
        
        self.stopWalkAnimation()
    }
    @IBAction func setStudentInfo(_ sender: UIButton) {
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        self.startGame()
        
        //while game is playing we need a go back button to return to the beginning
        resetButton.isHidden = false
        
        switch currentChapter {
        case .Chapter1:
            showAllBtn.isHidden = false
        case .Chapter2:
            //don't need to hide everything in this scene
            showAllBtn.isHidden = true
        case .Chapter3:
            //don't need to hide everything in this scene
            showAllBtn.isHidden = true
        case .Chapter4:
            showAllBtn.isHidden = true
        case .Chapter5:
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
    let scene = SCNScene(named: "art.scnassets/Arrow.scn")
    var arrowVisible: Bool = false
    var arrow: SCNNode!
    var patriciaFlying: Bool = false
    var patriciaNumber:Int = 0
    
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
    
    //Bools for special chapter8 tap-handler
    var LionelOnPlate = false
    var YogiOnPlate = false
    var KimiOnPlate = false
    var ErnieOnPlate = false
    
    //Bools for special chapter nine aircraft
    var patricia1: SCNNode?
    var patricia2: SCNNode?
    var patricia3: SCNNode?
    var patricia4: SCNNode?
    var patricia5: SCNNode?
    var patricia6: SCNNode?
    var patricia7: SCNNode?
    var patricia8: SCNNode?
    var patricia9: SCNNode?
    var patricia10: SCNNode?
    var patricia11: SCNNode?
    var patricia12: SCNNode?
    
    //workitems hold dispatchQueues and are cancelled with reset button
    var walkSound:AVAudioPlayer? = nil
    var workItem1:DispatchWorkItem? = nil
    var workItem2:DispatchWorkItem? = nil
    var workItem3:DispatchWorkItem? = nil
    var workItem4:DispatchWorkItem? = nil
    var workItem5:DispatchWorkItem? = nil
    var workItem6:DispatchWorkItem? = nil
    var workItem7:DispatchWorkItem? = nil
    var workItem8:DispatchWorkItem? = nil
    var workItem9:DispatchWorkItem? = nil
    var workItem10:DispatchWorkItem? = nil
    var workItem11:DispatchWorkItem? = nil
    var workItem12:DispatchWorkItem? = nil
    var workItem13:DispatchWorkItem? = nil
    var workItem14:DispatchWorkItem? = nil
    var workItem15:DispatchWorkItem? = nil
    var lightItem1:DispatchWorkItem? = nil
    var lightItem2:DispatchWorkItem? = nil
    var particleItem1:DispatchWorkItem? = nil
    var particleItem2:DispatchWorkItem? = nil
    var particleItem3:DispatchWorkItem? = nil
    
    //variables for sound files and audio players
    var audioPlayers: Set<AVAudioPlayer> = Set<AVAudioPlayer>()

    // MARK: - Start Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterNodeArray = chapterSelectedNodeArray
        self.initSceneView()
        self.initScene()
        self.initARSession()
        self.loadModels(chapterNode: chapterNodeArray!)
        self.referenceMainNodes()
        arrow = scene?.rootNode.childNode(withName: "obelisk", recursively: false)
        
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //select number of taps needed to trigger
        tapGestureRecognizer.numberOfTapsRequired = 1
        //add the gesture recognizer to the scene view
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        
//        //setup audio player by loading an file address into the variable
//        let backgroundAudioPath = Bundle.main.path(forResource: (chapterSelectedSoundDict!["Background2"]), offileExtension: "wav", inDirectory: "art.scnassets/Sounds")
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
            
            if currentChapter == .Chapter9 {
                //special circumstances for keeping balloon from flying away
                charcterTwoIdle.isPaused = true
                
                patricia1 = mainFloor.childNode(withName: "Patricia1", recursively: true)
                patricia2 = mainFloor.childNode(withName: "Patricia2", recursively: true)
                patricia3 = mainFloor.childNode(withName: "Patricia3", recursively: true)
                patricia4 = mainFloor.childNode(withName: "Patricia4", recursively: true)
                patricia5 = mainFloor.childNode(withName: "Patricia5", recursively: true)
                patricia6 = mainFloor.childNode(withName: "Patricia6", recursively: true)
                patricia7 = mainFloor.childNode(withName: "Patricia7", recursively: true)
                patricia8 = mainFloor.childNode(withName: "Patricia8", recursively: true)
                patricia9 = mainFloor.childNode(withName: "Patricia9", recursively: true)
                patricia10 = mainFloor.childNode(withName: "Patricia10", recursively: true)
                patricia11 = mainFloor.childNode(withName: "Patricia11", recursively: true)
                
                patricia1!.isPaused = true
                patricia2!.isPaused = true
                patricia3!.isPaused = true
                patricia4!.isPaused = true
                patricia5!.isPaused = true
                patricia6!.isPaused = true
                patricia7!.isPaused = true
                patricia8!.isPaused = true
                patricia9!.isPaused = true
                patricia10!.isPaused = true
                patricia11!.isPaused = true

                patricia1!.isHidden = true
                patricia2!.isHidden = true
                patricia3!.isHidden = true
                patricia4!.isHidden = true
                patricia5!.isHidden = true
                patricia6!.isHidden = true
                patricia7!.isHidden = true
                patricia8!.isHidden = true
                patricia9!.isHidden = true
                patricia10!.isHidden = true
                patricia11!.isHidden = true
            }
            
            if currentChapter == .Chapter6 {
                //pause Barry since the chapter contains one long animation for him
                //we start him when the story starts in storyTime()
                mainCharacterIdle!.isPaused = true
            }
            
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
            
            switch currentChapter {
            case .Chapter8:
                if shatterLetterFive == true{
                    switch hitTestResult.node.parent?.name {
                    case "Lemon":
                        print("Tapped: ", hitTestResult.node.parent?.name)
                        if LionelOnPlate == false{
                            startTransitionAnimation(key: "MainCharacterLaying")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration30"]!, fileExtension: "mp3") //"Good job"
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["CoinDing1"]!, fileExtension: "mp3", rate: 1)
                            mainCharacterIdle.parent?.position = SCNVector3(0.7, 8.42, 7.1)
                            mainCharacterIdle.parent?.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(237), GLKMathDegreesToRadians(0))
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
                                self.LionelOnPlate = true
                                print("Lionel on plate = ", self.LionelOnPlate)
                            })
                        }
                    case "Yogurt":
                        print("Tapped: ", hitTestResult.node.parent?.name)
                        print("LionOnPlate status is currently: ", LionelOnPlate)
                        print("YogiOnPlate state is currently: ", YogiOnPlate)
                        if LionelOnPlate == true && YogiOnPlate == false{
                        self.startAnimateSideCharacter(key: "SideCharacter1Sitting", sideCharacter: "Yogi")
                        
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3") //"Amazing"
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["CoinDing2"]!, fileExtension: "mp3", rate: 1)
                            charcterOneIdle.parent?.position = SCNVector3(1, 8.45, 4.8)
                            charcterOneIdle.parent?.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-40), GLKMathDegreesToRadians(0))
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
                                self.YogiOnPlate = true
                                print("Yogi on plate = ", self.YogiOnPlate)
                            })
                        }
                    case "Kiwi":
                        print("Tapped: ", hitTestResult.node.parent?.name)
                        if LionelOnPlate == true && YogiOnPlate == true && KimiOnPlate == false{
                        self.startAnimateSideCharacter(key: "SideCharacter2Laying", sideCharacter: "Kimi")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration34"]!, fileExtension: "mp3") //"Good job"
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["CoinDing3"]!, fileExtension: "mp3", rate: 1)
                            charcterTwoIdle.parent?.position = SCNVector3(-0.8, 8.5, 4.9)
                            charcterTwoIdle.parent?.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(25), GLKMathDegreesToRadians(0))
                            print("Kimi to plate")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration35"]!, fileExtension: "mp3")
                                self.KimiOnPlate = true
                                print("Kimi on plate = ", self.KimiOnPlate)
                            })
                        }
                    case "EnergyBar":
                        print("Tapped: ", hitTestResult.node.parent?.name)
                        if LionelOnPlate == true && YogiOnPlate == true && KimiOnPlate == true && ErnieOnPlate == false{
                        self.startAnimateSideCharacter(key: "SideCharacter3Sitting", sideCharacter: "Ernie")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration36"]!, fileExtension: "mp3") //"You did it"
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["CoinDing4"]!, fileExtension: "mp3", rate: 1)
                            charcterThreeIdle.parent?.position = SCNVector3(-1.5, 8.5, 7)
                            charcterThreeIdle.parent?.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(125), GLKMathDegreesToRadians(0))
                            self.ErnieOnPlate = true
                            self.shatterLetterSix = true
                            
                            //go to final narration and reset
                            playShatterAnimation()
                            print("Ernie on plate = ", ErnieOnPlate)
                        }
                    default:
                        break
                    }
                    //if all the characters are on the plate
//                    if LionelOnPlate == true && YogiOnPlate == true && KimiOnPlate == true && ErnieOnPlate == true {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                            //play the final narration
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration37"]!, fileExtension: "mp3")
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
//                                self.resetGame()
//                            })
//                        })
//                    }
                }
                print("Chapter Eight is true.")
            case .Chapter7:
                print("Chapter Seven is true.")
            case .Chapter6:
                print("Chapter Six is true.")
            case .Chapter5:
                print("Chapter Five is true.")
                let key1 = mainCharacterIdle.childNode(withName: "Xylophone_Key1", recursively: true)!
                let key2 = mainCharacterIdle.childNode(withName: "Xylophone_Key2", recursively: true)!
                let key3 = mainCharacterIdle.childNode(withName: "Xylophone_Key3", recursively: true)!
                let key4 = mainCharacterIdle.childNode(withName: "Xylophone_Key4", recursively: true)!
                let key5 = mainCharacterIdle.childNode(withName: "Xylophone_Key5", recursively: true)!
                
                switch hitTestResult.node.name {
                    case "Xylophone_Key1":
                        self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Xylophone1"]!, fileExtension: "mp3", rate: 1)
                        print("Ding Ding 1")
                    
                    case "Xylophone_Key2":
                        self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Xylophone2"]!, fileExtension: "mp3", rate: 1)
                        print("Ding Ding 1")
                    
                    case "Xylophone_Key3":
                        self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Xylophone3"]!, fileExtension: "mp3", rate: 1)
                        print("Ding Ding 1")
                    
                    case "Xylophone_Key4":
                        self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Xylophone4"]!, fileExtension: "mp3", rate: 1)
                        print("Ding Ding 1")
                    
                    case "Xylophone_Key5":
                        self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Xylophone5"]!, fileExtension: "mp3", rate: 1)
                        print("Ding Ding 1")
                    
                    default:
                        break
                }
            case .Chapter4:
                print("Chapter Four is true.")
            case .Chapter3:
                print("Chapter Three is true.")
            case .Chapter2:
                print("Chapter Two is true.")
                let shirt = mainCharacterIdle.childNode(withName: "PiperShirt", recursively: true)!
                let shorts = mainCharacterIdle.childNode(withName: "PiperShorts", recursively: true)!
                let helmet = mainCharacterIdle.childNode(withName: "PiperHelmet", recursively: true)!
                let skateboard = mainCharacterIdle.childNode(withName: "PiperSkateboard", recursively: true)!
                let elbowPadeR = mainCharacterIdle.childNode(withName: "PiperElbowPad_R", recursively: true)!
                let elbowPadeL = mainCharacterIdle.childNode(withName: "PiperElbowPad_L", recursively: true)!
                let kneePadeR = mainCharacterIdle.childNode(withName: "PiperKneePad_R", recursively: true)!
                let kneePadeL = mainCharacterIdle.childNode(withName: "PiperKneePad_L", recursively: true)!
                let helmetDeco1 = mainCharacterIdle.childNode(withName: "PiperHelmetStuff1", recursively: true)!
                let helmetDeco2 = mainCharacterIdle.childNode(withName: "PiperHelmetStuff2", recursively: true)!
                
                switch hitTestResult.node.parent?.name {
                    case "SideCharacter1":
                        charcterOneIdle.isHidden = true
                        charcterTwoIdle.isHidden = true
                        charcterThreeIdle.isHidden = true
                        charcterFourIdle.isHidden = true
                        
                        //TO-DO: change Piper's cloths
                        shirt.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Shirt Texture.png"
                        shorts.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Shorts Texture.png"
                        helmet.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Helmet Texture.png"
                        skateboard.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Skateboard Texture.png"
                        elbowPadeL.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Elbowpads Texture.png"
                        elbowPadeR.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Elbowpads Texture.png"
                        kneePadeL.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Kneepads Texture.png"
                        kneePadeR.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Kneepads Texture.png"
                        helmetDeco1.isHidden = true
                        helmetDeco2.isHidden = true
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
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
                        shirt.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Shirt Texture 2.png"
                        shorts.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Shorts Texture 2.png"
                        helmet.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Helmet Texture 2.png"
                        skateboard.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Skateboard Texture 2.png"
                        elbowPadeL.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Elbowpads Texture 2.png"
                        elbowPadeR.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Elbowpads Texture 2.png"
                        kneePadeL.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Kneepads Texture 2.png"
                        kneePadeR.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Kneepads Texture 2.png"
                        helmetDeco1.isHidden = false
                        helmetDeco2.isHidden = true
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
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
                        shirt.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Shirt Texture 3.png"
                        shorts.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Shorts Texture 3.png"
                        helmet.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Helmet Texture 3.png"
                        skateboard.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Skateboard Texture 3.png"
                        elbowPadeL.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Elbowpads Texture 3.png"
                        elbowPadeR.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Elbowpads Texture 3.png"
                        kneePadeL.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Kneepads Texture 3.png"
                        kneePadeR.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Kneepads Texture 3.png"
                        helmetDeco1.isHidden = true
                        helmetDeco2.isHidden = false
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
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
                        shirt.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Shirt Texture 4.png"
                        shorts.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Shorts Texture 4.png"
                        helmet.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Helmet Texture 4.png"
                        skateboard.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Skateboard Texture 4.png"
                        elbowPadeL.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Elbowpads Texture 4.png"
                        elbowPadeR.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Elbowpads Texture 4.png"
                        kneePadeL.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Kneepads Texture 4.png"
                        kneePadeR.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/3DModels/Chapter2Files/Textures/Piper Kneepads Texture 4.png"
                        helmetDeco1.isHidden = true
                        helmetDeco2.isHidden = true
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
                        //wait 4 seconds for the game intro1 to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //move the main character to the first letter
                            self.playWalkAnimation()
                        })
                    default:
                        break
                }
                
            case .Chapter1:
                print("Chapter Four is true.")
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
            self.playAudio(type: .Background, file: chapterSelectedSoundDict!["BackgroundSound"]!, fileExtension: "mp3")
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
        
        // We're going to the main menu now!
        currentChapter = .MainMenu

        DispatchQueue.main.async {
            //hide the main nodes
            //self.rootStoryNode.isHidden = true
            //self.mainCharacterIdle.isHidden = true
            //self.mainCharacterMoving.isHidden = true
            
            //change game state and show start button
            self.startButton.isHidden = false
            self.gameState = .detectSurface
            
            //stop all sound
            for player:AVAudioPlayer in self.audioPlayers {
                player.stop()
                self.audioPlayers.remove(player)
            }
            
            //dispatchMain.async tasks that are setup as dispatchWorkItems named workItem are canceled
            //this prevents background tasks from continueing if the chapter is quit and another is loaded
            self.particleItem2?.cancel()
            self.particleItem1?.cancel()
            self.lightItem2?.cancel()
            self.lightItem1?.cancel()
            self.workItem15?.cancel()
            self.workItem14?.cancel()
            self.workItem13?.cancel()
            self.workItem12?.cancel()
            self.workItem11?.cancel()
            self.workItem10?.cancel()
            self.workItem9?.cancel()
            self.workItem8?.cancel()
            self.workItem7?.cancel()
            self.workItem6?.cancel()
            self.workItem5?.cancel()
            self.workItem4?.cancel()
            self.workItem3?.cancel()
            self.workItem2?.cancel()
            self.workItem1?.cancel()
            
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
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["letter2Finish"]!, fileExtension: "mp3")
            })
        case .toLetter4:
            //play narration for finishing letter 4
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["letter3Finish"]!, fileExtension: "mp3")
                })
        case .toLetter5:
            //play narration for finishing letter 5
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["letter4Finish"]!, fileExtension: "mp3")
                    })
        case .toLetter6:
            //play narration for finishing letter 6
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["letter5Finish"]!, fileExtension: "mp3")
                    })
        case .chapterFinished :
            //play narration for finishing the chapter
           DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["letter6Finish"]!, fileExtension: "mp3")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["chapterFinish"]!, fileExtension: "mp3")
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
            //add extra narration based on chapter
            switch currentChapter {
            case .Chapter1:
                //Wait 7 second for game to load completely
                workItem2 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.playWalkAnimation()
                }
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    print(self.mainCharacterIdle.name!, "is now idle")
                    //play game intro 1
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                    //wait 7 seconds for the game intro1 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    self.startTransitionAnimation(key: "MainCharacterIdle")
//                    print(self.mainCharacterIdle.name!, "is now idle")
//
//                    //play game intro 1
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//
//                    //wait 7 seconds for the game intro1 to finish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                        //move the main character to the first letter
//                        self.playWalkAnimation()
//                    })
//                })
            case .Chapter2:
                workItem2 = DispatchWorkItem{
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
                }
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimation(key: "MainCharacterIdle")

                    //play game intro 1
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
                    
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    self.startTransitionAnimation(key: "MainCharacterIdle")
//
//                    //play game intro 1
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
//                        //show the different outfits that you can pick
//                        for node in self.charcterOneIdle.childNodes {
//                            node.isHidden = false
//                        }
//                        for node in self.charcterTwoIdle.childNodes {
//                            node.isHidden = false
//                        }
//                        for node in self.charcterThreeIdle.childNodes {
//                            node.isHidden = false
//                        }
//                        for node in self.charcterFourIdle.childNodes {
//                            node.isHidden = false
//                        }
//                    })
//                })
            case .Chapter3:
                workItem2 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.playWalkAnimation()
                    print("Starting chapter three")
                }
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    //play game intro 1
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    self.startTransitionAnimation(key: "MainCharacterIdle")
//                    //play game intro 1
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
//                            //move the main character to the first letter
//                            self.playWalkAnimation()
//                        print("Starting chapter three")
//                    })
//                })
            case .Chapter4:
                workItem2 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.playWalkAnimation()
                    print("Starting chapter four")
                }
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimation(key: "MainCharacterWaving")
                    //play game intro 1
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    self.startTransitionAnimation(key: "MainCharacterWaving")
//                    //play game intro 1
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
//                        //move the main character to the first letter
//                        self.playWalkAnimation()
//                        print("Starting chapter four")
//                    })
//                })
            case .Chapter5:
                workItem2 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.playWalkAnimation()
                }
                workItem1 = DispatchWorkItem{
                    //play game intro1
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    //play game intro1
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                        //move the main character to the first letter
//                        self.playWalkAnimation()
//                    })
//                })
            case .Chapter6:
                workItem3 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.playWalkAnimation()
                }
                workItem2 = DispatchWorkItem{
                    //Barry stops after stretching
                    self.mainCharacterIdle.isPaused = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7.25, execute: self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //play game intro1
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3") //12.19
                    
                    //Barryy starts stretching before the race
                    self.mainCharacterIdle.isPaused = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.75, execute: self.workItem2!)
                }
                
                //Wait 5 seconds for the chapter to load completely
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem1!)
                
            case .Chapter7:
                workItem2 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.playWalkAnimation()
                }
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    print(self.mainCharacterIdle.name!, "is now idle")
                    //play game intro 1
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                
                    //wait 7 seconds for the game intro1 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    self.startTransitionAnimation(key: "MainCharacterIdle")
//                    print(self.mainCharacterIdle.name!, "is now idle")
//                    //play game intro 1
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//
//                    //wait 7 seconds for the game intro1 to finish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
//                    //move the main character to the first letter
//                    self.playWalkAnimation()
//                    })
//                })
            case .Chapter8:
                self.startTransitionAnimation(key: "MainCharacterLaying")
                workItem2 = DispatchWorkItem{
                    //move the main character to the first marker
                    self.playWalkAnimation()
                    print("Start chapter eight")
                }
                workItem1 = DispatchWorkItem{
                    //play game intro 1
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    //play game intro 1
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
//                        //move the main character to the first marker
//                        self.playWalkAnimation()
//                        print("Start chapter eight")
//                    })
//                })
            case .Chapter9:
                //set Brennon's fly away Balloon to paused
                charcterTwoIdle.isHidden = true
                
                // Light on Brennon
                let lightNode = self.createSpotLightNode(intensity: 20, spotInnerAngle: 0, spotOuterAngle: 45)
                lightNode.position = SCNVector3Make(0, 25, 0)
                lightNode.eulerAngles = SCNVector3Make(-.pi/2, 0, 0)
                lightItem2 = DispatchWorkItem{
                    lightNode.removeFromParentNode()
                }
                lightItem1 = DispatchWorkItem{
                    self.charcterOneIdle.childNode(withName: "Brennon", recursively: false)!.addChildNode(lightNode)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.lightItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 17.0, execute: self.lightItem1!)
                
                workItem3 = DispatchWorkItem{
                    self.playWalkAnimation()
                }
                workItem2 = DispatchWorkItem{
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //play intro Narration to chapter 9
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                    print("Do chapter 9 stuff")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                    //play intro Narration to chapter 9
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//                    print("Do chapter 9 stuff")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                            self.playWalkAnimation()
//                        })
//                    })
//                })
            case .Chapter10:
                
                workItem3 = DispatchWorkItem{
                    self.stopTransitionAnimation(key: "MainCharacterLooking")
                    self.playWalkAnimation()
                }
                workItem2 = DispatchWorkItem{
                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")

                    //Finn starts looking around
                    self.stopTransitionAnimation(key: "MainCharacterWaving")
                    self.startTransitionAnimation(key: "MainCharacterLooking")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //play intro Narration to chapter 10
                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
                    //Finn is waving
                    self.startTransitionAnimation(key: "MainCharacterWaving")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: self.workItem2!)
                        
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    //play intro Narration to chapter 10
//                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration1"]!, type: "mp3")
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration1"]!, fileExtension: "mp3")
//                    //Finn is waving
//                    self.startTransitionAnimation(key: "MainCharacterWaving")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                        //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
//
//                        //Finn starts looking around
//                        self.stopTransitionAnimation(key: "MainCharacterWaving")
//                        self.startTransitionAnimation(key: "MainCharacterLooking")
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                            self.stopTransitionAnimation(key: "MainCharacterLooking")
//                            self.playWalkAnimation()
//                        })
//                    })
//                })
                print("Do chapter 10 stuff")
            default:
                break
            }
    }
    
    @discardableResult func playAudio(type: AudioType, file: String, fileExtension: String, rate:Float = 1.0) -> AVAudioPlayer? {
        if currentChapter == .MainMenu {
            return nil
        }
        return _playAudio(type: type, file: file, fileExtension: fileExtension, rate: rate)
    }
    
    //pass in an audiofile and it will play it!
    @discardableResult func playAudioMenu(type: AudioType, file: String, fileExtension: String, rate:Float = 1.0) -> AVAudioPlayer? {
        if currentChapter != .MainMenu {
            return nil
        }
        return _playAudio(type: type, file: file, fileExtension: fileExtension, rate: rate)
    }
    
    // Jonathan: New audio "system" to fix an inherent bug with the previous one
    public func _playAudio(type: AudioType, file: String, fileExtension: String, rate:Float) -> AVAudioPlayer? {
        // Fetch the audio path of the desired sound
        let audioPath = Bundle.main.path(forResource: file, ofType: fileExtension, inDirectory: "art.scnassets/Sounds")
        
        // Make sure the asset exists
        if audioPath == nil {
            return nil
        }
        
        var player:AVAudioPlayer? = nil
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            switch type {
                case .Effect:
                    player?.enableRate = true
                    player?.rate = rate
                    player?.setVolume(0.5, fadeDuration: 0)
                case .Background:
                    player?.numberOfLoops = -1
                default:
                    break
            }
            
            // Play the sound
            player?.play()
            
            // Add the sound to our storage list
            self.audioPlayers.insert(player!)
        } catch {
            print("Failed to create AudioPlayer for file '" + file + "." + fileExtension + "'")
        }
        
        return player
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
        case "Terry", "Ollie", "Velma", "Stanley", "Yogi":
            print("Do sideCharacter1 stuff")
            charcterOneIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Lin", "Quinn", "Wallace", "Vivian", "Kimi":
            print("Do sideCharacter2 stuff")
            charcterTwoIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Francine", "Simon", "Winona", "Windsor", "Ernie":
            print("Do sideCharacter3 stuff")
            charcterThreeIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Eric", "Jillian", "Manny", "Isaac":
            print("Do sideCharacter4 stuff")
            charcterFourIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Hannah", "InnerTube", "Ashton", "Tyler":
            print("Do sideCharacter5 stuff")
            charcterFiveIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Indy", "Gary", "Keelie", "Barry", "Ursa", "Lionel", "Finn":
            print("Do mainCharacter stuff")
            mainCharacterIdle?.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        default:
            break
        }
    }
    func stopAnimateSideCharacter(key: String, sideCharacter: String) {
        switch sideCharacter {
        case "Terry", "Ollie", "Velma", "Stanley", "Yogi":
            print("Remove stuff")
            charcterOneIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
            //charcterOneIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
        case "Lin", "Quinn", "Wallace", "Vivian", "Kimi":
            print("Remove stuff")
            //charcterTwoIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterTwoIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Francine", "Simon", "Winona", "Windsor", "Ernie":
            print("Remove stuff")
            //charcterThreeIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterThreeIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Eric", "Jillian", "Manny", "Isaac":
            print("Remove stuff")
            //charcterFourIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterFourIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Hannah", "InnerTube", "Ashton", "Tyler":
            print("Remove stuff")
            //charcterFiveIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            charcterFiveIdle.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        case "Indy", "Gary", "Keelie", "Ursa", "Lionel", "Finn":
            print("Remove stuff")
            //mainCharacterIdle.addAnimation(chapterSelectedAnimationDict[key]!, forKey: key)
            mainCharacterIdle?.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        default:
            break
        }
    }
    func findCharacter() {
        if gameState == .playGame {
            if currentChapter == .Chapter4 {
                // if for some reason we're in game but the character isn't there
                guard let characterNode = mainCharacterIdle else {
                    print("View Controller - Find Character: Could Not Find Main Character")
                    return
                }
                
                //arrow.constraints = [SCNLookAtConstraint.init(target: characterNode)]
                // if the camera is active in the scene, the point of view is what's on screen
                if let pointOfView = sceneView.pointOfView{
                    // ifVisible = Keelie is visible on the screen
                    let isVisible = sceneView.isNode((characterNode.presentation), insideFrustumOf: pointOfView)
                    if isVisible{
                        // if we have established that keelie wasn't on screen
                        if arrowVisible{
                            //arrow.removeFromParentNode()
                            arrowVisible = false
                            // create yellow spotlight to shine on Keelie
                            let lightNode = createSpotLightNode(intensity: 50, spotInnerAngle: 45, spotOuterAngle: 45)
                            lightNode.position = SCNVector3Make(0, 500, 0)
                            lightNode.eulerAngles = SCNVector3Make(-.pi/2, 0, 0)
                            lightItem1 = DispatchWorkItem{
                                lightNode.removeFromParentNode()
                            }
                            characterNode.addChildNode(lightNode)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.lightItem1!)
                            print("View Controller - Find Character: Arrow Removed")
                        }
                    }
                    else {
                        // if we haven't already established that Keelie isn't on screen
                        if !arrowVisible{
                            //sceneView.pointOfView?.addChildNode(arrow)
                            arrowVisible = true
                            print("View Controller - Find Character: Arrow Added")
                        }
                    }
                }
            }
            else if currentChapter == .Chapter9 {
                if patriciaFlying {
                    var characterNode = mainCharacterIdle!
                    switch patriciaNumber {
                        case 1 :
                            characterNode = patricia1!.childNode(withName: "Patricia", recursively: false)!
                        case 2 :
                            characterNode = patricia2!.childNode(withName: "Patricia", recursively: false)!
                        case 3 :
                            characterNode = patricia3!.childNode(withName: "Patricia", recursively: false)!
                        case 4 :
                            characterNode = patricia4!.childNode(withName: "Patricia", recursively: false)!
                        case 5 :
                            characterNode = patricia5!.childNode(withName: "Patricia", recursively: false)!
                        case 6 :
                            characterNode = patricia6!.childNode(withName: "Patricia", recursively: false)!
                        case 7 :
                            characterNode = patricia7!.childNode(withName: "Patricia", recursively: false)!
                        case 8 :
                            characterNode = patricia8!.childNode(withName: "Patricia", recursively: false)!
                        case 9 :
                            characterNode = patricia9!.childNode(withName: "Patricia", recursively: false)!
                        case 10 :
                            characterNode = patricia10!.childNode(withName: "Patricia", recursively: false)!
                        case 11 :
                            characterNode = patricia11!.childNode(withName: "Patricia", recursively: false)!
                        case 12 :
                            characterNode = patricia12!.childNode(withName: "Patricia", recursively: false)!
                        default :
                            characterNode = mainCharacterIdle!
                    }
                
                    //arrow.constraints = [SCNLookAtConstraint.init(target: characterNode)]
                    // if the camera is active in the scene, the point of view is what's on screen
                    if let pointOfView = sceneView.pointOfView{
                        // ifVisible = Patricia is visible on the screen
                        let isVisible = sceneView.isNode((characterNode.presentation), insideFrustumOf: pointOfView)
                        if isVisible{
                            // if we have established that patricia wasn't on screen
                            if arrowVisible{
                                //arrow.removeFromParentNode()
                                arrowVisible = false
                                // create yellow spotlight to shine on Patricia
                                let particles = createParticleSystem()
                                particleItem3 = DispatchWorkItem{
                                    characterNode.removeParticleSystem(particles)
                                }
                                characterNode.addParticleSystem(particles)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.particleItem3!)
                                print("View Controller - Find Character: Arrow Removed \(patriciaNumber)")
                            }
                        }
                        else {
                            // if we haven't already established that Patricia isn't on screen
                            if !arrowVisible{
                                //sceneView.pointOfView?.addChildNode(arrow)
                                arrowVisible = true
                                print("View Controller - Find Character: Arrow Added \(patriciaNumber)")
                            }
                        }
                    }
                }
            }
        }
    }
    func createSpotLightNode(intensity: CGFloat, spotInnerAngle: CGFloat, spotOuterAngle: CGFloat) -> SCNNode {
        // create yellow spotlight
        let light = SCNLight()
        light.type = SCNLight.LightType.spot
        light.intensity = intensity
        light.color = UIColor.yellow
        light.spotInnerAngle = spotInnerAngle
        light.spotOuterAngle = spotOuterAngle
        // create node to add light to
        let lightNode = SCNNode()
        lightNode.light = light
        return lightNode
    }
    func createParticleSystem() -> SCNParticleSystem {
        let particles = SCNParticleSystem()
        particles.birthRate = 6.0
        particles.birthLocation = .surface
        particles.birthDirection = .random
        particles.particleLifeSpan = 0.5
        particles.particleVelocity = 0.5
        particles.speedFactor = 1.0
        particles.particleImage = UIImage(named: "art.scnassets/DotImages/YellowDot.png")
        particles.particleColor = UIColor.yellow
        particles.particleColorVariation = SCNVector4(0,0,0,0)
        particles.particleSize = 0.005
        particles.particleIntensity = 1.0
        particles.emissionDuration = 1.0
        particles.loops = true
        return particles
    }
}

extension ViewController : ARSCNViewDelegate {
    
    // MARK: - SceneKit Management
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.updateStatus()
            self.updateFocusNode()
            self.findCharacter() // chapter 4 to find Keelie
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
        
        DispatchQueue.main.async{
            let planeNode = self.createARPlaneNode(
                planeAnchor: planeAnchor,
                color: UIColor.blue.withAlphaComponent(0))
            node.addChildNode(planeNode)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            
        DispatchQueue.main.async {
            if currentChapter != .MainMenu{
                self.updateARPlaneNode(
                    planeNode: node.childNodes[0],
                    planeAchor: planeAnchor)
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            self.removeARPlaneNode(node: node)
        }
    }
}
