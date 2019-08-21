import Foundation
import UIKit
import ARKit

//GLOBAL VARIABLE THAT CAN BE ACCESSED BY NAME
var chapterSelectedNodeArray: [SCNNode]?
var chapterSelectedLetterArray: [String]?
var chapterSelectedSoundDict: [String: String]?
var chapterSelectedAnimationDict = [String: CAAnimation]() //will this dictionary be reset between chapters I wonder?

class ChapterSelection {
    
    var storyNode: SCNNode!
    var groundNode: SCNNode!
    let maskingNode = SCNNode()
    let idleNode = SCNNode()
    let walkingNode = SCNNode()
    let animationNode = SCNNode()
    let letter1Node = SCNNode()
    let letter2Node = SCNNode()
    let letter3Node = SCNNode()
    let letter4Node = SCNNode()
    let letter5Node = SCNNode()
    let letter6Node = SCNNode()
    
    var narrationPlayer = AVAudioPlayer()
    var FXPlayer = AVAudioPlayer()
    var BGPlayer = AVAudioPlayer()
    var CharacterPlayer = AVAudioPlayer()
    
    func chapterLoader(picked: Int) {
        print("The picked chapter = ", picked)
        
        //change what is loaded into the chapterSelected GLOBAL variable based on what chapter number you pass into this function
        switch picked {
        case 1:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["I", "T", "L", "F", "E", "H"]
            chapterSelectedSoundDict = loadChapter1SoundFiles()
        case 2:
            print("Loading Chapter ", picked)
            //TODO: load chapter 2 files
            chapterSelectedNodeArray = loadChapter2NodeFiles()
            chapterSelectedLetterArray = ["P", "R", "B", "C", "D", "U"]
            chapterSelectedSoundDict = loadChapter2SoundFiles()
        case 3:
            print("Loading Chapter ", picked)
            //TODO: load chapter 3 files
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["G", "O", "Q", "S", "J"]
            chapterSelectedSoundDict = loadChapter3SoundFiles()
        case 4:
            print("Loading Chapter ", picked)
            //TODO: load chapter 4 files
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["K", "V", "W", "M", "A"]
            chapterSelectedSoundDict = loadChapter4SoundFiles()
        case 5:
            print("Loading Chapter ", picked)
            //TODO: load chapter 5 files
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["N", "Z", "Y", "X"]
            chapterSelectedSoundDict = loadChapter5SoundFiles()
        case 6:
            print("Loading Chapter ", picked)
            //TODO: load chapter 6 files
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["c", "a", "d", "g", "o"]
            chapterSelectedSoundDict = loadChapter6SoundFiles()
        case 7:
            print("Loading Chapter ", picked)
            //TODO: load chapter 7 files
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["u", "s", "v", "w", "i", "t"]
            chapterSelectedSoundDict = loadChapter7SoundFiles()
        case 8:
            print("Loading Chapter ", picked)
            //TODO: load chapter 8 files
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["l", "y", "k", "e"]
            chapterSelectedSoundDict = loadChapter8SoundFiles()
        case 9:
            print("Loading Chapter ", picked)
            //TODO: load chapter 9 files
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["p", "r", "n", "h", "B"]
            chapterSelectedSoundDict = loadChapter9SoundFiles()
        case 10:
            print("Loading Chapter ", picked)
            //TODO: load chapter 10 files
            chapterSelectedNodeArray = loadChapter1NodeFiles()
            chapterSelectedLetterArray = ["f", "q", "x", "z"]
            chapterSelectedSoundDict = loadChapter10SoundFiles()
        default:
            break
        }
    }
    
    //chapter 1 stuff here
    func loadChapter1NodeFiles () -> [SCNNode]{
        
        var chapter1NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/AnthonyScene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(1, 1, 1)
        storyNode.position = SCNVector3(0, 0, 0)
        //storyNode.isHidden = true
        
        let idleMainCharacterScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Anthony@IdleFixed.dae")!
        for child in idleMainCharacterScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.02, 0.02, 0.02)
        idleNode.position = SCNVector3(0, 0, 0)
        
