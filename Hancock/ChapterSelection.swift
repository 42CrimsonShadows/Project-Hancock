import Foundation
import UIKit
import ARKit

//GLOBAL VARIABLE THAT CAN BE ACCESSED BY NAME
var chapterSelectedNodeArray: [SCNNode]?
var chapterSelectedLetterArray: [String]?
var chapterSelectedSoundDict: [String: String]?
var chapterSelectedAnimationDict = [String: CAAnimation]() //will this dictionary be reset between chapters?

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
    let SideCharacter6idleNode = SCNNode()
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
            chapterSelectedNodeArray = loadChapter2NodeFiles()
            chapterSelectedLetterArray = ["P", "R", "B", "C", "D", "U"]
            chapterSelectedSoundDict = loadChapter2SoundFiles()
        case 3:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter3NodeFiles()
            chapterSelectedLetterArray = ["G", "Q", "S", "J", "O"]
            chapterSelectedSoundDict = loadChapter3SoundFiles()
        case 4:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter4NodeFiles()
            chapterSelectedLetterArray = ["K", "V", "W", "M", "A"]
            chapterSelectedSoundDict = loadChapter4SoundFiles()
        case 5:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter5NodeFiles()
            chapterSelectedLetterArray = ["N", "Z", "Y", "X"]
            chapterSelectedSoundDict = loadChapter5SoundFiles()
        case 6:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter6NodeFiles()
            chapterSelectedLetterArray = ["c", "a", "d", "g", "o"]
            chapterSelectedSoundDict = loadChapter6SoundFiles()
        case 7:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter7NodeFiles()
            chapterSelectedLetterArray = ["u", "s", "v", "w", "i", "t"]
            chapterSelectedSoundDict = loadChapter7SoundFiles()
        case 8:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter8NodeFiles()
            chapterSelectedLetterArray = ["l", "y", "k", "j", "e"]
            chapterSelectedSoundDict = loadChapter8SoundFiles()
        case 9:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter9NodeFiles()
            chapterSelectedLetterArray = ["p", "r", "n", "m", "h", "b"]
            chapterSelectedSoundDict = loadChapter9SoundFiles()
        case 10:
            print("Loading Chapter ", picked)
            chapterSelectedNodeArray = loadChapter10NodeFiles()
            chapterSelectedLetterArray = ["f", "q", "x", "z"]
            chapterSelectedSoundDict = loadChapter10SoundFiles()
        case 11:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["-"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        case 12:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["/"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        case 13:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["'\'"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        case 14:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["|"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        case 15:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["cross+"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        case 16:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["crossx"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        case 17:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["square"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        case 18:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["circle"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        case 19:
            print("Loading Chapter ", picked)
            chapterSelectedLetterArray = ["triangle"]
            chapterSelectedSoundDict = loadlineTypeSoundFiles()
        default:
            break
        }
    }
    
    //chapter 1 stuff here
    func loadChapter1NodeFiles () -> [SCNNode]{
        //var array of chapter 1 assest
        var chapter1NodeArray: [SCNNode] = []
        
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
        idleNode.position = SCNVector3(0.05, 0, 0)
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
        let idleTerryScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Terry/Terry@WavingFixed.dae")!
        for child in idleTerryScene.rootNode.childNodes {
            SideCharacter1idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter1idleNode)
        SideCharacter1idleNode.scale = SCNVector3(0.003, 0.003, 0.003)
        SideCharacter1idleNode.position = SCNVector3(-19.4, 5.45, -0.4)
        
        //Load Idle Animation Node
        //let idleLinScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Lin/Lin@IdleFixed.dae")!
        let idleLinScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Lin/Lin@TwistDanceFixed.dae")! //temp idle
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
        //SideCharacter3idleNode.eulerAngles = SCNVector3(0, -135, 0)
        SideCharacter3idleNode.eulerAngles = SCNVector3(0, -135, 0)
        SideCharacter3idleNode.position = SCNVector3(4.4, 3.8, 11.9)
        
        //Load Idle Animation Node
        let idleEricScene = SCNScene(named: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@IdleFixed.dae")!
        for child in idleEricScene.rootNode.childNodes {
            SideCharacter4idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter4idleNode)
        SideCharacter4idleNode.scale = SCNVector3(1, 1, 1)
        SideCharacter4idleNode.position = SCNVector3(6.85, 2, -6.55)
        SideCharacter4idleNode.eulerAngles = SCNVector3(0, 1.45, 0)
        
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
        prepareAnimation(withKey: "MainCharacterDance", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Indy/Indy@DanceFixed", animationIdentifier: "Indy@DanceFixed-1")
        
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
        prepareAnimation(withKey: "SideCharacter3Jump", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@Jump2Fixed", animationIdentifier: "Francine@Jump2Fixed-1")
        prepareAnimation(withKey: "SideCharacter3Dance1", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@DanceSpinHopFixed", animationIdentifier: "Francine@DanceSpinHopFixed-1")
        prepareAnimation(withKey: "SideCharacter3Dance2", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Francine/Francine@HipHopDanceFixed", animationIdentifier: "Francine@HipHopDanceFixed-1")
        
        //load animation for side character 4
        prepareAnimation(withKey: "SideCharacter4Idle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@IdleFixed", animationIdentifier: "Eric@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter4Walk", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@WalkFixed", animationIdentifier: "Eric@WalkFixed-1")
        prepareAnimation(withKey: "SideCharacter4Dance1", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@Dance1Fixed", animationIdentifier: "Eric@Dance1Fixed-1")
        prepareAnimation(withKey: "SideCharacter4Dance2", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@WormDanceFixed", animationIdentifier: "Eric@WormDanceFixed-1")
        prepareAnimation(withKey: "SideCharacter4Climb", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Eric/Eric@ClimbDownAndWalkFixed", animationIdentifier: "Eric@ClimbDownAndWalkFixed-1")
        
        //load animation for side character 5
        prepareAnimation(withKey: "SideCharacter5Idle", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@IdleFixed", animationIdentifier: "Hannah@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter5Walk", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@WalkFixed", animationIdentifier: "Hannah@WalkFixed-1")
        prepareAnimation(withKey: "SideCharacter5Surprise", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@SurpriseFixed", animationIdentifier: "Hannah@SurpriseFixed-1")
        prepareAnimation(withKey: "SideCharacter5Dance", sceneName: "art.scnassets/3DModels/Chapter1Files/Characters/Hannah/Hannah@DanceFixed", animationIdentifier: "Hannah@DanceFixed-1")
           
        chapter1NodeArray.append(storyNode)
        
        return chapter1NodeArray
    }
    
    func loadChapter1SoundFiles() -> [String: String] {
        let chapter1SoundArray = [ //sounds for Letter I
                                  "Narration1" : "ch1-I-Intro1",
                                  "Narration2" : "ch1-I-Intro2", 
                                  "Narration3" : "ch1-I-Line1",     //1 narration3
                                  "Narration4" : "ch1-I-Line2_01",  //2 narration4
                                  "Narration5" : "ch1-I-Line2_02",
                                  "Narration6" : "ch1-I-Line3_01",  //3 narration6
                                  //"Narration7" : "ch1-I-Line3_02", purple to yellow X.x
                                  //Narration5" : "ch1-E-Line3_02", //"Next" yellow to purple
                                  "Narration7" : "ch1-F-Line3_02", //"Finally" yellow to purple
                                  "Narration8" : "ch1-I-Line4_01",  //4 narration8
                                  "Narration9" : "ch1-I-Line4_02", //You have traced the letter I and Indie is on his way
                                  
                                  //sounds for Letter T
                                  "Narration10" : "ch1-T-Intro1",
                                  "Narration11" : "ch1-T-Intro2",
                                  "Narration12" : "ch1-T-Line1",    //1 narration12
                                  "Narration13" : "ch1-T-Line2_01", //2 narration13
                                  "Narration14" : "ch1-T-Line2_02",
                                  "Narration15" : "ch1-T-Line3_01", //3 narration14
                                   "Narration16": "ch1-T-Line3_02", //You have traced the Letter T and Terry is free
            
                                  //sounds for Letter L
                                  "Narration17" : "ch1-L-Intro1",
                                  "Narration18" : "ch1-L-Intro2",
                                  "Narration19" : "ch1-L-Line1",    //1 narration19
                                  "Narration20" : "ch1-L-Line2_01", //2 narration20
                                  "Narration21" : "ch1-L-Line2_02",
                                  "Narration22" : "ch1-L-Line3_01", //3 narration21
            
                                  //sounds for Letter F
                                  "Narration23" : "ch1-F-Intro1",
                                  "Narration24" : "ch1-F-Intro2",
                                  "Narration25" : "ch1-F-Line1",    //1 narration25
                                  "Narration26" : "ch1-F-Line2_01", //2 narration26
                                  "Narration27" : "ch1-F-Line2_02",
                                  "Narration28" : "ch1-F-Line3_01", //3 narration28
                                  "Narration29" : "ch1-F-Line3_02",
                                  "Narration30" : "ch1-F-Line4_01", //4 narration30
            
                                  //sounds for Letter E
                                  "Narration31" : "ch1-E-Intro1",
                                  "Narration32" : "ch1-E-Intro2",
                                  "Narration33" : "ch1-E-Line1",    //1 narration33
                                  "Narration34" : "ch1-E-Line2_01", //2 narration34
                                  "Narration35" : "ch1-E-Line2_02",
                                  "Narration36" : "ch1-E-Line3_01", //3 narration36
                                  "Narration37" : "ch1-E-Line3_02",
                                  "Narration38" : "ch1-E-Line4_01", //4 narration38
                                  "Narration39" : "ch1-E-Line2_02",
                                  "Narration40" : "ch1-E-Line5_01", //5 narration40
            
                                  //sounds for Letter H
                                  "Narration42" : "ch1-H-Intro1",
                                  "Narration43" : "ch1-H-Intro2",
                                  "Narration44" : "ch1-H-Intro3", //Can you trace the letter H to help all her friends say happy birthday
                                  "Narration45" : "ch1-H-Line1",    //1 narration45
                                  "Narration46" : "ch1-H-Line2_01", //2 narration46
                                  "Narration47" : "ch1-H-Line2_02",
                                  "Narration48" : "ch1-H-Line3_01", //3 narration48
                                  "Narration49" : "ch1-H-Line3_02",
                                  "Narration50" : "ch1-F-Line4_01", //4 narration50 awesome job
            
                                  //letter finish sounds
                                  "letter2Finish" : "ch1-T-Line4",
                                  "letter3Finish" : "ch1-L-Line3_02",
                                  "letter4Finish" : "ch1-F-Line4_02",
                                  "letter5Finish" : "ch1-E-Line5_02",
                                  "letter6Finish" : "ch1-H-Line4_01",
                                  "chapterFinish" : "ch1-H-Line4_02",
                                  
                                  //extra chapter FX sounds
                                  "BackgroundSound" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "CoinDing1" : "bell-ding_01",
                                  "CoinDing2" : "bell-ding_02",
                                  "CoinDing3" : "bell-ding_03",
                                  "CoinDing4" : "bell-ding_04",
                                  "Break3" : "RockBreak3",
                                  "Shatter1" : "RockShatter",
                                  "Stop" : "stop",
                                  "LetterComplete" : "yeahOutside"]
        return chapter1SoundArray
    }
    
    //chapter 2 stuff here
    func loadChapter2NodeFiles () -> [SCNNode]{
        
        //var array of chapter 2 assest
        var chapter2NodeArray: [SCNNode] = []

        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter2Files/Environment/Chapter2Scene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(1, 1, 1)
        storyNode.position = SCNVector3(0, 0, 0)
        //storyNode.isHidden = true
        
        //Load Idle Animation Node
        let idlePiperScene = SCNScene(named: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@IdleFixed.dae")!
        for child in idlePiperScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.008, 0.008, 0.008)
        idleNode.position = SCNVector3(0.092, 0.078, -0.021)
        //idleNode.isHidden = true
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        
        let outfit1Scene = SCNScene(named: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Outfit1.scn")!
        for child in outfit1Scene.rootNode.childNodes {
            SideCharacter1idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter1idleNode)
        SideCharacter1idleNode.scale = SCNVector3(0.6, 0.6, 0.6)
        SideCharacter1idleNode.position = SCNVector3(-4, 2.5, -4)
        SideCharacter1idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(0), 0)
        
        let outfit2Scene = SCNScene(named: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Outfit2.scn")!
        for child in outfit2Scene.rootNode.childNodes {
            SideCharacter2idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter2idleNode)
        SideCharacter2idleNode.scale = SCNVector3(0.6, 0.6, 0.6)
        SideCharacter2idleNode.position = SCNVector3(-1.5, 2.5, -4)
        SideCharacter2idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(0), 0)
        
        let outfit3Scene = SCNScene(named: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Outfit3.scn")!
        for child in outfit3Scene.rootNode.childNodes {
            SideCharacter3idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter3idleNode)
        SideCharacter3idleNode.scale = SCNVector3(0.6, 0.6, 0.6)
        SideCharacter3idleNode.position = SCNVector3(1.5, 2.5, -4)
        SideCharacter3idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(0), 0)
        
        let outfit4Scene = SCNScene(named: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Outfit4.scn")!
        for child in outfit4Scene.rootNode.childNodes {
            SideCharacter4idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter4idleNode)
        SideCharacter4idleNode.scale = SCNVector3(0.6, 0.6, 0.6)
        SideCharacter4idleNode.position = SCNVector3(4, 2.5, -4)
        SideCharacter4idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(0), 0)

        //load all the DAE animations for this Chapter
        //load animations for mainCharacter
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@IdleFixed", animationIdentifier: "Piper@IdleFixed-1")
        prepareAnimation(withKey: "MainCharacterSkating", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@PushOff-Fixed", animationIdentifier: "Piper@PushOff-Fixed-1")
        prepareAnimation(withKey: "MainCharacterStopping", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@Stopping-Fixed", animationIdentifier: "Piper@Stopping-Fixed-1")
        prepareAnimation(withKey: "MainCharacterCheering", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@CheerFixed", animationIdentifier: "Piper@CheerFixed-1")
        
        prepareAnimation(withKey: "MainCharacterP", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@LetterPTrickFixed", animationIdentifier: "Piper@LetterPTrickFixed-1")
        prepareAnimation(withKey: "MainCharacterR", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@LetterRTrickFixed", animationIdentifier: "Piper@LetterRTrickFixed-1")
        prepareAnimation(withKey: "MainCharacterB", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@LetterBTrickFixed", animationIdentifier: "Piper@LetterBTrickFixed-1")
        prepareAnimation(withKey: "MainCharacterC", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@LetterCTrickFixed", animationIdentifier: "Piper@LetterCTrickFixed-1")
        prepareAnimation(withKey: "MainCharacterD", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@LetterDTrickFixed", animationIdentifier: "Piper@LetterDTrickFixed-1")
        prepareAnimation(withKey: "MainCharacterU", sceneName: "art.scnassets/3DModels/Chapter2Files/Characters/Piper/Piper@LetterUTrickFixed", animationIdentifier: "Piper@LetterUTrickFixed-1")

        chapter2NodeArray.append(storyNode)
        
        return chapter2NodeArray
    }
    
    func loadChapter2SoundFiles() -> [String: String] {
        let chapter2SoundArray = [ //sounds for Letter P
                                    "Narration1" : "ch2-P-Intro1", //"Hi, I'm Piper" LM
                                    "Narration2" : "ch2-P-Intro2",//"Thank you, I look great!" LM
                                    "Narration2_1" : "ch2-P-Intro3", //"Sometimes when I am learning something new..." LM
                                    "Narration3" : "ch2-P-Line0",//"Trace the P to start my journey" LM
                                    "Narration4" : "ch1-E-Line1",//"Trace the green dot to the red dot LM
                                    "Narration6" : "ch1-E-Line2_02",//"Trace the blue dot to the orange dot" LM
                                    
                                    //sounds for Letter R
                                    "Narration11" : "ch2-R-Line0", //"Trace the R to help me go far" LM
                                    "Narration12" : "ch1-E-Line1",//"Trace the green dot to the red dot" LM
                                    "Narration13" : "ch1-E-Line2_02",//Trace the blue dot to the orange dot LM
                                    "Narration14" : "ch1-E-Line3_02",//"Trace the yellow do to the purple dot" LM
                                    
                                    //sounds for Letter B
                                    "Narration18" : "ch2-B-Line0",//"Trace the B, this move is hard for me" LM
                                    "Narration19" : "ch1-E-Line1",//Trace the green dot to the red dot" LM
                                    "Narration20" : "ch1-E-Line2_02",//"Trace the blue dot to the orange dot" LM
                                    "Narration22" : "ch1-E-Line3_02",//Trace the yellow dot to the purple dot" LM
                                    
                                    //sounds for Letter C
                                    "Narration24" : "ch2-C-Line0",//"Trace the c so I don't scrape my knee" LM
                                    "Narration25" : "ch1-E-Line1",//"Trace the green dot to the red dot" LM
                                     
                                    //sounds for Letter D
                                    "Narration32" : "ch2-D-Line0",//"This move is the key" LM
                                    "Narration33" : "ch1-E-Line1",//"trace the green dot to the red dot" LM
                                    "Narration34" : "ch1-E-Line2_02",//"trace the blue dot to the orange dot" LM
                                    
                                    //sounds for Letter U
                                    "Narration44" : "ch2-U-Line0",//"Trace the u to help my dreams come true" LM
                                    "Narration45" : "ch1-E-Line1",//"Trace the green dot to the red dot" LM
            
                                    //letter finish sounds
                                    "ThankYou" : "ch2-ThankYou",
                                    "letter2Finish" : "ch2-WowAmazing",
                                    "letter3Finish" : "ch2-YouDidGreat",
                                    "letter4Finish" : "ch2-YouDidIt",
                                    "letter5Finish" : "ch2-Incredible",
                                    "chapterFinish" : "ch2-U-Line2",
                                    
                                    //extra chapter FX sounds
                                    "BackgroundSound" : "CitySounds",
                                    "WalkSound" : "Gravel and Grass Walk",
                                    "CoinDing1" : "bell-ding_01",
                                    "CoinDing2" : "bell-ding_02",
                                    "CoinDing3" : "bell-ding_03",
                                    "CoinDing4" : "bell-ding_04",
                                    "Break3" : "RockBreak3",
                                    "Stop" : "stop",
                                    "LetterComplete" : "yeahOutside"]
        return chapter2SoundArray
    }
    
    //chapter 3 stuff here
    func loadChapter3NodeFiles () -> [SCNNode]{
        //var array of chapter 3 assest
        var chapter3NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter3Files/Environment/Chapter3Scene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(1, 1, 1)
        storyNode.position = SCNVector3(0, 0, 0)
        
        //Load Idle Animation Node
        let idleGaryScene = SCNScene(named: "art.scnassets/3DModels/Chapter3Files/Characters/Gary/Gary@IdleFixed.dae")!
        for child in idleGaryScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.3, 0.3, 0.3)
        idleNode.position = SCNVector3(0, 0.6, -0.35)
        idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0.542), GLKMathDegreesToRadians(-78), GLKMathDegreesToRadians(6.456))
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        
        
        //Load Idle Animation Node
        let idleOllieScene = SCNScene(named: "art.scnassets/3DModels/Chapter3Files/Characters/Ollie/Ollie@Idle1Fixed.dae")!
        for child in idleOllieScene.rootNode.childNodes {
            SideCharacter1idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter1idleNode)
        SideCharacter1idleNode.scale = SCNVector3(1, 1, 1)
        SideCharacter1idleNode.position = SCNVector3(0, 1.427, 0.068)
        //SideCharacter1idleNode.eulerAngles = SCNVector3(0, 180, 0)
        SideCharacter1idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(180), 0)
        
        //Load Idle Animation Node
        let idleQuinnScene = SCNScene(named: "art.scnassets/3DModels/Chapter3Files/Characters/Quinn/Quill@FigureEightFixed.dae")!
        for child in idleQuinnScene.rootNode.childNodes {
            SideCharacter2idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter2idleNode)
        SideCharacter2idleNode.scale = SCNVector3(0.3, 0.3, 0.3)
        SideCharacter2idleNode.position = SCNVector3(-0.226, 0.05, 0.237)
        SideCharacter2idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleSimonScene = SCNScene(named: "art.scnassets/3DModels/Chapter3Files/Characters/Simon/Simon@IdleFixed.dae")!
        for child in idleSimonScene.rootNode.childNodes {
            SideCharacter3idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter3idleNode)
        SideCharacter3idleNode.scale = SCNVector3(0.1, 0.1, 0.1)
        SideCharacter3idleNode.position = SCNVector3(0.41, 0.23, 0.6)
//      SideCharacter3idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-45), GLKMathDegreesToRadians(0))
        SideCharacter3idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-90), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleJillianScene = SCNScene(named: "art.scnassets/3DModels/Chapter3Files/Characters/Jillian/Jillian@SleepingFixed.dae")!
        for child in idleJillianScene.rootNode.childNodes {
            SideCharacter4idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter4idleNode)
        SideCharacter4idleNode.scale = SCNVector3(0.1, 0.1, 0.1)
        SideCharacter4idleNode.position = SCNVector3(-0.369, 0.198, -0.445)
        SideCharacter4idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleInnerTubeScene = SCNScene(named: "art.scnassets/3DModels/Chapter3Files/Characters/InnerTube/InnerTube@FloatingFixed.dae")!
        for child in idleInnerTubeScene.rootNode.childNodes {
            SideCharacter5idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter5idleNode)
        SideCharacter5idleNode.scale = SCNVector3(0.01, 0.01, 0.01)
        SideCharacter5idleNode.position = SCNVector3(0, 1.429, -0.081)
        SideCharacter5idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(5), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        //load all the DAE animations for this Chapter
        //load animations for mainCharacter
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Gary/Gary@IdleFixed", animationIdentifier: "Gary@IdleFixed-1")
        prepareAnimation(withKey: "MainCharacterSwimming", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Gary/Gary@SwimmingFixed", animationIdentifier: "Gary@SwimmingFixed-1")
        prepareAnimation(withKey: "MainCharacterShocked", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Gary/Gary@ShockedFixed", animationIdentifier: "Gary@ShockedFixed-1")
        
        //load animation for side character 1
        prepareAnimation(withKey: "SideCharacter1Idle1", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Ollie/Ollie@Idle1Fixed", animationIdentifier: "Ollie@Idle1Fixed-1")
        prepareAnimation(withKey: "SideCharacter1Idle2", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Ollie/Ollie@Idle2Fixed", animationIdentifier: "Ollie@Idle2Fixed-1")
        prepareAnimation(withKey: "SideCharacter1Idle3", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Ollie/Ollie@Idle3Fixed", animationIdentifier: "Ollie@Idle3Fixed-1")
        prepareAnimation(withKey: "SideCharacter1Idle4", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Ollie/Ollie@Idle4Fixed", animationIdentifier: "Ollie@Idle4Fixed-1")
        prepareAnimation(withKey: "SideCharacter1Idle5", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Ollie/Ollie@Idle5Fixed", animationIdentifier: "Ollie@Idle5Fixed-1")
        prepareAnimation(withKey: "SideCharacter1Twirl", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Ollie/Ollie@TwirlFixed", animationIdentifier: "Ollie@TwirlFixed-1")
        
        
        //load animation for side character 2
        prepareAnimation(withKey: "SideCharacter2Idle", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Quinn/Quill@IdleFixed", animationIdentifier: "Quill@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter2Swimming", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Quinn/Quill@FigureEightFixed", animationIdentifier: "Quill@FigureEightFixed-1")

        
        //load animation for side character 3
        prepareAnimation(withKey: "SideCharacter3Idle", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Simon/Simon@IdleFixed", animationIdentifier: "Simon@IdleFixed-1")

        
        //load animation for side character 4
        prepareAnimation(withKey: "SideCharacter4Idle", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Jillian/Jillian@IdleFixed", animationIdentifier: "Jillian@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter4Sleeping", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Jillian/Jillian@SleepingFixed", animationIdentifier: "Jillian@SleepingFixed-1")
        prepareAnimation(withKey: "SideCharacter4Swimming", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/Jillian/Jillian@SwimmingFixed", animationIdentifier: "Jillian@SwimmingFixed-1")

        
        //load animation for side character 5
        prepareAnimation(withKey: "SideCharacter5Idle", sceneName: "art.scnassets/3DModels/Chapter3Files/Characters/InnerTube/InnerTube@FloatingFixed", animationIdentifier: "InnerTube@FloatingFixed-1")
        
        chapter3NodeArray.append(storyNode)
        
         return chapter3NodeArray
    }
    
    func loadChapter3SoundFiles() -> [String: String] {
        let chapter3SoundArray = [ //sounds for Letter G
                                "Narration1" : "ch3-Start",
                                "Narration2" : "ch3-G-Transition1",
                                "Narration2_1" : "ch3-G-intro1",
                                "Narration3" : "ch1-I-Line1",     //1 narration3
                                "Narration4" : "ch1-I-Line2_01",  //2 narration4 Great Job
                                //"Narration5" : "ch1-I-Line2_02", //purple to yellow X.X
                                //"Narration5" : "ch1-E-Line3_02", //"Next" yellow to purple
                                "Narration5" : "ch1-E-Line2_02", //"Finally" blue to orange
                                "Narration6" : "ch1-I-Line3_01", //Fantastic
            
                                //sounds for Letter Q
                                "Narration10" : "ch3-Q-Transition1",
                                "Narration11" : "ch3-Q-Transition2",
                                "Narration12" : "ch3-Q-Intro1",
                                "Narration13" : "ch1-I-Line1",     //1 narration3
                                "Narration14" : "ch1-I-Line2_01",  //2 narration4 Great Job
                                "Narration15" : "ch1-I-Line2_02",
                                "Narration16" : "ch1-I-Line3_01",//3 narration5 Fantastic
            
                                //sounds for Letter S
                                "Narration18" : "ch3-S-Transition1",
                                "Narration19" : "ch3-S-Transition2",
                                "Narration20" : "ch3-S-Intro1",
                                "Narration21" : "ch1-I-Line1",     //1 narration3
                                "Narration22" : "ch1-I-Line2_01",  //2 narration4 Great Job
            
                                //sounds for Letter J
                                "Narration23" : "ch3-J-Transition1",
                                "Narration24" : "ch3-J-Transition2",
                                "Narration25" : "ch3-J-Transition3",
                                "Narration26" : "ch3-J-Intro1",
                                "Narration27" : "ch1-F-Line1",    //1 narration25
                                "Narration28" : "ch1-F-Line2_01", //2 narration26 Great Job
                                "Narration29" : "ch1-F-Line2_02", //3 narration28
                                "Narration30" : "ch1-F-Line3_01", //3 narration28 Fnatastic
            
                                //sounds for Letter O
                                "Narration31" : "ch3-O-Transition1",
                                "Narration32" : "ch3-O-Intro1",
                                "Narration33" : "ch1-E-Line1",    //1 narration33
                                "Narration34" : "ch1-E-Line2_01", //2 narration34 Great Job
            
                                //letter finish sounds
                                "chapterFinish1" : "ch3-Finish1",
                                "chapterFinish2" : "ch3-Finish2",
                                
                                //extra chapter FX sounds
                                "BackgroundSound" : "Underwater",
                                "Electrocuted" : "Electrocuted",
                                "CoinDing1" : "bell-ding_01",
                                "CoinDing2" : "bell-ding_02",
                                "CoinDing3" : "bell-ding_03",
                                "CoinDing4" : "bell-ding_04",
                                "Break3" : "RockBreak3",
                                "Stop" : "stop",
                                "LetterComplete" : "yeahOutside"]
        return chapter3SoundArray
    }
    
    //chapter 4 stuff here
    func loadChapter4NodeFiles () -> [SCNNode]{
        //var array of chapter 4 assest
        var chapter4NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter4Files/Environment/Chapter4Scene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(0.03, 0.03, 0.03)
        storyNode.position = SCNVector3(0, 0, 0)
        
        //Load Idle Animation Node
        let idleKeelieScene = SCNScene(named: "art.scnassets/3DModels/Chapter4Files/Characters/Keelie/Keelie@WavingFixed.dae")!
        for child in idleKeelieScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.014, 0.014, 0.014)
        idleNode.position = SCNVector3(-5.75, 0, -26)
        idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        
        
        //Load Idle Animation Node
        let idleVelmaScene = SCNScene(named: "art.scnassets/3DModels/Chapter4Files/Characters/Velma/Velma@KnotTailFixed.dae")!
        for child in idleVelmaScene.rootNode.childNodes {
            SideCharacter1idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter1idleNode)
        SideCharacter1idleNode.scale = SCNVector3(0.01, 0.01, 0.01)
        SideCharacter1idleNode.position = SCNVector3(42, 2.6, -33)
        //SideCharacter1idleNode.eulerAngles = SCNVector3(0, 180, 0)
        SideCharacter1idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(-45), 0)
        
        //Load Idle Animation Node
        let idleWallaceScene = SCNScene(named: "art.scnassets/3DModels/Chapter4Files/Characters/Wallace/Wallace@HurtTailFixed.dae")!
        for child in idleWallaceScene.rootNode.childNodes {
            SideCharacter2idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter2idleNode)
        SideCharacter2idleNode.scale = SCNVector3(1, 1, 1)
        SideCharacter2idleNode.position = SCNVector3(-57.789, 0, 1.912)
        SideCharacter2idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(142), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleWinonaScene = SCNScene(named: "art.scnassets/3DModels/Chapter4Files/Characters/Winona/Winona@ComfortingFixed.dae")!
        for child in idleWinonaScene.rootNode.childNodes {
            SideCharacter3idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter3idleNode)
        SideCharacter3idleNode.scale = SCNVector3(1, 1, 1)
        SideCharacter3idleNode.position = SCNVector3(-57.1, 0, 0)
        SideCharacter3idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(90), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleMannyScene = SCNScene(named: "art.scnassets/3DModels/Chapter4Files/Characters/Manny/Manny@StomachAcheFixed.dae")!
        for child in idleMannyScene.rootNode.childNodes {
            SideCharacter4idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter4idleNode)
        SideCharacter4idleNode.scale = SCNVector3(0.1, 0.1, 0.1)
        SideCharacter4idleNode.position = SCNVector3(27, 0, 5)
        SideCharacter4idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-90), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleAshtonScene = SCNScene(named: "art.scnassets/3DModels/Chapter4Files/Characters/Ashton/Ashton@HurtFootFixed.dae")!
        for child in idleAshtonScene.rootNode.childNodes {
            SideCharacter5idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter5idleNode)
        SideCharacter5idleNode.scale = SCNVector3(0.02, 0.02, 0.02)
        SideCharacter5idleNode.position = SCNVector3(33, 8.7, 64)
        SideCharacter5idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-90), GLKMathDegreesToRadians(0))
        SideCharacter5idleNode.geometry?.firstMaterial?.lightingModel = .physicallyBased
        
        //load all the DAE animations for this Chapter
        //load animations for mainCharacter
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Keelie/Keelie@TalkingFixed", animationIdentifier: "Keelie@TalkingFixed-1")
        //prepareAnimation(withKey: "MainCharacterClaping", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Keelie/Keelie@ClapingFixed", animationIdentifier: "Keelie@ClapingFixed-1")
        prepareAnimation(withKey: "MainCharacterJogging", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Keelie/Keelie@JoggingFixed", animationIdentifier: "Keelie@JoggingFixed-1")
        //prepareAnimation(withKey: "MainCharacterWalking", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Keelie/Keelie@WalkingFixed", animationIdentifier: "Keelie@WalkingFixed-1")
        prepareAnimation(withKey: "MainCharacterWaving", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Keelie/Keelie@WavingFixed", animationIdentifier: "Keeling@WavingFixed-1")
        
        //load animation for side character 1
        prepareAnimation(withKey: "SideCharacter1Problem", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Velma/Velma@KnotTailFixed", animationIdentifier: "Velma@KnotTailFixed-1")
        prepareAnimation(withKey: "SideCharacter1Happy", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Velma/Velma@HappyFixed", animationIdentifier: "Velma@HappyFixed-1")
        
        //load animation for side character 2
        prepareAnimation(withKey: "SideCharacter2Problem", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Wallace/Wallace@HurtTailFixed", animationIdentifier: "Wallace@HurtTailFixed-1")
        prepareAnimation(withKey: "SideCharacter2Happy", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Wallace/Wallace@HappyFixed", animationIdentifier: "Wallace@HappyFixed-1")
        
        
        //load animation for side character 3
        prepareAnimation(withKey: "SideCharacter3Idle", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Winona/Winona@IdleFixed", animationIdentifier: "Winona@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter3Clapping", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Winona/Winona@ClappingFixed", animationIdentifier: "Winona@ClappingFixed-1")
        prepareAnimation(withKey: "SideCharacter3Comforting", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Winona/Winona@ComfortingFixed", animationIdentifier: "Winona@ComfortingFixed-1")
        
        //load animation for side character 4
        prepareAnimation(withKey: "SideCharacter4Problem", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Manny/Manny@StomachAcheFixed", animationIdentifier: "Manny@StomachAcheFixed-1")
        prepareAnimation(withKey: "SideCharacter4Happy", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Manny/Manny@EatingBananaFixed", animationIdentifier: "Manny@EatingBananaFixed-1")
        
        //load animation for side character 5
        prepareAnimation(withKey: "SideCharacter5Problem", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Ashton/Ashton@HurtFootFixed", animationIdentifier: "Ashton@HurtFootFixed-1")
        prepareAnimation(withKey: "SideCharacter5Happy", sceneName: "art.scnassets/3DModels/Chapter4Files/Characters/Ashton/Ashton@CastFixed", animationIdentifier: "Ashton@CastFixed-1")
        
        chapter4NodeArray.append(storyNode)
        
        return chapter4NodeArray
    }
    
    func loadChapter4SoundFiles() -> [String: String] {
        let chapter4SoundArray = [//sounds for Letter K
                                    "Narration1" : "ch4-K-intro",
                                    "Narration2" : "ch1-E-Line1",    //1 narration33 Green to Red
                                    "Narration3" : "ch1-E-Line2_01", //2 narration34 Great Job
                                    "Narration4" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration5" : "ch1-E-Line3_01", //3 narration36 Amazing
                                    "Narration6" : "ch1-E-Line3_02", //Yellow to Purple
                                    "Narration7" : "ch1-E-Line4_01", //4 narration38 Perfect
                                    //TODO: ADD PINK TO WHITE DOT NARRATION
                                    "Narration8" : "ch1-E-Line2_02", //blue to orange Again (no Pink to White dot)
                                    "Narration9" : "ch1-E-Line5_01", //5 narration40 Awesome Job
            
                                    //sounds for Letter V
                                    "Narration11" : "ch4-V-Transition1",
                                    "Narration12" : "ch4-V-Intro",
                                    "Narration13" : "ch1-E-Line1",    //1 narration33 Green to Red
                                    "Narration14" : "ch1-E-Line2_01", //2 narration34 Great Job
                                    "Narration15" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration16" : "ch1-E-Line3_01", //3 narration36 Amazing
            
                                    //sounds for Letter W
                                    "Narration18" : "ch4-W-Transition1",
                                    "Narration19" : "ch4-W-Transition2",
                                    "Narration20" : "ch1-E-Line1",    //1 narration33 Green to Red
                                    "Narration21" : "ch1-E-Line2_01", //2 narration34 Great Job
                                    "Narration22" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration23" : "ch1-E-Line3_01", //3 narration36 Amazing
                                    "Narration24" : "ch1-E-Line3_02", //Yellow to Purple
                                    "Narration25" : "ch1-E-Line4_01", //4 narration38 Perfect
                                    //TODO: ADD PINK TO WHITE DOT NARRATION
                                    "Narration26" : "ch1-E-Line2_02", //blue to orange Again (no Pink to White dot)
                                    "Narration27" : "ch1-E-Line5_01", //5 narration40 Awesome Job
            
                                    //sounds for Letter M
                                    "Narration28" : "ch4-M-Transition1",
                                    "Narration29" : "ch4-M-Transition2",
                                    "Narration30" : "ch4-M-Intro",
                                    "Narration31" : "ch1-E-Line1",    //1 narration33 Green to Red
                                    "Narration32" : "ch1-E-Line2_01", //2 narration34 Great Job
                                    "Narration33" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration34" : "ch1-E-Line3_01", //3 narration36 Amazing
                                    "Narration35" : "ch1-E-Line3_02", //Yellow to Purple
                                    "Narration36" : "ch1-E-Line4_01", //4 narration38 Perfect
                                    //TODO: ADD PINK TO WHITE DOT NARRATION
                                    "Narration37" : "ch1-E-Line2_02", //blue to orange Again (no Pink to White dot)
                                    "Narration38" : "ch1-E-Line5_01", //5 narration40 Awesome Job
            
                                    //sounds for Letter A
                                    "Narration39" : "ch4-A-Transition1",
                                    "Narration40" : "ch4-A-Transition2",
                                    "Narration41" : "ch4-A-Intro",
                                    "Narration42" : "ch1-E-Line1",    //1 narration33 Green to Red
                                    "Narration43" : "ch1-E-Line2_01", //2 narration34 Great Job
                                    "Narration44" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration45" : "ch1-E-Line3_01", //3 narration36 Amazing
                                    "Narration46" : "ch1-E-Line3_02", //Yellow to Purple
                                    "Narration47" : "ch1-E-Line4_01", //4 narration38 Perfect
            
                                    //Finishing Narration
                                    "Finish1" : "ch4-Final1",
                                    "Finish2" : "ch4-Final2",
            
                                    //extra chapter FX sounds
                                    "BackgroundSound" : "Birds2",
                                    "WalkSound" : "Gravel and Grass Walk",
                                    "CoinDing1" : "bell-ding_01",
                                    "CoinDing2" : "bell-ding_02",
                                    "CoinDing3" : "bell-ding_03",
                                    "CoinDing4" : "bell-ding_04",
                                    "Break3" : "RockBreak3",
                                    "Stop" : "stop",
                                    "LetterComplete" : "yeahOutside"]
        return chapter4SoundArray
    }
    
    //chapter 5 stuff here
    func loadChapter5NodeFiles () -> [SCNNode]{
        //var array of chapter 5 assest
        var chapter5NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter5Files/Environments/Chapter5Scene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(0.03, 0.03, 0.03)
        storyNode.position = SCNVector3(0, 0, 0)
        
        //Load Idle Animation Node
        let idleXylophoneScene = SCNScene(named: "art.scnassets/3DModels/Chapter5Files/Characters/Xylophone/Xylophones.scn")!
        for child in idleXylophoneScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.003, 0.003, 0.003)
        idleNode.position = SCNVector3(0.706, 0.291, 7.392)
        idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(-90), GLKMathDegreesToRadians(137), GLKMathDegreesToRadians(0))
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
         
        //Load Idle Animation Node
        let idleNailsScene = SCNScene(named: "art.scnassets/3DModels/Chapter5Files/Characters/Nails/NailsGroup.scn")!
        for child in idleNailsScene.rootNode.childNodes {
            SideCharacter1idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter1idleNode)
        SideCharacter1idleNode.scale = SCNVector3(0.03, 0.03, 0.03)
        SideCharacter1idleNode.position = SCNVector3(-6.693, 2.229, -9.144)
        SideCharacter1idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(-90), 0)
        
        //Load Idle Animation Node
        let idleZebraScene = SCNScene(named: "art.scnassets/3DModels/Chapter5Files/Characters/Zebraclock/Zebraclock.scn")!
        for child in idleZebraScene.rootNode.childNodes {
            SideCharacter2idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter2idleNode)
        SideCharacter2idleNode.scale = SCNVector3(0.3, 0.3, 0.3)
        SideCharacter2idleNode.position = SCNVector3(11.717, 6.345, -0.683)
        SideCharacter2idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-90), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleYarnScene = SCNScene(named: "art.scnassets/3DModels/Chapter5Files/Characters/Mallet/Yarn.scn")!
        for child in idleYarnScene.rootNode.childNodes {
            SideCharacter3idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter3idleNode)
        SideCharacter3idleNode.scale = SCNVector3(0.3, 0.3, 0.3)
        SideCharacter3idleNode.position = SCNVector3(7.439, 1.114, 8.976)
        SideCharacter3idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        chapter5NodeArray.append(storyNode)
        
        return chapter5NodeArray
    }
    
    func loadChapter5SoundFiles() -> [String: String] {
        let chapter5SoundArray = [  //sounds for Letter N
                                    "Narration1" : "ch5-intro1",
                                    "Narration2" : "ch5-intro2",
                                    "Narration3" : "ch5-N-Transition1",
                                    "Narration4" : "ch5-N-intro",
                                    "Narration5" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration6" : "ch1-E-Line2_01", //2 Great Job
                                    "Narration7" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration8" : "ch1-E-Line3_01", //3 Amazing
                                    "Narration9" : "ch1-E-Line3_02", //Yellow to Purple
                                    "Narration10" : "ch1-E-Line4_01", //4 Perfect
            
                                    //sounds for Letter Z
                                    "Narration11" : "ch5-Z-Transition1",
                                    "Narration12" : "ch5-Z-intro",
                                    "Narration13" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration14" : "ch1-E-Line2_01", //2 Great Job
                                    "Narration15" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration16" : "ch1-E-Line3_01", //3 Amazing
                                    "Narration17" : "ch1-E-Line3_02", //Yellow to Purple
                                    "Narration18" : "ch1-E-Line4_01", //4 Perfect
            
                                    //sounds for Letter Y
                                    "Narration19" : "ch5-Y-Transition1",
                                    "Narration20" : "ch5-Y-intro",
                                    "Narration21" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration22" : "ch1-E-Line2_01", //2 Great Job
                                    "Narration23" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration24" : "ch1-E-Line3_01", //3 Amazing
                                    "Narration25" : "ch1-E-Line3_02", //Yellow to Purple
                                    "Narration26" : "ch1-E-Line4_01", //4 Perfect
            
                                    //sounds for Letter X
                                    "Narration29" : "ch5-X-Transition1",
                                    "Narration30" : "ch5-X-Transition2",
                                    "Narration31" : "ch5-X-Intro",
                                    "Narration32" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration33" : "ch1-E-Line2_01", //2 Great Job
                                    "Narration34" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration35" : "ch1-E-Line3_01", //3 Amazing
            
                                    //Finishing Narration
                                    "Finish1" : "ch5-final1",
                                    "Finish2" : "ch5-final2",
                                    
                                    //extra chapter FX sounds
                                    "BackgroundSound" : "Birds2",
                                    "WalkSound" : "Gravel and Grass Walk",
                                    "CoinDing1" : "bell-ding_01",
                                    "CoinDing2" : "bell-ding_02",
                                    "CoinDing3" : "bell-ding_03",
                                    "CoinDing4" : "bell-ding_04",
                                    "Xylophone1" : "xylophone1",
                                    "Xylophone2" : "xylophone2",
                                    "Xylophone3" : "xylophone3",
                                    "Xylophone4" : "xylophone4",
                                    "Xylophone5" : "xylophone5",
                                    "Break3" : "RockBreak3",
                                    "Stop" : "stop",
                                    "LetterComplete" : "yeahOutside"]
        return chapter5SoundArray
    }
    
    //chapter 6 stuff here
    func loadChapter6NodeFiles () -> [SCNNode]{
        //var array of chapter 6 assest
        var chapter6NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter6Files/Environments/Chapter6Scene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(0.0001, 0.0001, 0.0001)
        storyNode.position = SCNVector3(0, 0, 0)
        
        //Load Idle Animation Node
        let idleBarryScene = SCNScene(named: "art.scnassets/3DModels/Chapter6Files/Characters/Barry/Barry@FullLapFixed.dae")!
        for child in idleBarryScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(1, 1, 1)
        idleNode.position = SCNVector3(-2428.747, 0, 1656.2)
        idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(90), GLKMathDegreesToRadians(0))
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter6Files/Characters/Barry/Barry@FullLapFixed", animationIdentifier: "Barry@FullLapFixed-1")
        
        chapter6NodeArray.append(storyNode)
        
        return chapter6NodeArray
    }
    
    func loadChapter6SoundFiles() -> [String: String] {
        let chapter6SoundArray = [//sounds for Letter c
                                "Narration1" : "ch1L-Intro1", //12.19
                                "Narration2" : "ch1L-Intro2", //6.65
                                "Narration3" : "ch1L-C-Intro", //6.74
                                "Narration4" : "ch1-E-Line1",    //Green to Red
                                "Narration5" : "ch1-E-Line2_01", //Great Job
        
                                //sounds for Letter a
                                "Narration6" : "ch1L-A-Transition1", //4.58
                                "Narration7" : "ch1L-A-Intro", //7.08
                                "Narration8" : "ch1-E-Line1",    //Green to Red
                                "Narration9" : "ch1-E-Line2_01", //Great Job
                                "Narration10" : "ch1-E-Line2_02", //Blue to Orange
                                "Narration11" : "ch1-E-Line3_01", //Amazing
        
                                //sounds for Letter d
                                "Narration12" : "ch1L-D-Transition1", //5.11
                                "Narration13" : "ch1L-D-Intro", //7.22
                                "Narration14" : "ch1-E-Line1",    //Green to Red
                                "Narration15" : "ch1-E-Line2_01", //Great Job
                                "Narration16" : "ch1-E-Line2_02", //Blue to Orange
                                "Narration17" : "ch1-E-Line3_01", //Amazing
        
                                //sounds for Letter g
                                "Narration18" : "ch1L-G-Transition1", //5.35
                                "Narration19" : "ch1L-G-Intro", //7.78
                                "Narration20" : "ch1-E-Line1",    //Green to Red
                                "Narration21" : "ch1-E-Line2_01", //Great Job
                                "Narration22" : "ch1-E-Line2_02", //Blue to Orange
                                "Narration23" : "ch1-E-Line3_01", //Amazing
                                
                                //sounds for Letter o
                                "Narration24" : "ch1L-O-Transition1", //6.74
                                "Narration25" : "ch1L-O-Intro", //9.1
                                "Narration26" : "ch1-E-Line1",    //Green to Red
                                "Narration27" : "ch1-E-Line2_01", //Great Job
        
                                //Finishing Narration
                                "Finish" : "ch1L-Final", //5.04
                                
                                //extra chapter FX sounds
                                "BackgroundSound" : "Birds2",
                                "WalkSound" : "Gravel and Grass Walk",
                                "CoinDing1" : "bell-ding_01",
                                "CoinDing2" : "bell-ding_02",
                                "CoinDing3" : "bell-ding_03",
                                "CoinDing4" : "bell-ding_04",
                                "Break3" : "RockBreak3",
                                "Stop" : "stop",
                                "LetterComplete" : "yeahOutside"]
        return chapter6SoundArray
    }
    
    //chapter 7 stuff here
    func loadChapter7NodeFiles () -> [SCNNode]{
        //var array of chapter 7 assest
        var chapter7NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter7Files/Environments/Chapter7Scene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(0.03, 0.03, 0.03)
        storyNode.position = SCNVector3(0, 0, 0)
        
        //Load Scene Mask so we only see immidate area
//        let maskingScene = SCNScene(named: "art.scnassets/MaskScene.scn")!
//        for child in maskingScene.rootNode.childNodes {
//            maskingNode.addChildNode(child)
//        }
//        maskingNode.renderingOrder = -2
//        storyNode.addChildNode(maskingNode)
//        maskingNode.position = SCNVector3(0, 0, 0)
        //maskingNode.scale = SCNVector3(1, 1, 1)
        
        //Load Idle Animation Node
        let idleUrsaScene = SCNScene(named: "art.scnassets/3DModels/Chapter7Files/Characters/Ursa/Ursa@IdleFixed.dae")!
        for child in idleUrsaScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(1.2, 1.2, 1.2)
        //idleNode.position = SCNVector3(-186, 0, 93)
        idleNode.position = SCNVector3(0, 0, 0)
        idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(150), GLKMathDegreesToRadians(0))
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        
        
        //Load Idle Animation Node
        let idleStanleyScene = SCNScene(named: "art.scnassets/3DModels/Chapter7Files/Characters/Stanley/Stanley@EatingFixed.dae")!
        for child in idleStanleyScene.rootNode.childNodes {
            SideCharacter1idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter1idleNode)
        SideCharacter1idleNode.scale = SCNVector3(2.4, 2.4, 2.4)
        SideCharacter1idleNode.position = SCNVector3(-145, 0, 32)
        //SideCharacter1idleNode.eulerAngles = SCNVector3(0, 180, 0)
        SideCharacter1idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(0), 0)
        
        //Load Idle Animation Node
        let idleVivianScene = SCNScene(named: "art.scnassets/3DModels/Chapter7Files/Characters/Vivian/Vivian@PickingFlowersFixed.dae")!
        for child in idleVivianScene.rootNode.childNodes {
            SideCharacter2idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter2idleNode)
        SideCharacter2idleNode.scale = SCNVector3(5, 5, 5)
        SideCharacter2idleNode.position = SCNVector3(-70, 0, 50)
        SideCharacter2idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(215), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleWindsorScene = SCNScene(named: "art.scnassets/3DModels/Chapter7Files/Characters/Windsor/Windsor@IdleFixed.dae")!
        for child in idleWindsorScene.rootNode.childNodes {
            SideCharacter3idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter3idleNode)
        SideCharacter3idleNode.scale = SCNVector3(3, 3, 3)
        SideCharacter3idleNode.position = SCNVector3(32, 0, -50)
        SideCharacter3idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-55), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleIsaacScene = SCNScene(named: "art.scnassets/3DModels/Chapter7Files/Characters/Isaac/Isaac@EatingFixed.dae")!
        for child in idleIsaacScene.rootNode.childNodes {
            SideCharacter4idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter4idleNode)
        SideCharacter4idleNode.scale = SCNVector3(0.04, 0.04, 0.04)
        SideCharacter4idleNode.position = SCNVector3(111, 0, 3)
        SideCharacter4idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(20), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        //let idleTylerScene = SCNScene(named: "art.scnassets/3DModels/Chapter7Files/Characters/Tyler/Tyler@IdleFixed.dae")!
        let idleTylerScene = SCNScene(named: "art.scnassets/3DModels/Chapter7Files/Characters/Tyler/Tyler@FishingFixed.dae")!
        for child in idleTylerScene.rootNode.childNodes {
            SideCharacter5idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter5idleNode)
        SideCharacter5idleNode.scale = SCNVector3(2.5, 2.5, 2.5)
        SideCharacter5idleNode.position = SCNVector3(148, 0, -13.5)
        SideCharacter5idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(66.5), GLKMathDegreesToRadians(0))
        
        //load all the DAE animations for this Chapter
        //load animations for mainCharacter
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Ursa/Ursa@IdleFixed", animationIdentifier: "Ursa@IdleFixed-1")
        prepareAnimation(withKey: "MainCharacterWalking", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Ursa/Ursa@WalkingFixed", animationIdentifier: "Ursa@WalkingFixed-1")
        prepareAnimation(withKey: "MainCharacterShouting", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Ursa/Ursa@ShoutFixed", animationIdentifier: "Ursa@ShoutFixed-1")
        
        
        //load animation for side character 1
        prepareAnimation(withKey: "SideCharacter1Idle", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Stanley/Stanley@EatingFixed", animationIdentifier: "Stanley@EatingFixed-1")
        prepareAnimation(withKey: "SideCharacter1Talking", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Stanley/Stanley@TalkingFixed", animationIdentifier: "Stanley@TalkingFixed-1")
        
        //load animation for side character 2
        prepareAnimation(withKey: "SideCharacter2Idle", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Vivian/Vivian@PickingFlowersFixed", animationIdentifier: "Vivian@PickingFlowersFixed-1")
        prepareAnimation(withKey: "SideCharacter2Talking", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Vivian/Vivian@TalkingFixed", animationIdentifier: "Vivian@TalkingFixed-1")
        
        
        //load animation for side character 3
        prepareAnimation(withKey: "SideCharacter3Idle", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Windsor/Windsor@IdleFixed", animationIdentifier: "Windsor@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter3Talking", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Windsor/Windsor@TalkingFixed", animationIdentifier: "Windsor@TalkingFixed-1")

        
        //load animation for side character 4
        prepareAnimation(withKey: "SideCharacter4Idle", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Isaac/Isaac@EatingFixed", animationIdentifier: "Isaac@EatingFixed-1")
        prepareAnimation(withKey: "SideCharacter4Talking", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Isaac/Isaac@TalkingFixed", animationIdentifier: "keyframedAnimations1")
        
        
        //load animation for side character 5
        prepareAnimation(withKey: "SideCharacter5Idle", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Tyler/Tyler@FishingFixed", animationIdentifier: "Tyler@FishingFixed-1")
        prepareAnimation(withKey: "SideCharacter5Standby", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Tyler/Tyler@IdleFixed", animationIdentifier: "Tyler@IdleFixed-1")
        prepareAnimation(withKey: "SideCharacter5Talking", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Tyler/Tyler@TalkingFixed", animationIdentifier: "Tyler@TalkingFixed-1")
        prepareAnimation(withKey: "SideCharacter5Walking", sceneName: "art.scnassets/3DModels/Chapter7Files/Characters/Tyler/Tyler@WalkingFixed", animationIdentifier: "Tyler@WalkingFixed-1")
        
        chapter7NodeArray.append(storyNode)
        return chapter7NodeArray
    }
    
    func loadChapter7SoundFiles() -> [String: String] {
        let chapter7SoundArray = [//sounds for Letter u lowercase
                                    "Narration1" : "ch2L-Intro1",
                                    "Narration2" : "ch2L-Intro2",
                                    "Narration3" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration4" : "ch1-E-Line4_01", //4 Perfect
                                    "Narration5" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration6" : "ch1-E-Line3_01", //3 Amazing
            
                                    //sounds for Letter s lowercase
                                    "Narration7" : "ch2L-S-Transition1",
                                    "Narration8" : "ch2L-S-Intro1",
                                    "Narration9" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration10" : "ch1-E-Line2_01", //2 Great Job
            
                                    //sounds for Letter v lowercase
                                    "Narration11" : "ch2L-V-Transition1",
                                    "Narration12" : "ch2L-V-Transition2",
                                    "Narration13" : "ch2L-V-Intro1",
                                    "Narration14" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration15" : "ch1-E-Line2_01", //2 Great Job
                                    "Narration16" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration17" : "ch1-E-Line3_01", //3 Amazing
            
                                    //sounds for Letter w lowercase
                                    "Narration18" : "ch2L-W-Transition1",
                                    "Narration19" : "ch2L-W-Transition2",
                                    "Narration20" : "ch2L-W-Intro1",
                                    "Narration21" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration22" : "ch1-E-Line2_01", //2 Great Job
                                    "Narration23" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration24" : "ch1-E-Line3_01", //3 Amazing
                                    "Narration25" : "ch1-E-Line3_02", //Yellow to Purple
                                    "Narration26" : "ch1-E-Line4_01", //4 Perfect
                                    //TODO: ADD PINK TO WHITE DOT NARRATION
                                    "Narration27" : "ch1-E-Line2_02", //blue to orange Again (no Pink to White dot)
                                    "Narration28" : "ch1-E-Line5_01", //5 narration40 Awesome Job
            
                                    //sounds for Letter i lowercase
                                    "Narration29" : "ch2L-I-Transition1",
                                    "Narration30" : "ch2L-I-Intro1",
                                    "Narration31" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration32" : "ch1-E-Line2_01", //2 Great Job
                                    "Narration33" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration34" : "ch1-E-Line3_01", //3 Amazing
            
                                    //sounds for Letter t lowercase
                                    "Narration35" : "ch2L-T-Transition1",
                                    "Narration36" : "ch2L-T-Intro1",
                                    "Narration37" : "ch1-E-Line1",    //1 Green to Red
                                    "Narration38" : "ch1-E-Line2_01", //2 Great Job
                                    "Narration39" : "ch1-E-Line2_02", //Blue to Orange
                                    "Narration40" : "ch1-E-Line3_01", //3 Amazing
            
                                    //Finishing Narration
                                    "Finish1" : "ch2L-Final1",
                                    "Finish2" : "ch2L-Final2",
                                    
                                    //extra chapter FX sounds
                                    "BackgroundSound" : "JungleBackgroundMix",
                                    "WalkSound" : "Gravel and Grass Walk",
                                    "CoinDing1" : "bell-ding_01",
                                    "CoinDing2" : "bell-ding_02",
                                    "CoinDing3" : "bell-ding_03",
                                    "CoinDing4" : "bell-ding_04",
                                    "Break3" : "RockBreak3",
                                    "Stop" : "stop",
                                    "LetterComplete" : "yeahOutside"]
        return chapter7SoundArray
    }
    
    //chapter 8 stuff here
    func loadChapter8NodeFiles () -> [SCNNode]{
        //var array of chapter 8 assest
        var chapter8NodeArray: [SCNNode] = []
        
            // Load StoryScene Node
            let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter8Files/Environments/Chapter8Scene.scn")!
            storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
            storyNode.scale = SCNVector3(0.03, 0.03, 0.03)
            storyNode.position = SCNVector3(0, 0, 0)
        
            //Load Idle Animation Node
            let idleLionelScene = SCNScene(named: "art.scnassets/3DModels/Chapter8Files/Characters/Lionel/Lionel@IdleFixede.dae")!
            for child in idleLionelScene.rootNode.childNodes {
                idleNode.addChildNode(child)
            }
            storyNode.addChildNode(idleNode)
            idleNode.scale = SCNVector3(0.75, 0.75, 0.75)
            idleNode.position = SCNVector3(0.25, 9.25, -2)
            idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-36), GLKMathDegreesToRadians(0))
        
            let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        
        
            //Load Idle Animation Node
            let idleYogiScene = SCNScene(named: "art.scnassets/3DModels/Chapter8Files/Characters/Yogi/Yogi@IdleFixed.dae")!
            for child in idleYogiScene.rootNode.childNodes {
                SideCharacter1idleNode.addChildNode(child)
            }
            lvlFloor.addChildNode(SideCharacter1idleNode)
            SideCharacter1idleNode.scale = SCNVector3(0.75, 0.75, 0.75)
            SideCharacter1idleNode.position = SCNVector3(1, 9.25, 2)
            SideCharacter1idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(-45), 0)
        
            //Load Idle Animation Node
            let idleKimScene = SCNScene(named: "art.scnassets/3DModels/Chapter8Files/Characters/Kim/Kim@IdleFixed.dae")!
            for child in idleKimScene.rootNode.childNodes {
                SideCharacter2idleNode.addChildNode(child)
            }
            lvlFloor.addChildNode(SideCharacter2idleNode)
            SideCharacter2idleNode.scale = SCNVector3(0.75, 0.75, 0.75)
            SideCharacter2idleNode.position = SCNVector3(-3, 5, 1.25)
            SideCharacter2idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(35), GLKMathDegreesToRadians(0))
            
            //Load Idle Animation Node
            let idleJasmineScene = SCNScene(named: "art.scnassets/3DModels/Chapter8Files/Characters/Jasmine/Jasmine@Leaning2Fixed.dae")!
            for child in idleJasmineScene.rootNode.childNodes {
                SideCharacter3idleNode.addChildNode(child)
            }
            lvlFloor.addChildNode(SideCharacter3idleNode)
            SideCharacter3idleNode.scale = SCNVector3(0.75, 0.75, 0.75)
            SideCharacter3idleNode.position = SCNVector3(3,5,0)
            SideCharacter3idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(200), GLKMathDegreesToRadians(0))
        
            //Load Idle Animation Node
            let idleErnieScene = SCNScene(named: "art.scnassets/3DModels/Chapter8Files/Characters/Ernie/Ernie@LayingFixed.dae")!
            for child in idleErnieScene.rootNode.childNodes {
                SideCharacter4idleNode.addChildNode(child)
            }
            lvlFloor.addChildNode(SideCharacter4idleNode)
            SideCharacter4idleNode.scale = SCNVector3(0.75, 0.75, 0.75)
            SideCharacter4idleNode.position = SCNVector3(-2.75, 0.75, 2.75)
            SideCharacter4idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(10), GLKMathDegreesToRadians(0))
        
            //load all the DAE animations for this Chapter
            //load animations for mainCharacter
            prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Lionel/Lionel@IdleFixede", animationIdentifier: "Lionel@IdleFixede-1")
            prepareAnimation(withKey: "MainCharacterWalking", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Lionel/Lionel@WalkingFixed", animationIdentifier: "Lionel@WalkingFixed-1")
            prepareAnimation(withKey: "MainCharacterCheering", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Lionel/Lionel@HappyFixed", animationIdentifier: "Lionel@HappyFixed-1")
            prepareAnimation(withKey: "MainCharacterLaying", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Lionel/Lionel@SittingIdleFixed", animationIdentifier: "Lionel@SittingIdleFixed-1")
            prepareAnimation(withKey: "MainCharacterStandup", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Lionel/Lionel@StandingUpFixed", animationIdentifier: "Lionel@StandingUpFixed-1")
            prepareAnimation(withKey: "MainCharacterStairwalk", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Lionel/Lionel@StairwalkFixed", animationIdentifier: "Lionel@StairwalkFixed-1")
        
        
            //load animation for side character 1
            prepareAnimation(withKey: "SideCharacter1Idle", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Yogi/Yogi@IdleFixed", animationIdentifier: "Yogi@IdleFixed-1")
            prepareAnimation(withKey: "SideCharacter1Cheering", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Yogi/Yogi@CheeringFixed", animationIdentifier: "Yogi@CheeringFixed-1")
            prepareAnimation(withKey: "SideCharacter1Sitting", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Yogi/Yogi@SittingFixed", animationIdentifier: "Yogi@SittingFixed-1")
            prepareAnimation(withKey: "SideCharacter1Walking", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Yogi/Yogi@WalkingFixed", animationIdentifier: "Yogi@WalkingFixed-1")
            prepareAnimation(withKey: "SideCharacter1Stairwalk", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Yogi/Yogi@StairwalkFixed", animationIdentifier: "Yogi@StairwalkFixed-1")
        
            //load animation for side character 2
            prepareAnimation(withKey: "SideCharacter2Cheering", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Kim/Kim@HappyFixed", animationIdentifier: "Kim@HappyFixed-1")
            prepareAnimation(withKey: "SideCharacter2Idle", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Kim/Kim@IdleFixed", animationIdentifier: "Kim@IdleFixed-1")
            prepareAnimation(withKey: "SideCharacter2Laying", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Kim/Kim@LayingFixed", animationIdentifier: "Kim@LayingFixed-1")
            prepareAnimation(withKey: "SideCharacter2Stairwalk", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Kim/Kim@StairwalkFixed", animationIdentifier: "Kim@StairwalkFixed-1")
            prepareAnimation(withKey: "SideCharacter2Walking", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Kim/Kim@WalkingFixed", animationIdentifier: "Kim@WalkingFixed-1")
            
            //load animation for siede character 3
            prepareAnimation(withKey: "SideCharacter3Leaning", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Jasmine/Jasmine@Leaning2Fixed", animationIdentifier: "action_container-Armature")
            prepareAnimation(withKey: "SideCharacter3Idle", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Jasmine/Jasmine@IdleFixed", animationIdentifier: "action_container-Armature")
            prepareAnimation(withKey: "SideCharacter3Walking", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Jasmine/Jasmine@WalkingFixed", animationIdentifier: "action_container-Armature")
            prepareAnimation(withKey: "SideCharacter3Cheering", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Jasmine/Jasmine@CheeringFixed", animationIdentifier: "action_container-Armature")
            prepareAnimation(withKey: "SideCharacter3Laying", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Jasmine/Jasmine@LayingDown", animationIdentifier: "action_container-Armature")
                
            //load animation for side character 4
            prepareAnimation(withKey: "SideCharacter4Cheering", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Ernie/Ernie@HappyFixed", animationIdentifier: "Ernie@HappyFixed-1")
            prepareAnimation(withKey: "SideCharacter4Idle", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Ernie/Ernie@IdleFixed", animationIdentifier: "Ernie@IdleFixed-1")
            prepareAnimation(withKey: "SideCharacter4Laying", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Ernie/Ernie@LayingFixed", animationIdentifier: "Ernie@LayingFixed-1")
            prepareAnimation(withKey: "SideCharacter4Stairwalk", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Ernie/Ernie@StairwalkFixed", animationIdentifier: "Ernie@StairwalkFixed-1")
            prepareAnimation(withKey: "SideCharacter4Standup", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Ernie/Ernie@StandupFixed", animationIdentifier: "Ernie@StandupFixed-1")
            prepareAnimation(withKey: "SideCharacter4Walking", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Ernie/Ernie@WalkingFixed", animationIdentifier: "Ernie@WalkingFixed-1")
        prepareAnimation(withKey: "SideCharacter4Sitting", sceneName: "art.scnassets/3DModels/Chapter8Files/Characters/Ernie/Ernie@SittingFixed", animationIdentifier: "Ernie@SittingFixed-1")
        
            chapter8NodeArray.append(storyNode)
        return chapter8NodeArray
    }
    
    func loadChapter8SoundFiles() -> [String: String] {
        let chapter8SoundArray = [
                                  //Intro to chapter
                                  "Narration1" : "ch3L-Intro1", //Lionel lives in the back of the fridge (11)
                                  "Narration2" : "ch3L-L-Transition1.old",
            
                                  //letter l
                                  "Narration3" : "ch3L-L-Intro1", //trace L to help Lionel get up (10)
                                  "Narration4" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration5" : "ch1-E-Line4_01", //4 Perfect
            
                                  //Letter y
                                  "Narration6" : "ch3L-Y-Transition1", //Lionel is on his way (5)
                                  "Narration7" : "ch3L-Y-Intro1", //by the milk, Lionel meets yogi (9)
                                  "Narration8" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration9" : "ch1-E-Line4_01", //4 Perfect
                                  "Narration10" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration11" : "ch1-E-Line3_01", //3 Amazing
                                  
                                  //Letter k
                                  "Narration12" : "ch3L-K-Transition1",
                                  "Narration13" : "ch3L-K-Intro1",
                                  
                                  "Narration14" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration15" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration16" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration17" : "ch1-E-Line3_01", //3 Amazing
                                  "Narration18" : "ch1-E-Line3_02", //Yellow to Purple
                                  "Narration19" : "ch1-E-Line4_01", //4 Perfect
            
                                  //Letter j
                                  "Narration20" : "ch3L-J-Transition1",
                                  "Narration21" : "ch3L-J-Intro1",
                                
                                  "Narration22" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration23" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration24" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration25" : "ch1-E-Line3_01", //3 Amazing
            
                                  //Letter e
                                  "Narration26" : "ch3L-E-Transition1",
                                  "Narration27" : "ch3L-E-Transition2",
                                  "Narration28" : "ch3L-E-Intro1",
                                
                                  "Narration29" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration30" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration31" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration32" : "ch1-E-Line3_01", //3 Amazing
            
                                  //transition to Final
                                  "Narration33" : "ch3L-Final1",
                                  "Narration34" : "ch3L-Final2",
                                  
                                  
                                  //Breakfast Plate interaction
                                  "Narration35" : "ch3L-Final3-TapLemon1", //(4sec)
                                  "Narration36" : "ch3L-Final3-TapLemon2", //Good job (1sec)
                                  "Narration37" : "ch3L-Final3-TapYogurt1", //(4sec)
                                  "Narration38" : "ch3L-Final3-TapYogurt2", //Amazing (1.5sec)
                                  "Narration39" : "ch3L-Final3-TapKiwi1", //(4sec)
                                  "Narration40" : "ch3L-Final3-TapKiwi2", //Good job (1sec)
                                  "Narration41" : "ch3L-Final3-TapJam1",
                                  "Narration42" : "ch3L-Final3-TapJam2",// Fantastic
                                  "Narration43" : "ch3L-Final3-TapEBar1", //(5sec)
                                  "Narration44" : "ch3L-Final3-TapEbar2", //You did it (1sec)
                                  
                                  //Final
                                  "Narration45" : "ch3L-Final4",
                                  
                                  //extra chapter FX sounds
                                  "BackgroundSound" : "RoomToneOffice",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "CoinDing1" : "bell-ding_01",
                                  "CoinDing2" : "bell-ding_02",
                                  "CoinDing3" : "bell-ding_03",
                                  "CoinDing4" : "bell-ding_04",
                                  "Break1" : "RockBreak3",
                                  "Stop" : "stop",
                                  "LetterComplete" : "yeahOutside"]
        return chapter8SoundArray
    }
    
    //chapter 9 stuff here
    func loadChapter9NodeFiles () -> [SCNNode]{
        //var array of chapter 9 assest
        var chapter9NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter9Files/Environments/Chapter9Scene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(0.03, 0.03, 0.03)
        storyNode.position = SCNVector3(0, 0, 0)
        
        //Load Idle Animation Node
        let idlePatriciaScene = SCNScene(named: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@IdleFixed.dae")!
        for child in idlePatriciaScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(1, 1, 1)
        idleNode.position = SCNVector3(0, 0, 0)
        idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
        
        //Load Idle Animation Node
        let idleBrennonScene = SCNScene(named: "art.scnassets/3DModels/Chapter9Files/Characters/Brennon/Brennon@IdleFixed.dae")!
        for child in idleBrennonScene.rootNode.childNodes {
            SideCharacter1idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter1idleNode)
        SideCharacter1idleNode.scale = SCNVector3(1, 1, 1)
        SideCharacter1idleNode.position = SCNVector3(0, 0, 0)
        SideCharacter1idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleBalloonScene = SCNScene(named: "art.scnassets/3DModels/Chapter9Files/Characters/Balloon/Balloon@FlyAwayFixed.dae")!
        for child in idleBalloonScene.rootNode.childNodes {
            child.position = SCNVector3(0,0,0)
            SideCharacter2idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter2idleNode)
        SideCharacter2idleNode.scale = SCNVector3(1, 1, 1)
//        SideCharacter2idleNode.position = SCNVector3(6.251, -1.863, -33.8)
        SideCharacter2idleNode.position = SCNVector3(0, 0, 0)
        SideCharacter2idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleRyanScene = SCNScene(named: "art.scnassets/3DModels/Chapter9Files/Characters/Ryan/Ryan@RacingFixed.dae")!
        for child in idleRyanScene.rootNode.childNodes {
            SideCharacter3idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter3idleNode)
        SideCharacter3idleNode.scale = SCNVector3(1, 1, 1)
        SideCharacter3idleNode.position = SCNVector3(0, 0, 0)
        SideCharacter3idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        //Load Idle Animation Node
        let idleNikkiScene = SCNScene(named: "art.scnassets/3DModels/Chapter9Files/Characters/Nikki/Nikki@IdleFixed.dae")!
        for child in idleNikkiScene.rootNode.childNodes {
            SideCharacter4idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter4idleNode)
        SideCharacter4idleNode.scale = SCNVector3(0.5, 0.5, 0.5)
        SideCharacter4idleNode.position = SCNVector3(4.5, 0.3, 16)
        SideCharacter4idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(30), 0)
        
        //Load Idle Animation Node
        let idleMikkenaScene = SCNScene(named: "art.scnassets/3DModels/Chapter9Files/Characters/Mikkena/Mikkena@FigureEightFixed.dae")!
        for child in idleMikkenaScene.rootNode.childNodes {
            SideCharacter5idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter5idleNode)
        SideCharacter5idleNode.scale = SCNVector3(1, 1, 1)
        SideCharacter5idleNode.position = SCNVector3(0, 0, 0)
        SideCharacter5idleNode.eulerAngles = SCNVector3(0, GLKMathDegreesToRadians(0), 0)

        //Load Idle Animation Node
        let idleHeidiScene = SCNScene(named: "art.scnassets/3DModels/Chapter9Files/Characters/Heidi/Heidi@FlyingFixed.dae")!
        for child in idleHeidiScene.rootNode.childNodes {
            SideCharacter6idleNode.addChildNode(child)
        }
        lvlFloor.addChildNode(SideCharacter6idleNode)
        SideCharacter6idleNode.scale = SCNVector3(1, 1, 1)
        SideCharacter6idleNode.position = SCNVector3(0, 0, 0)
        SideCharacter6idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        
        
        //load all the DAE animations for this Chapter
        //load animations for mainCharacter
        prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@IdleFixed", animationIdentifier: "Patricia@IdleFixed-1")
        prepareAnimation(withKey: "MainCharacterIdle1", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@Idle1Fixed", animationIdentifier: "Patricia@Idle1Fixed-1")
        prepareAnimation(withKey: "MainCharacterIdle2", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@Idle2Fixed", animationIdentifier: "Patricia@Idle2Fixed-1")
        prepareAnimation(withKey: "MainCharacterIdle3", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@Idle3Fixed", animationIdentifier: "Patricia@Idle3Fixed-1")
        prepareAnimation(withKey: "MainCharacterRunway2", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@Runway2Fixed", animationIdentifier: "Patricia@Runway2Fixed-1")
        prepareAnimation(withKey: "MainCharacterToRace", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@ToRaceFixed", animationIdentifier: "Patricia@ToRaceFixed-1")
        prepareAnimation(withKey: "MainCharacterToBalloon", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@GettingBalloonFixed", animationIdentifier: "Patricia@GettingBalloonFixed-1")
        prepareAnimation(withKey: "MainCharacterToRyan", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@FlyingToRyanFixed", animationIdentifier: "Patricia@FlyingToRyanFixed-1")
        prepareAnimation(withKey: "MainCharacterToNikki", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@FlyingToNikkiFixed", animationIdentifier: "Patricia@FlyingToNikkiFixed-1")
        prepareAnimation(withKey: "MainCharacterToHeidi", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@FlyingToHeidiFixed", animationIdentifier: "Patricia@FlyingToHeidiFixed-1")
        prepareAnimation(withKey: "MainCharacterToBrennon", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Patricia/Patricia@FlyingToBrennonFixed", animationIdentifier: "Patricia@FlyingToBrennonFixed-1")
        
        //load animation for side character 1
        prepareAnimation(withKey: "SideCharacter1Idle", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Brennon/Brennon@IdleFixed", animationIdentifier: "Brennon@IdleFixed-1")

        //load animation for side character 3
        prepareAnimation(withKey: "SideCharacter3Racing", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Ryan/Ryan@RacingFixed", animationIdentifier: "Ryan@RacingFixed-1")
        
        //load animation for side character 4
        prepareAnimation(withKey: "SideCharacter4Idle", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Nikki/Nikki@IdleFixed", animationIdentifier: "Nikki@IdleFixed-1")

        //load animation for side character 5
        prepareAnimation(withKey: "SideCharacter5Idle", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Mikkena/Mikkena@FigureEightFixed", animationIdentifier: "Mikkena@FigureEightFixed-1")
        prepareAnimation(withKey: "SideCharacter5Approach", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Mikkena/Mikkena@ApproachFixed", animationIdentifier: "Mikkena@ApproachFixed-1")
        prepareAnimation(withKey: "SideCharacter5Return", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Mikkena/Mikkena@ReturnFixed", animationIdentifier: "Mikkena@ReturnFixed-1")

        //load animation for side character 6
        prepareAnimation(withKey: "SideCharacter6Idle", sceneName: "art.scnassets/3DModels/Chapter9Files/Characters/Heidi/Heidi@FlyingFixed", animationIdentifier: "Heidi@IdleFixed-1")

        chapter9NodeArray.append(storyNode)
        
        return chapter9NodeArray
    }
    
    func loadChapter9SoundFiles() -> [String: String] {
        let chapter9SoundArray = [
                                  //Intro to chaper 9
                                  "Narration1" : "ch4L-Intro1",
                                  "Narration2" : "ch4L-Intro2",
                                  
                                  //letter p
                                  "Narration3" : "ch4L-P-Transition1",
                                  "Narration4" : "ch4L-P-Intro1",
                                  "Narration5" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration6" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration7" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration8" : "ch1-E-Line3_01", //3 Amazing
                                  "Narration54": "ch1-E-Line3_02",//yellow dot to purple dot
                                  "Narration55": "ch1-E-Line4_01", //perfect
                                  
                                  //letter r
                                  "Narration9" : "ch4L-R-Transition1",
                                  "Narration10" : "ch4L-R-Transition2",
                                  "Narration11" : "ch4L-R-Transition3",
                                  "Narration12" : "ch4L-R-Intro1",
                                  "Narration13" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration14" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration15" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration16" : "ch1-E-Line3_01", //3 Amazing
                                  "Narration56": "ch1-E-Line3_02",//yellow dot to purple dot
                                  "Narration57": "ch1-E-Line4_01", //perfect
                                  
                                  //letter n
                                  "Narration17" : "ch4L-N-Transition1",
                                  "Narration18" : "ch4L-N-Transition2",
                                  "Narration19" : "ch4L-N-Transition3",
                                  "Narration20" : "ch4L-N-Intro1",
                                  "Narration21" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration22" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration23" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration24" : "ch1-E-Line3_01", //3 Amazing
                                  "Narration58": "ch1-E-Line3_02",//yellow dot to purple dot
                                  "Narration59": "ch1-E-Line4_01", //perfect
                                  //letter m
                                  "Narration25" : "ch4L-M-Transition1",
                                  "Narration26" : "ch4L-M-Transition2",
                                  "Narration27" : "ch4L-M-Intro1",
                                  "Narration28" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration29" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration30" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration31" : "ch1-E-Line3_01", //3 Amazing
                                  "Narration32" : "ch1-E-Line3_02", //Yellow to Purple
                                  "Narration33" : "ch1-E-Line4_01", //4 Perfect
                                  "Narration34" : "ch1-E-Line2_02", //blue to orange Again (no Pink to White dot)
                                  "Narration35" : "ch1-E-Line5_01", //5 narration40 Awesome Job
                                  "Narration62" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration63" : "ch1-E-Line3_01", //3 Amazing
                                  
                                  //letter h
                                  "Narration36" : "ch4L-H-Transition1",
                                  "Narration37" : "ch4L-H-Transition2",
                                  "Narration38" : "ch4L-H-Transition3",
                                  "Narration39" : "ch4L-H-Intro1",
                                  "Narration40" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration41" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration42" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration43" : "ch1-E-Line3_01", //3 Amazing
                                  "Narration60": "ch1-E-Line3_02",//yellow dot to purple dot
                                  "Narration61": "ch1-E-Line4_01", //perfect
            
                                  //letter b
                                  "Narration44" : "ch4L-H-Outro1",
                                  "Narration45" : "ch4L-Final1",
                                  "Narration46" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration47" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration48" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration49" : "ch1-E-Line3_01", //3 Amazing
                                  
                                  //Final
                                  "Narration50" : "ch4L-Final2",
                                  "Narration51" : "ch4L-Final3",
                                  "Narration52" : "ch4L-Final4",
                                  "Narration53" : "ch4L-Final5",
                                  
                                  //FIXME: Add background sound for fairground/racetrack
                                  //FIXME: Add sound for patricia flying
                                  "BackgroundSound" : "Birds2",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "CoinDing1" : "bell-ding_01",
                                  "CoinDing2" : "bell-ding_02",
                                  "CoinDing3" : "bell-ding_03",
                                  "CoinDing4" : "bell-ding_04",
                                  "Break1" : "RockBreak3",
                                  "Stop" : "stop",
                                  "LetterComplete" : "yeahOutside"]
        return chapter9SoundArray
    }
    
    //chapter 10 stuff here
    func loadChapter10NodeFiles () -> [SCNNode]{
        //var array of chapter 10 assest
        var chapter10NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
                let storyScene = SCNScene(named: "art.scnassets/3DModels/Chapter10Files/Environments/Chapter10Scene.scn")!
                storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
                storyNode.scale = SCNVector3(0.1, 0.1, 0.1)
                storyNode.position = SCNVector3(0, 0, 0)
                
                //Load Idle Animation Node
                let idleFinnScene = SCNScene(named: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@IdleFixed.dae")!
                for child in idleFinnScene.rootNode.childNodes {
                    idleNode.addChildNode(child)
                }
                storyNode.addChildNode(idleNode)
                idleNode.scale = SCNVector3(0.25, 0.25, 0.25)
                idleNode.position = SCNVector3(0.6, 0, 4.1)
                idleNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(-180), GLKMathDegreesToRadians(0))
                
                let lvlFloor = storyNode.childNode(withName: "LVLFloor", recursively: true)!
                
                
                //load all the DAE animations for this Chapter
                //load animations for mainCharacter
                prepareAnimation(withKey: "MainCharacterIdle", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@IdleFixed", animationIdentifier: "Finn@IdleFixed-1")
                prepareAnimation(withKey: "MainCharacterWalking", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@WalkingFixed", animationIdentifier: "Finn@WalkingFixed-1")
                prepareAnimation(withKey: "MainCharacterWaving", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@WavingFixed", animationIdentifier: "Finn@WavingFixed-1")
                prepareAnimation(withKey: "MainCharacterLooking", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@LookingAroundFixed", animationIdentifier: "Finn@LookingAroundFixed-1")
                prepareAnimation(withKey: "MainCharacterPickup", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@PickupFromWallFixed", animationIdentifier: "Finn@PickupFromWallFixed-1")
                prepareAnimation(withKey: "MainCharacterPutBack", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@PutBackOnWallFixed", animationIdentifier: "Finn@PutBackOnWallFixed-1")
                prepareAnimation(withKey: "MainCharacterFlute", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@FluteFixed", animationIdentifier: "Finn@FluteFixed-1")
                prepareAnimation(withKey: "MainCharacterQuill", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@QuillFixed", animationIdentifier: "Finn@QuillFixed-1")
                prepareAnimation(withKey: "MainCharacterXylophone", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@XylophoneFixed", animationIdentifier: "Finn@XylophoneFixed-1")
                prepareAnimation(withKey: "MainCharacterZambomba", sceneName: "art.scnassets/3DModels/Chapter10Files/Characters/Finn/Finn@ZambombaFixed", animationIdentifier: "Finn@ZambombaFixed-1")
                        
        chapter10NodeArray.append(storyNode)
        return chapter10NodeArray
    }
    
    func loadChapter10SoundFiles() -> [String: String] {
        let chapter10SoundArray = [
            
                        //Intro Narration
                                  "Narration1" : "ch5L-Intro1", //Music is one of the best things about life
                                  "Narration2" : "ch5L-Intro2", //Finn has always loved music
                                  "Narration3" : "ch5L-Intro3", //Let's help Finn find the instrument he likes best
                                  
                        //Letter F Narration
                                  "Narration4" : "ch5L-F-Intro", //Can you trace the letter F
                                  "Narration5" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration6" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration7" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration8" : "ch1-E-Line3_01", //3 Amazing
        
                        //Letter Q Narration
                                  "Narration9" : "ch5L-Q-TransitionToQ",// Flute is neat, but Finn wants to try more
                                  "Narration10" : "ch5L-Q-Intro", //Trace the letter Q to try the Quill
                                  "Narration11" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration12" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration13" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration14" : "ch1-E-Line3_01", //3 Amazing
            
                        //Letter X Narration
                                  "Narration15" : "ch5L-X-TransitionToX", //Finn not a fan of the Quill and wants to try another
                                  "Narration16" : "ch5L-X-Intro", //Trace the Letter X to try the xylophone
                                  "Narration17" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration18" : "ch1-E-Line2_01", //2 Great Job
                                  "Narration19" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration20" : "ch1-E-Line3_01", //3 Amazing
                                  
                       //Letter Z Narration
                                  "Narration21" : "ch5L-Z-TransitionToZ", //Intro to Zambomba Drum
                                  "Narration22" : "ch5L-Z-Intro", //Trace the Letter Z to Try the Zambomba
                                  "Narration23" : "ch1-E-Line1",    //1 Green to Red
                                  "Narration24" : "ch1-E-Line2_01", // Great Job
                                  "Narration25" : "ch1-E-Line2_02", //Blue to Orange
                                  "Narration26" : "ch1-E-Line3_01", //2 Amazing
                                  "Narration27" : "ch1-E-Line3_02", //Yellow to Purple
                                  "Narration28" : "ch1-F-Line3_01", //3  Fantastic
                                  
                      //Final Narration
                                  "Narration29" : "ch5L-Final1", //Zambomba isnt for Finn
                                  "Narration30" : "ch5L-Final2", //Finn knows what instrument he wants to pick
                                  "Narration31" : "ch5L-Final3", //Finn is going to get the flute
                                  "Narration32" : "ch5L-Final4", //Thank you - Good Job - final line of narration
                                  
                     //Letter Completion Feedback
                                  "Narration33" : "FluteInstrument",
                                  "Narration34" : "PanFluteInstrument",
                                  "Narration35" : "XyloInstrument",
                                  "Narration36" : "ZambombaInstrument",
                    //Extra SFX
                                  "Narration37" : "ch5L-F-GreatJob",
                                  "Narration38" : "ch5L-Q-Perfect",
                                  "Narration39" : "ch5L-X-Wonderful",
                                  "Narration40" : "ch5L-Z-YoureARockstar",
                                  
                    //Extra Template
                                  "BackgroundSound" : "RoomToneOffice",
                                  "WalkSound" : "Gravel and Grass Walk",
                                  "CoinDing1" : "bell-ding_01",
                                  "CoinDing2" : "bell-ding_02",
                                  "CoinDing3" : "bell-ding_03",
                                  "CoinDing4" : "bell-ding_04",
                                  "Break1" : "RockBreak3",
                                  "Stop" : "stop",
                                  "LetterComplete" : "yeahOutside"]
        return chapter10SoundArray
    }
    
    
    func loadlineTypeSoundFiles() -> [String: String] {
        let lineTypeSoundArray = [// - Narration
                                  "GreenToRed" : "ch1-E-Line1",    //1 Green to Red
                                  "GreatJob" : "ch1-E-Line2_01", //2 Great Job
                                  "BlueToOrange" : "ch1-E-Line2_02", //Blue to Orange
                                  "Amazing" : "ch1-E-Line3_01", //3 Amazing
                                  "YellowToPurple" : "ch1-E-Line3_02", //Yellow to Purple
                                  "Fantastic" : "ch1-F-Line3_01", //3  Fantastic
                                  //TODO: ADD PINK TO WHITE DOT NARRATION
                                  //"Narration27" : "ch1-E-Line2_02", //blue to orange Again (no Pink to White dot)
                                  "AwesomeJob" : "ch1-E-Line5_01", //5 narration40 Awesome Job
            
                                  //Extra Template
                                  //"BackgroundSound" : "RoomToneOffice",
                                  "CoinDing1" : "bell-ding_01",
                                  "CoinDing2" : "bell-ding_02",
                                  "CoinDing3" : "bell-ding_03",
                                  "CoinDing4" : "bell-ding_04",
                                  "Break1" : "RockBreak3",
                                  "Stop" : "stop",
                                  "LetterComplete" : "yeahOutside"]
        return lineTypeSoundArray
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
            
            if animationIdentifier == "Indy@WalkingFixed-1" {
                animationObject.duration = 2.083
            }
            if animationIdentifier == "Gary@ShockedFixed-1" {
                animationObject.duration = 0.444
            }
            
            //Store the animationfor later use
            chapterSelectedAnimationDict[withKey] = animationObject
        }
        //playAnimation(key: "idle")
    }
}
