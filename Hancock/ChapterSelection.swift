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
    let SideCharacter1idleNode = SCNNode()
    let SideCharacter2idleNode = SCNNode()
    let SideCharacter3idleNode = SCNNode()
    let SideCharacter4idleNode = SCNNode()
    let SideCharacter5idleNode = SCNNode()
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
        //var array of chapter 1 assest
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
        
        //Load the shattering T scn into the BugScene
        let shatterTScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/T@Shatter.scn")!
        for child in shatterTScene.rootNode.childNodes {
            letter2Node.addChildNode(child)
        }
        
        //Load the shattering L scn into the BugScene
        let shatterLScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/L@Shatter.scn")!
        for child in shatterLScene.rootNode.childNodes {
            letter3Node.addChildNode(child)
        }
        
        //Load the shattering F scn into the BugScene
        let shatterFScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/F@Shatter.scn")!
        for child in shatterFScene.rootNode.childNodes {
            letter4Node.addChildNode(child)
        }
        
        //Load the shattering E scn into the BugScene
        let shatterEScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/E@Shatter.scn")!
        for child in shatterEScene.rootNode.childNodes {
            letter5Node.addChildNode(child)
        }
        
        //Load the shattering H scn into the BugScene
        let shatterHScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Letters/H@Shatter.scn")!
        for child in shatterHScene.rootNode.childNodes {
            letter6Node.addChildNode(child)
        }
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        lvlFloor.addChildNode(letter1Node)
        lvlFloor.addChildNode(letter2Node)
        lvlFloor.addChildNode(letter3Node)
        lvlFloor.addChildNode(letter4Node)
        lvlFloor.addChildNode(letter5Node)
        lvlFloor.addChildNode(letter6Node)
        
        //Load Idle Animation Node
        //let idleTerryScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Terry/Terry@IdleFixed.dae")!
        let idleTerryScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Terry/Terry@DanceFixed.dae")!
        for child in idleTerryScene.rootNode.childNodes {
            SideCharacter1idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter1idleNode)
        SideCharacter1idleNode.scale = SCNVector3(0.003, 0.003, 0.003)
        SideCharacter1idleNode.position = SCNVector3(-19.4, 5.45, -0.4)
        
        //Load Idle Animation Node
        //let idleLinScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Lin/Lin@IdleFixed.dae")!
        let idleLinScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Lin/Lin@IdleFixed.dae")! //temp idle
        for child in idleLinScene.rootNode.childNodes {
            SideCharacter2idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter2idleNode)
        SideCharacter2idleNode.scale = SCNVector3(0.002, 0.002, 0.002)
        //SideCharacter2idleNode.eulerAngles = SCNVector3(0, -61, 0)
        SideCharacter2idleNode.eulerAngles = SCNVector3(0, -51, 0)
        SideCharacter2idleNode.position = SCNVector3(-7.26, 1.9, -16.45)
        
        //Load Idle Animation Node
        //let idleFrancineScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@IdleFixed.dae")!
        let idleFrancineScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@DanceSpinHopFixed.dae")!
        for child in idleFrancineScene.rootNode.childNodes {
            SideCharacter3idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter3idleNode)
        SideCharacter3idleNode.scale = SCNVector3(0.002, 0.002, 0.002)
        SideCharacter3idleNode.eulerAngles = SCNVector3(0, -135, 0)
        SideCharacter3idleNode.position = SCNVector3(4.4, 3.8, 11.9)
        
        //Load Idle Animation Node
        let idleEricScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@IdleFixed.dae")!
        for child in idleEricScene.rootNode.childNodes {
            SideCharacter4idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter4idleNode)
        SideCharacter4idleNode.scale = SCNVector3(1, 1, 1)
        //SideCharacter4idleNode.position = SCNVector3(4.4, 1.97, -6.62)
        SideCharacter4idleNode.position = SCNVector3(6.88, 1.97, -6.9)
        SideCharacter4idleNode.eulerAngles = SCNVector3(0, 90, 0)
        
        //Load Idle Animation Node
        //let idleHannahScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@IdleFixed.dae")!
        let idleHannahScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@DanceFixed.dae")!
        for child in idleHannahScene.rootNode.childNodes {
            SideCharacter5idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter5idleNode)
        SideCharacter5idleNode.scale = SCNVector3(0.003, 0.003, 0.003)
        SideCharacter5idleNode.eulerAngles = SCNVector3(0, 45, 0)
        SideCharacter5idleNode.position = SCNVector3(19.35, 1.15, -15.25)
        
        //load all the DAE animations for this Chapter
        //load animations for mainCharacter
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Indy/Indy@IdleFixed", animationIdentifier: "Indy@IdleFixed-1")
        prepareAnimation(withKey: "MainCharacterWalking", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Indy/Indy@WalkFixed", animationIdentifier: "Indy@WalkFixed-1")
        //load animation for side character 1
        //prepareAnimation(withKey: "SideCharacter1Idle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Terry/Terry@IdleFixed", animationIdentifier: "Terry@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter1Walking", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Terry/Terry@WalkingFixed", animationIdentifier: "Terry@WalkingFixed-1")
        prepareAnimation(withKey: "SideCharacter1Waving", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Terry/Terry@WavingFixed", animationIdentifier: "Terry@WavingFixed-1")
        prepareAnimation(withKey: "SideCharacter1Dancing", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Terry/Terry@DanceFixed", animationIdentifier: "Terry@DanceFixed-1")
        
        //load animation for side character 2
        prepareAnimation(withKey: "SideCharacter2Idle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Lin/Lin@IdleFixed", animationIdentifier: "Lin@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter2Walking", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Lin/Lin@WalkingFixed", animationIdentifier: "Lin@WalkingFixed-1")
        prepareAnimation(withKey: "SideCharacter2Dancing", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Lin/Lin@TwistDanceFixed", animationIdentifier: "Lin@TwistDanceFixed-1")
        
        //load animation for side character 3
        prepareAnimation(withKey: "SideCharacter3Idle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@IdleFixed", animationIdentifier: "Francine@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter3Walk", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@HappyWalkFixed", animationIdentifier: "Francine@HappyWalkFixed-1")
        prepareAnimation(withKey: "SideCharacter3Jump", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@JumpFixed", animationIdentifier: "Francine@JumpFixed-1")
        prepareAnimation(withKey: "SideCharacter3Dance1", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@DanceSpinHopFixed", animationIdentifier: "Francine@DanceSpinHopFixed-1")
        prepareAnimation(withKey: "SideCharacter3Dance2", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@HipHopDanceFixed", animationIdentifier: "Francine@HipHopDanceFixed-1")
        
        //load animation for side character 4
        prepareAnimation(withKey: "SideCharacter4Idle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@IdleFixed", animationIdentifier: "Eric@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter4Walk", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@WalkFixed", animationIdentifier: "Eric@WalkFixed-1")
        prepareAnimation(withKey: "SideCharacter4Dance1", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@Dance1Fixed", animationIdentifier: "Eric@Dance1Fixed-1")
        prepareAnimation(withKey: "SideCharacter4Dance2", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@WormDanceFixed", animationIdentifier: "Eric@WormDanceFixed-1")
        prepareAnimation(withKey: "SideCharacter4Climb", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@ClimbDownFixed", animationIdentifier: "Eric@ClimbDownFixed-1")
        
        //load animation for side character 5
        prepareAnimation(withKey: "SideCharacter5Idle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@IdleFixed", animationIdentifier: "Hannah@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter5Walk", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@WalkFixed", animationIdentifier: "Hannah@WalkFixed-1")
        prepareAnimation(withKey: "SideCharacter5Surprise", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@SurpriseFixed", animationIdentifier: "Hannah@SurpriseFixed-1")
        prepareAnimation(withKey: "SideCharacter5Dance", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@DanceFixed", animationIdentifier: "Hannah@DanceFixed-1")
        
        //chapter1NodeArray.append(focusNode)
        chapter2NodeArray.append(storyNode)
        
        return chapter2NodeArray
    }
    
    func loadChapter1SoundFiles() -> [String: String] {
        let chapter1SoundArray = [ //sounds for Letter I
                                  "Narration1" : "ch1-I-Intro1",
                                  "Narration2" : "ch1-I-Intro2",
                                  "Narration3" : "ch1-I-Line1",
                                  "Narration4" : "ch1-I-Line2_01",
                                  "Narration5" : "ch1-I-Line2_02",
                                  "Narration6" : "ch1-I-Line3_01",
                                  "Narration7" : "ch1-I-Line3_02",
                                  "Narration8" : "ch1-I-Line4_01",
                                  "Narration9" : "ch1-I-Line4_02",
                                  //sounds for Letter T
                                  "Narration10" : "ch1-T-Intro1",
                                  "Narration11" : "ch1-T-Intro2",
                                  "Narration12" : "ch1-T-Line1",
                                  "Narration13" : "ch1-T-Line2_01",
                                  "Narration14" : "ch1-T-Line2_02",
                                  "Narration15" : "ch1-T-Line3_01",
                                  //sounds for Letter L
                                  "Narration17" : "ch1-L-Intro1",
                                  "Narration18" : "ch1-L-Intro2",
                                  "Narration19" : "ch1-L-Line1",
                                  "Narration20" : "ch1-L-Line2_01",
                                  "Narration21" : "ch1-L-Line2_02",
                                  "Narration22" : "ch1-L-Line3_01",
                                  //sounds for Letter F
                                  "Narration23" : "ch1-F-Intro1",
                                  "Narration24" : "ch1-F-Intro2",
                                  "Narration25" : "ch1-F-Line1",
                                  "Narration26" : "ch1-F-Line2_01",
                                  "Narration27" : "ch1-F-Line2_02",
                                  "Narration28" : "ch1-F-Line3_01",
                                  "Narration29" : "ch1-F-Line3_02",
                                  "Narration30" : "ch1-F-Line4_01",
                                  //sounds for Letter E
                                  "Narration31" : "ch1-E-Intro1",
                                  "Narration32" : "ch1-E-Intro2",
                                  "Narration33" : "ch1-E-Line1",
                                  "Narration34" : "ch1-E-Line2_01",
                                  "Narration35" : "ch1-E-Line2_02",
                                  "Narration36" : "ch1-E-Line3_01",
                                  "Narration37" : "ch1-E-Line3_02",
                                  "Narration38" : "ch1-E-Line4_01",
                                  "Narration39" : "ch1-E-Line4_02",
                                  "Narration40" : "ch1-E-Line5_01",
                                  //sounds for Letter H
                                  "Narration42" : "ch1-H-Intro1",
                                  "Narration43" : "ch1-H-Intro2",
                                  "Narration44" : "ch1-H-Intro3",
                                  "Narration45" : "ch1-H-Line1",
                                  "Narration46" : "ch1-H-Line2_01",
                                  "Narration47" : "ch1-H-Line2_02",
                                  "Narration48" : "ch1-H-Line3_01",
                                  "Narration49" : "ch1-H-Line3_02",
                                  "Narration50" : "ch1-H-Line4_01",
                                  //letter finish sounds
                                  "letter2Finish" : "ch1-T-Line4",
                                  "letter3Finish" : "ch1-L-Line3_02",
                                  "letter4Finish" : "ch1-F-Line4_02",
                                  "letter5Finish" : "ch1-E-Line5_02",
                                  "letter6Finish" : "ch1-H-Line4_01",
                                  "chapterFinish" : "ch1-H-Line4_02",
                                  //extra chapter FX sounds
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
        //var array of chapter 3 assest
        var chapter2NodeArray: [SCNNode] = []
        
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