        //Load Scene Mask so we only see immidate area
        let maskingScene = SCNScene(named: "art.scnassets/MaskScene.scn")!
        for child in maskingScene.rootNode.childNodes {
            maskingNode.addChildNode(child)
        }
        maskingNode.renderingOrder = -2
        storyNode.addChildNode(maskingNode)
        maskingNode.position = SCNVector3(0, 0, 0)
        //maskingNode.scale = SCNVector3(1, 1, 1)
        
        //Load the shattering A scn into the BugScene
        let shatterAScene = SCNScene(named: "art.scnassets/LetterA@Shatter.scn")!
        for child in shatterAScene.rootNode.childNodes {
            letter1Node.addChildNode(child)
        }
        letter1Node.position = SCNVector3(-13.879, -1, 12)
        //letter1Node.eulerAngles = SCNVector3(0, 0, 0)
        letter1Node.scale = SCNVector3(1.75, 1.75, 1.75)
        //letterANode.renderingOrder = -5
        
        storyNode.childNode(withName: "LVLFloor", recursively: true)!.addChildNode(letter1Node)
        
        //load all the DAE animations for this Chapter
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Anthony@IdleFixed", animationIdentifier: "Anthony@IdleFixed-1")
        prepareAnimation(withKey: "MainCharacterWalking", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Anthony@WalkFixed", animationIdentifier: "Anthony@WalkFixed-1")
        
        //chapter1NodeArray.append(focusNode)
        chapter1NodeArray.append(storyNode)
        
        return chapter1NodeArray
    }
    
