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
    
    //MARK: ACTIONS
    @IBAction func goButtonPressed(_ sender: Any) {
    }
    @IBAction func setStudentInfo(_ sender: UIButton) {
    }
    @IBAction func startButtonPressed(_ sender: Any) {
        self.startGame()
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        self.resetGame()
    }
    @IBAction func walkButtonPressed(_ sender: Any) {
        self.anthonyWalk()
    }
    @IBAction func showAllButtonPressed(_ sender: Any) {
        if maskingNode.isHidden == true {
            maskingNode.isHidden = false
        }
        else{
            maskingNode.isHidden = true
        }
    }
    
    
    // MARK: - VARIABLES
    var trackingStatus: String = ""
    var statusMessage: String = ""
    var gameState: GameState = .detectSurface
    var focusPoint: CGPoint!
    var focusNode: SCNNode!
    var groundNode: SCNNode!
    var storyNode: SCNNode!
    let animationNode = SCNNode()
    let walkingNode = SCNNode()
    let idleNode = SCNNode()
    let maskingNode = SCNNode()

    var idle: Bool = true
    
    var isWalking: Bool = false
    
    var walkPlayer = AVAudioPlayer()
    var birdsPlayer = AVAudioPlayer()
    var narrationPlayer1 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSceneView()
        self.initScene()
        self.initARSession()
        self.loadModels()
        
        //setup audio player
        let walkAudioPath = Bundle.main.path(forResource: "Gravel and Grass Walk", ofType: "wav", inDirectory: "art.scnassets/Sounds")
        let birdsAudioPath = Bundle.main.path(forResource: "Birds2", ofType: "wav", inDirectory: "art.scnassets/Sounds")
        //let crack3AudioPath = Bundle.main.path(forResource: "RockBreak1", ofType: "wav")
        //let narrationAudioPath = Bundle.main.path(forResource: "", ofType: "wav")
        
        do
        {
            try walkPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: walkAudioPath!))
            walkPlayer.enableRate = true
            walkPlayer.rate = 0.5
            
        } catch {
            print("WalkPlayer not available!")
        }
        do
        {
            try birdsPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: birdsAudioPath!))
            
        } catch {
            print("birdsPlayer not available!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("*** ViewWillAppear()")
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
        //sceneView.preferredFramesPerSecond = 60
        //sceneView.antialiasingMode = .multisampling2X
        //sceneView.debugOptions = [
        //ARSCNDebugOptions.showFeaturePoints,
        //ARSCNDebugOptions.showWorldOrigin,
        //SCNDebugOptions.showPhysicsShapes,
        //SCNDebugOptions.showBoundingBoxes
        //]
        
        focusPoint = CGPoint(x: view.center.x, y: view.center.y + view.center.y * 0.25)
    }
    
    func initScene() {
        let scene = SCNScene()
        //scene.lightingEnvironment.contents = "art.scnassets/Textures/Environment_CUBE.jpg"
        //scene.lightingEnvironment.intensity = 2
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
        // Update storyNode Node
        self.storyNode.position = self.focusNode.position
        
        //Update Animation Node
        self.animationNode.position = self.focusNode.position
        //self.animationNode.physicsBody?.resetTransform()
    }

    
    // MARK: Game Management
    
    func startGame() {
        guard self.gameState == .hitStartToPlay else { return }
        DispatchQueue.main.async {
            self.updatePositions()
            self.storyNode.isHidden = false
            self.idleNode.isHidden = false
            self.gameState = .playGame
            self.birdsPlayer.play()
            self.birdsPlayer.numberOfLoops = -1
        }
    }
    
    func resetGame(){
        guard self.gameState == .playGame else { return }
        DispatchQueue.main.async {
            self.storyNode.isHidden = true
            self.idleNode.isHidden = true
            self.walkingNode.isHidden = true
            self.gameState = .detectSurface
            self.birdsPlayer.stop()
            self.walkPlayer.stop()
        }
    }
    
    func loadModels() {
        
        // Load Focus Node
        let focusScene = SCNScene(named: "art.scnassets/FocusScene.scn")!
        focusNode = focusScene.rootNode.childNode(withName: "focus", recursively: false)
        focusNode.isHidden = true
        sceneView.scene.rootNode.addChildNode(focusNode)
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/AnthonyScene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "anthony", recursively: true)
        storyNode.scale = SCNVector3(1, 1, 1)
        storyNode.position = SCNVector3(0, -10, 0)
        storyNode.isHidden = true
        sceneView.scene.rootNode.addChildNode(storyNode)
        
        //Load Idle Animation Node
        let idleAnthonyScene = SCNScene(named: "art.scnassets/Anthony@Idle.scn")!
        for child in idleAnthonyScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.02, 0.02, 0.02)
        walkingNode.position = SCNVector3(0, 0, 0)
        idleNode.isHidden = true
        
        //Load walking Animation Node
        let walkingAnthonyScene = SCNScene(named: "art.scnassets/Anthony@Walk.scn")!
        for child in walkingAnthonyScene.rootNode.childNodes {
            walkingNode.addChildNode(child)
        }
        storyNode.addChildNode(walkingNode)
        walkingNode.position = SCNVector3(0, 0, 0)
        walkingNode.scale = SCNVector3(0.02, 0.02, 0.02)
        walkingNode.isHidden = true
        
        //Load Scene Mask so we only see immidate area
        let maskingScene = SCNScene(named: "art.scnassets/MaskScene.scn")!
        for child in maskingScene.rootNode.childNodes {
            maskingNode.addChildNode(child)
        }
        //maskingNode.position = SCNVector3(0, 0, 0)
        //maskingNode.scale = SCNVector3(1, 1, 1)
        storyNode.addChildNode(maskingNode)
    }
    
    func anthonyWalk() {
        if(idle) {
            playAnimation1()
            isWalking = true
        }
        else {
            stopAnimation()
            isWalking = false
        }
        idle = !idle
        return
    }
    
    func playAnimation1() {
        
        walkingNode.isHidden = false
        idleNode.isHidden = true
        
        //start playing the walking sound
        walkPlayer.setVolume(0.5, fadeDuration: 0)
        walkPlayer.play()
        
        let ground = storyNode.childNode(withName: "BUGScene", recursively: false)
        ground?.runAction(SCNAction.moveBy(x: -0.1, y: 0, z: -0.8, duration: 15), completionHandler: stopAnimation)
        walkingNode.runAction(SCNAction.rotateBy(x: 0, y: 0.3, z: 0, duration: 15))
        idleNode.position = walkingNode.position
    }
    func stopAnimation() {
        
        idleNode.isHidden = false
        walkingNode.isHidden = true
        walkPlayer.setVolume(0, fadeDuration: 0.75)
        
        //stop playing the walking sound
        walkPlayer.stop()
        walkPlayer.setVolume(1, fadeDuration: 0)
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