    func loadChapter1SoundFiles() -> [String: String] {
        let chapter1SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break3" : "RockBreak3",
                                  "Shatter1" : "RockShatter",
                                  "LetterComplete" : "yeahOutside"]
        return chapter1SoundArray
    }
    
    //chapter 2 stuff here
    func loadChapter2NodeFiles () -> [SCNNode]{
        //var array of chapter 2 assest
        var chapter2NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Environment/Chapter1Scene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(1, 1, 1)
        storyNode.position = SCNVector3(0, 0, 0)
        //storyNode.isHidden = true
        
        //Load Idle Animation Node
        let idleIndyScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Indy/Indy@IdleFixed.dae")!
        for child in idleIndyScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.0002, 0.0002, 0.0002)
        //idleNode.position = SCNVector3(0, 0, 0)
        //idleNode.isHidden = true
        
        //Load Scene Mask so we only see immidate area
        let maskingScene = SCNScene(named: "art.scnassets/MaskScene.scn")!
        for child in maskingScene.rootNode.childNodes {
            maskingNode.addChildNode(child)
        }
        maskingNode.renderingOrder = -2
        storyNode.addChildNode(maskingNode)
        maskingNode.position = SCNVector3(0, 0, 0)
        //maskingNode.scale = SCNVector3(1, 1, 1)
        
        //Load the shattering I scn into the BugScene
        let shatterIScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/I@Shatter.scn")!
        for child in shatterIScene.rootNode.childNodes {
            letter1Node.addChildNode(child)
        }
        //letter1Node.position = SCNVector3(0, 0, 0)
        //letter1Node.eulerAngles = SCNVector3(0, 0, 0)
        //letter1Node.scale = SCNVector3(1.75, 1.75, 1.75)
        //letter1Node.renderingOrder = -5
        
        //Load the shattering T scn into the BugScene
        let shatterTScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/T@Shatter.scn")!
        for child in shatterTScene.rootNode.childNodes {
            letter2Node.addChildNode(child)
        }
        //letter2Node.position = SCNVector3(0, 0, 0)
        //letter2Node.eulerAngles = SCNVector3(0, 0, 0)
        //letter2Node.scale = SCNVector3(1.75, 1.75, 1.75)
        //letter2Node.renderingOrder = -5
        
        //Load the shattering L scn into the BugScene
        let shatterLScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/L@Shatter.scn")!
        for child in shatterLScene.rootNode.childNodes {
            letter3Node.addChildNode(child)
        }
        //letter3Node.position = SCNVector3(0, 0, 0)
        //letter3Node.eulerAngles = SCNVector3(0, 0, 0)
        //letter3Node.scale = SCNVector3(1.75, 1.75, 1.75)
        //letter3Node.renderingOrder = -5
        
        //Load the shattering F scn into the BugScene
        let shatterFScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/F@Shatter.scn")!
        for child in shatterFScene.rootNode.childNodes {
            letter4Node.addChildNode(child)
        }
        //letter4Node.position = SCNVector3(0, 0, 0)
        //letter4Node.eulerAngles = SCNVector3(0, 0, 0)
        //letter4Node.scale = SCNVector3(1.75, 1.75, 1.75)
        //letter4Node.renderingOrder = -5
        
        //Load the shattering E scn into the BugScene
        let shatterEScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/E@Shatter.scn")!
        for child in shatterEScene.rootNode.childNodes {
            letter5Node.addChildNode(child)
        }
        //letter5Node.position = SCNVector3(0, 0, 0)
        //letter5Node.eulerAngles = SCNVector3(0, 0, 0)
        //letter5Node.scale = SCNVector3(1.75, 1.75, 1.75)
        //letter5Node.renderingOrder = -5
        
        //Load the shattering H scn into the BugScene
        let shatterHScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/H@Shatter.scn")!
        for child in shatterHScene.rootNode.childNodes {
            letter6Node.addChildNode(child)
        }
        //letter6Node.position = SCNVector3(0, 0, 0)
        //letter6Node.eulerAngles = SCNVector3(0, 0, 0)
        //letter6Node.scale = SCNVector3(1.75, 1.75, 1.75)
        //letter6Node.renderingOrder = -5
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        lvlFloor.addChildNode(letter1Node)
        lvlFloor.addChildNode(letter2Node)
        lvlFloor.addChildNode(letter3Node)
        lvlFloor.addChildNode(letter4Node)
        lvlFloor.addChildNode(letter5Node)
        lvlFloor.addChildNode(letter6Node)
        
        //load all the DAE animations for this Chapter
        //prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Anthony@IdleFixed", animationIdentifier: "Anthony@IdleFixed-1")
        //prepareAnimation(withKey: "MainCharacterWalking", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Anthony@WalkFixed", animationIdentifier: "Anthony@WalkFixed-1")
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Indy/Indy@IdleFixed", animationIdentifier: "Indy@IdleFixed-1")
        prepareAnimation(withKey: "MainCharacterWalking", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Indy/Indy@WalkFixed", animationIdentifier: "Indy@WalkFixed-1")
        
        //chapter1NodeArray.append(focusNode)
        chapter2NodeArray.append(storyNode)
        
        return chapter2NodeArray
    }
    func loadChapter2SoundFiles() -> [String: String] {
        let chapter2SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break3" : "RockBreak3",
                                  "Shatter1" : "RockShatter",
                                  "LetterComplete" : "yeahOutside"]
        return chapter2SoundArray
    }
    
    //chapter 3 stuff here
    func loadChapter3NodeFiles () -> [SCNNode]{
        //var array of chapter 3 assest
        var chapter3NodeArray: [SCNNode] = []
        
         return chapter3NodeArray
    }
    func loadChapter3SoundFiles() -> [String: String] {
        let chapter3SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break1" : "RockBreak3",
                                  "LetterComplete" : "yeahOutside"]
        return chapter3SoundArray
    }
    
    //chapter 4 stuff here
    func loadChapter4NodeFiles () -> [SCNNode]{
        //var array of chapter 4 assest
        var chapter4NodeArray: [SCNNode] = []
        
        return chapter4NodeArray
    }
    func loadChapter4SoundFiles() -> [String: String] {
        let chapter4SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break1" : "RockBreak3",
                                  "LetterComplete" : "yeahOutside"]
        return chapter4SoundArray
    }
    
    //chapter 5 stuff here
    func loadChapter5NodeFiles () -> [SCNNode]{
        //var array of chapter 5 assest
        var chapter5NodeArray: [SCNNode] = []
        
        return chapter5NodeArray
    }
    func loadChapter5SoundFiles() -> [String: String] {
        let chapter5SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break1" : "RockBreak3",
                                  "LetterComplete" : "yeahOutside"]
        return chapter5SoundArray
    }
    
    //chapter 6 stuff here
    func loadChapter6NodeFiles () -> [SCNNode]{
        //var array of chapter 6 assest
        var chapter6NodeArray: [SCNNode] = []
        
        return chapter6NodeArray
    }
    func loadChapter6SoundFiles() -> [String: String] {
        let chapter6SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break1" : "RockBreak3",
                                  "LetterComplete" : "yeahOutside"]
        return chapter6SoundArray
    }
    
    //chapter 7 stuff here
    func loadChapter7NodeFiles () -> [SCNNode]{
        //var array of chapter 7 assest
        var chapter7NodeArray: [SCNNode] = []
        
        return chapter7NodeArray
    }
    func loadChapter7SoundFiles() -> [String: String] {
        let chapter7SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break1" : "RockBreak3",
                                  "LetterComplete" : "yeahOutside"]
        return chapter7SoundArray
    }
    
    //chapter 8 stuff here
    func loadChapter8NodeFiles () -> [SCNNode]{
        //var array of chapter 8 assest
        var chapter8NodeArray: [SCNNode] = []
        
        return chapter8NodeArray
    }
    func loadChapter8SoundFiles() -> [String: String] {
        let chapter8SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break1" : "RockBreak3",
                                  "LetterComplete" : "yeahOutside"]
        return chapter8SoundArray
    }
    
    //chapter 9 stuff here
    func loadChapter9NodeFiles () -> [SCNNode]{
        //var array of chapter 9 assest
        var chapter9NodeArray: [SCNNode] = []
        
        return chapter9NodeArray
    }
    func loadChapter9SoundFiles() -> [String: String] {
        let chapter9SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break1" : "RockBreak3",
                                  "LetterComplete" : "yeahOutside"]
        return chapter9SoundArray
    }
    
    //chapter 10 stuff here
    func loadChapter10NodeFiles () -> [SCNNode]{
        //var array of chapter 10 assest
        var chapter10NodeArray: [SCNNode] = []
        
        return chapter10NodeArray
    }
    func loadChapter10SoundFiles() -> [String: String] {
        let chapter10SoundArray = ["Narration1" : "Line1",
                                  "Narration2" : "Line2",
                                  "Narration3" : "Line3",
                                  "Narration4" : "Line4",
                                  "Narration5" : "Line5",
                                  "Narration6" : "Line6",
                                  "Narration7" : "Line7",
                                  "Narration8" : "Line8",
                                  "Background1" : "Birds1",
                                  "Background2" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "Coin1" : "xylophone2",
                                  "Break1" : "RockBreak3",
                                  "LetterComplete" : "yeahOutside"]
        return chapter10SoundArray
    }
    
    //prep the animations by loading them into an public Animations Dictionary
    func prepareAnimation(withKey: String, sceneName: String, animationIdentifier: String) {
        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae")
        let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)
        
        if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
            //the animation will play continuously
            //animationObject.repeatCount = -1
            //create smooth transition between animations
            animationObject.fadeInDuration = CGFloat(1)
            animationObject.fadeOutDuration = CGFloat(0.5)
            
            if animationIdentifier == "Anthony@WalkFixed-1" {
                animationObject.duration = 2.083
            }
            if animationIdentifier == "Indy@WalkingFixed-1" {
                animationObject.duration = 2.083
            }
            
            //Store the animationfor later use
            chapterSelectedAnimationDict[withKey] = animationObject
        }
        //playAnimation(key: "idle")
    }
}
