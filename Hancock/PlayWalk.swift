import UIKit
import SceneKit
import ARKit
import AVFoundation

//
//  Created by Chris Ross on 2/5/20.
//

import Foundation

extension ViewController {
    
    func fadeoutWalkingSound() {
        //fade out the walking sound
        walkSound?.setVolume(0, fadeDuration: 1)
        //stop playing the walking sound
        walkSound?.stop()
        walkSound = nil
    }
    
    func playWalkAnimation() {
        //Based on Letter
        switch gameProgress {
            //----------------------------------------------------
        //MARK: Letter 1
        case .toLetter1:
            //change points based on Chapter
            switch currentChapter {
            case .Chapter1:
                //move position for letter:
                //I (chapter1 - letter 1)
                
                //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
                startTransitionAnimation(key: "MainCharacterWalking")
                //play walk sound
                walkSound = playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                                                                 
                                   
                //animate the main character to rotate a bit on the y axis
                mainCharacterIdle?.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new chapter 1
                //animate the mainFloor node to move and stop when the translation is complete
                mainFloor.runAction(SCNAction.moveBy(x:0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation)
                print("move floor for chapter one")
                
            case .Chapter2:
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
                
                workItem1 = DispatchWorkItem{self.startTransitionAnimationOnce(key: "MainCharacterStopping")}
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: workItem1!)
                
                //DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                    //self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                //})
                
                
                print("move character for chapter two")
            case .Chapter3:
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
                
                workItem1 = DispatchWorkItem{
                    self.stopTransitionAnimation(key: "MainChracterSwimming")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.9, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 4.9, execute: {
//                    self.stopTransitionAnimation(key: "MainChracterSwimming")
//                    self.startTransitionAnimation(key: "MainCharacterIdle")
//                })
                
                print("move for chapter three, letter1")
            case .Chapter4:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                stopWalkAnimation()
                //move position for letter:
                //K
                
                
                print("move floor for chapter four")
            case .Chapter5:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                //play game intro 1
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
                
                // create yellow spotlight to shine on Nails
                let lightNode = self.createSpotLightNode(intensity: 20, spotInnerAngle: 0, spotOuterAngle: 30)
                lightNode.position = SCNVector3Make(5, 20, 2)
                lightNode.eulerAngles = SCNVector3Make(-.pi/2, 0, 0)
                
                workItem2 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.stopWalkAnimation()
                }
                lightItem2 = DispatchWorkItem{
                    lightNode.removeFromParentNode()
                }
                lightItem1 = DispatchWorkItem{
                    self.charcterOneIdle.addChildNode(lightNode)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.lightItem2!)
                }
                workItem1 = DispatchWorkItem{
                    //show busted Xylophone
                    let xylophone_1 = self.mainCharacterIdle.childNode(withName: "xylophone_1 reference", recursively: true)
                    xylophone_1!.isHidden = false

                    //hide mallet head
                    let malletHead = self.mainCharacterIdle.childNode(withName: "Head", recursively: true)
                    malletHead!.isHidden = true

                    //hide first xylophone
                    let xylophone_0 = self.mainCharacterIdle.childNode(withName: "xylophone_0 reference", recursively: true)
                    xylophone_0!.isHidden = true

                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
                    //TODO: ADD touches and raytracing to select Nails
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 14, execute: self.lightItem1!)
                    
                    //look around for nails at teachers desk
                    DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute: self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//
//                    //show busted Xylophone
//                    let xylophone_1 = self.mainCharacterIdle.childNode(withName: "xylophone_1 reference", recursively: true)
//                    xylophone_1!.isHidden = false
//
//                    //hide mallet head
//                    let malletHead = self.mainCharacterIdle.childNode(withName: "Head", recursively: true)
//                    malletHead!.isHidden = true
//
//                    //hide first xylophone
//                    let xylophone_0 = self.mainCharacterIdle.childNode(withName: "xylophone_0 reference", recursively: true)
//                    xylophone_0!.isHidden = true
//
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
//                    //TODO: ADD touches and raytracing to select Nails
//
//                    //look around for nails at teachers desk
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute: {
//                        //move the main character to the first letter
//                        self.stopWalkAnimation()
//                    })
//                })
                
                //move position for letter:
            //N
            case .Chapter6:
                //FIXME: Chapter6 Letter 1
                //Barry at starting line. 5, 4, 3, 2, 1, GO!
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3") //6.65
                
                //Barry gets to the finishingline and takes off
                mainCharacterIdle.isPaused = false
                
                workItem3 = DispatchWorkItem{
                    //Barry is paused before the hurdle obsticles
                    self.mainCharacterIdle.isPaused = true
                    self.stopWalkAnimation()
                }
                workItem2 = DispatchWorkItem{
                    //Barry is off and running to the first obsticle
                    self.mainCharacterIdle.isPaused = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //Barry waits for the GO!
                    self.mainCharacterIdle.isPaused = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute:workItem1!)
                
                print("do chapter 6 stuff")
                
            case .Chapter7:
                
                //show the main character as idle
                startTransitionAnimation(key: "MainCharacterWalking")
                //play walk sound
                walkSound = playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                //animate the main character to rotate a bit on the y axis
                mainCharacterIdle?.parent?.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new chapter 1
                //animate the mainFloor node to move and stop when the translation is complete
                //mainFloor.runAction(SCNAction.moveBy(x:0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation)
                mainFloor.runAction(SCNAction.move(to: SCNVector3(173, 0, -75), duration: 4), completionHandler: stopWalkAnimation)
                print("move floor for chapter seven, letter 1")
                print("Ursa walks a little bit down the path")
                
            case .Chapter8:
                
//                self.startTransitionAnimation(key: "MainCharacterStandup")
//                DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                    self.mainCharacterIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-15)), z: 0, duration: 0.5), completionHandler: self.stopWalkAnimation)
//                })
                
                //play transition to letter l
                //playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
                
                //DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
                    stopWalkAnimation()
                //})
                
                print("do chapter 8 stuff")
                

            case .Chapter9:
                playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
                
                //Brennon lets go of his ballon
                let balloon = self.charcterOneIdle.childNode(withName: "Balloon", recursively: true)
                balloon!.isHidden = true
                
                //Brennon turns around
                charcterOneIdle.childNode(withName: "Brennon", recursively: false)!.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(180)), z: 0, duration: 1))
                                
                //Brennon's Balloon flies away
                charcterTwoIdle.isHidden = false
                charcterTwoIdle.isPaused = false
                
                workItem2 = DispatchWorkItem{
                    self.stopWalkAnimation()
                    print("do chapter 9 stuff")
                }
                workItem1 = DispatchWorkItem{
                    self.charcterTwoIdle.isPaused = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.25, execute:workItem1!)
                
                //after animation goes all the way through hide it
//                DispatchQueue.main.asyncAfter(deadline: .now() + 8.25, execute: {
//                    self.charcterTwoIdle.isPaused = true
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                        self.stopWalkAnimation()
//
//                        print("do chapter 9 stuff")
//                    })
//                })
                
            case .Chapter10:
                print("do chapter 10 stuf")
                print("move floor for chapter five")
                
                workItem1 = DispatchWorkItem{
                    //Finn walks over to the woodwind section
                    self.startTransitionAnimation(key: "MainCharacterWalking")
                    
                    // x= (-)west/(+)east, z= (-)north/(+)south
                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
                    let move2 = SCNAction.move(to: SCNVector3(-3.6, 0, 4.1), duration: 3)
                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
                    let move3 = SCNAction.move(to: SCNVector3(-3.6, 0, 1.75), duration: 3)
                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
                    let chapter10Letter1MoveSeq = SCNAction.sequence([rotate1, move2, rotate2, move3, rotate3])
                    self.mainCharacterIdle?.parent?.runAction((chapter10Letter1MoveSeq), completionHandler: self.stopWalkAnimation)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                    //Finn walks over to the woodwind section
//                    self.startTransitionAnimation(key: "MainCharacterWalking")
//
//                    // x= (-)west/(+)east, z= (-)north/(+)south
//                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
//                    let move2 = SCNAction.move(to: SCNVector3(-3.6, 0, 4.1), duration: 3)
//                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
//                    let move3 = SCNAction.move(to: SCNVector3(-3.6, 0, 1.75), duration: 3)
//                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
//                    let chapter10Letter1MoveSeq = SCNAction.sequence([rotate1, move2, rotate2, move3, rotate3])
//                    self.mainCharacterIdle?.parent?.runAction((chapter10Letter1MoveSeq), completionHandler: self.stopWalkAnimation)
//                })
                print("do chapter 10 stuff")
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 2
        case .toLetter2:
            //change points based on Chapter
            switch currentChapter {
            case .Chapter1:
                //T (chapter1 - letter 2)
                
                //show the main character as idle and hide the walking version of him
                startTransitionAnimation(key: "MainCharacterWalking")
                
                workItem1 = DispatchWorkItem{
                    //play narration for finishing letter 2
                    //self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration10"]!, fileExtension: "mp3")
                    self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Narration9"]!, fileExtension: "mp3") //LM TEST
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: self.workItem2!)//LM TEST
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: workItem1!)
                
                workItem2 = DispatchWorkItem{//LM TEST
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration10"]!, fileExtension: "mp3")//LM TEST
                }
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //play narration for finishing letter 2
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration10"]!, fileExtension: "mp3")
//                })
                
                mainFloor.runAction(SCNAction.moveBy(x: -0.1, y: 0, z: -1.3, duration: 10), completionHandler: stopWalkAnimation)
                
            case .Chapter2:
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
                
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
//                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
//                })
                
                print("move floor for chapter two")
            case .Chapter3:
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
            case .Chapter4:
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
            case .Chapter5:
                //(chapter5 -- letter2)
                
                //TODO: ADD touches and raytracing to select Nails
                
                workItem1 = DispatchWorkItem{
                    self.stopWalkAnimation()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
                //look around for nails at teachers desk
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    self.stopWalkAnimation()
//                })
                
                //Z
                
                print("move floor for chapter five")
            case .Chapter6:
                //FIXME: Chapter6 Letter 2
                //Barry jumps all the hurdles
                self.mainCharacterIdle.isPaused = false
                
                //play narration for transition to "a" tires
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration6"]!, fileExtension: "mp3") //4.58
                
                workItem2 = DispatchWorkItem{
                    self.stopWalkAnimation()
                }
                workItem1 = DispatchWorkItem{
                    //wait 3 seconds and then play animation
                    self.mainCharacterIdle.isPaused = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem1!)
                
                print("do chapter 6 stuff")
            case .Chapter7:
                //show the main character as walking
                stopTransitionAnimation(key: "MainCharacterShouting")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //play walk sound
                walkSound = playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                //animate the mainFloor node to move and stop when the translation is complete
                mainFloor.runAction(SCNAction.move(to: SCNVector3(148, 0, -50), duration: 6), completionHandler: stopWalkAnimation)
                print("move floor for chapter seven, letter 2")
                print("Ursa was to Stanley")
                
            case .Chapter8:
                //show the main character as walking
                self.stopTransitionAnimation(key: "MainCharacterCheering")
                self.startTransitionAnimation(key: "MainCharacterWalking")

                let move1 = SCNAction.move(to: SCNVector3(-0.55, 9.25, 1), duration: 4)  //to yogi the yogurt
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(40)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //look at yogi
                let chapter8Letter2RotMovSeq = SCNAction.sequence([move1, rotate1])
                mainCharacterIdle?.parent?.runAction((chapter8Letter2RotMovSeq), completionHandler: stopWalkAnimation)
                
                print("do chapter 8 stuff")
            case .Chapter9:
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration10"]!, fileExtension: "mp3")
                
                //unhide the balloon patricia is holding
                let patriciaBalloon = self.patricia1!.childNode(withName: "BrennonsBalloon", recursively: true)
                patriciaBalloon?.isHidden = false
                
                //hide the balloon that is floating in the scene
                charcterTwoIdle.isHidden = true
                
                workItem3 = DispatchWorkItem{
                    self.stopWalkAnimation()
                }
                workItem2 = DispatchWorkItem{
                    self.patricia2!.isHidden = false
                    self.patricia2!.isPaused = false
                    self.particleItem3?.cancel()
                    self.patricia1!.childNode(withName: "Patricia", recursively: false)!.removeAllParticleSystems()
                    self.patriciaNumber = 2
                    self.patriciaFlying = true
                    self.patricia1!.isHidden = true
                    self.patricia1!.isPaused = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //patricia notice that brennon is gone... where could he be?
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.3, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
//                    //patricia notice that brennon is gone... where could he be?
//                     self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.3, execute: {
//                        self.patricia2!.isHidden = false
//                        self.patricia2!.isPaused = false
//                        self.patricia1!.isHidden = true
//                        self.patricia1!.isPaused = true
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
//                            self.stopWalkAnimation()
//                        })
//                    })
//                })
                print("do chapter 9 stuff")
            case .Chapter10:
                //toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration9"]!, type: "mp3")
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration9"]!, fileExtension: "mp3")
                
                workItem1 = DispatchWorkItem{
                    //Finn walks over to the Quill section
                    self.startTransitionAnimation(key: "MainCharacterWalking")
                    
                    // x= (-)west/(+)east, z= (-)north/(+)south
                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
                    let move2 = SCNAction.move(to: SCNVector3(-3.6, 0, -0.75), duration: 2.5)
                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
                    let chapter10Letter2MoveSeq = SCNAction.sequence([rotate1, move2, rotate2])
                    self.mainCharacterIdle?.parent?.runAction((chapter10Letter2MoveSeq), completionHandler: self.stopWalkAnimation)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute:workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
//                    //Finn walks over to the Quill section
//                    self.startTransitionAnimation(key: "MainCharacterWalking")
//
//                    // x= (-)west/(+)east, z= (-)north/(+)south
//                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
//                    let move2 = SCNAction.move(to: SCNVector3(-3.6, 0, -0.75), duration: 2.5)
//                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
//                    let chapter10Letter2MoveSeq = SCNAction.sequence([rotate1, move2, rotate2])
//                    self.mainCharacterIdle?.parent?.runAction((chapter10Letter2MoveSeq), completionHandler: self.stopWalkAnimation)
//                })
                print("do chapter 10 stuf")
                print("move floor for chapter five")
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 3
        case .toLetter3:
            //change points based on Chapter
            switch currentChapter {
            case .Chapter1:
                //L (chapter1 - letter 3)
                //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
                startTransitionAnimation(key: "MainCharacterWalking")
                
                workItem1 = DispatchWorkItem{
                    //play narration for finishing letter 2
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration17"]!, fileExtension: "mp3")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //play narration for finishing letter 2
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration17"]!, fileExtension: "mp3")
//                })
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                // x= (-)west/(+)east, z= (-)north/(+)south
                let move1 = SCNAction.moveBy(x: 0.05, y: 0, z: -1.5, duration: 8)
                let move2 = SCNAction.moveBy(x: 0.5, y: 0, z: -0.02, duration: 5)
                let chapter1Letter3MoveSeq = SCNAction.sequence([move1, move2])
                mainFloor.runAction((chapter1Letter3MoveSeq), completionHandler: stopWalkAnimation)
                
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 7)
                //let rotate2 = SCNAction.rotateBy(x: 0, y: -1.75, z: 0, duration: 1)
                let rotate2 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)) , z: 0, duration: 1)
                let chapter1Letter3RotSeq = SCNAction.sequence([rotate1, rotate2])
                mainCharacterIdle?.runAction(chapter1Letter3RotSeq)
                
                
            case .Chapter2:
                //B (chapter2 - letter3)
                
                startTransitionAnimationOnce(key: "MainCharacterSkating")
                
                // x= (-)west/(+)east, z= (-)north/(+)south
                // (-) = clockwise, (+) = couter-clockwise
                let rotate1 = SCNAction.rotateBy(x: 0, y: -1.5, z: 0, duration: 1)
                let move1 = SCNAction.move(to: SCNVector3(-0.125, 0, -0.653), duration: 2) //R to B
                let rotate2 = SCNAction.rotateBy(x: 0, y: 1.5, z: 0, duration: 0.5)
                
                let chapter2Letter3MoveSeq = SCNAction.sequence([rotate1, move1, rotate2])
                mainCharacterIdle?.parent?.runAction((chapter2Letter3MoveSeq), completionHandler: stopWalkAnimation)
                
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute:workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
//                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
//                })
                
            case .Chapter3:
                //S (chapter3 - letter3)
                
                startTransitionAnimation(key: "MainCharacterSwimming")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(30)), y: CGFloat(GLKMathDegreesToRadians(-53.596)), z: CGFloat(GLKMathDegreesToRadians(-36)), duration: 3)
                let chapter3Letter3RotationSeq = SCNAction.sequence([rotate1])
                mainCharacterIdle?.parent?.runAction(chapter3Letter3RotationSeq)
                let move1 = SCNAction.move(to: SCNVector3(0.335, 0.281, 0.479), duration: 8)  //P1 to P2
                let chapter3Letter3MoveSeq = SCNAction.sequence([move1])
                mainCharacterIdle?.parent?.runAction((chapter3Letter3MoveSeq), completionHandler: stopWalkAnimation)
                
                print("move for chapter three")
            case .Chapter4:
                //W (chapter4 - letter3)
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                workItem1 = DispatchWorkItem{
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute:workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
//                })
                
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterJogging")
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate
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
            case .Chapter5:
                //(chapter5 -- letter3)
                
                //TODO: Chapter 5 - ADD touches and raytracing to select Yarn
                
                workItem1 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.stopWalkAnimation()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
                //look around for nails at teachers desk
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //move the main character to the first letter
//                    self.stopWalkAnimation()
//                })
                
                //Y
                
                print("move floor for chapter five")
            case .Chapter6:
                //FIXME: Chapter6 Letter 3
                //Barry hops through all the tires
                self.mainCharacterIdle.isPaused = false
                
                //play narration for transition to "a" tires
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3") //5.11
                
                workItem2 = DispatchWorkItem{
                    self.stopWalkAnimation()
                }
                workItem1 = DispatchWorkItem{
                    //wait 4 seconds and then pause animation
                    self.mainCharacterIdle.isPaused = true
                    
                    //wait a couple more seconds for transition narration  to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem1!)
                
                print("do chapter 6 stuff")
            case .Chapter7:
                
                //show the main character as idle
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
                
                //play walk sound
                walkSound = playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                //animate the mainFloor node to move and stop when the translation is complete
                //mainFloor.runAction(SCNAction.moveBy(x:0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation)
                mainFloor.runAction(SCNAction.move(to: SCNVector3(86, 0, -40), duration: 8), completionHandler: stopWalkAnimation)
                print("move floor for chapter seven, letter 3")
                print("Ursa walks to Vivian")
                
            case .Chapter8:
                //show the main character as walking
                self.stopTransitionAnimation(key: "MainCharacterCheering")
                self.startTransitionAnimation(key: "MainCharacterWalking")
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(200)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) // lionel turns around
                let move1 = SCNAction.move(to: SCNVector3(-1.2, 9.25, -0.8), duration: 2)  //to heads to back of fridge
                let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(242)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //look at left wall
                let move2 = SCNAction.move(to: SCNVector3(-3, 9.25, -1.75), duration: 2)  //to heads to top of stairs
                let rotate3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(95)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Lionel looks down stairs
                
                let chapter8Letter3RotMovSeq1 = SCNAction.sequence([rotate1, move1, rotate2, move2, rotate3])
                mainCharacterIdle?.parent?.runAction((chapter8Letter3RotMovSeq1))
                
                workItem2 = DispatchWorkItem{
                    self.stopTransitionAnimation(key: "MainCharacterStairwalk")
                        self.startTransitionAnimation(key: "MainCharacterWalking")
                        let rotate4 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //looks forward
                        let move4 = SCNAction.move(to: SCNVector3(1.1, 5, -0.78), duration: 2)  //Heads forward
                        let rotate5 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-50)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Lionel looks at Kimi
                        
                        let chapter8Letter3RotMovSeq2 = SCNAction.sequence([rotate4, move4, rotate5])
                        self.mainCharacterIdle?.parent?.runAction((chapter8Letter3RotMovSeq2), completionHandler: self.stopWalkAnimation)
                }
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 2)) //Lionel heads down to level 2
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem2!)
                }
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5, execute: workItem1!)
                    
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5, execute: {
//                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
//
//                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 2)) //Lionel heads down to level 2
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                        self.stopTransitionAnimation(key: "MainCharacterStairwalk")
//                        self.startTransitionAnimation(key: "MainCharacterWalking")
//                        let rotate4 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //looks forward
//                        let move4 = SCNAction.move(to: SCNVector3(1.1, 5, -0.78), duration: 2)  //Heads forward
//                        let rotate5 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-50)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Lionel looks at Kimi
//
//                        let chapter8Letter3RotMovSeq2 = SCNAction.sequence([rotate4, move4, rotate5])
//                        self.mainCharacterIdle?.parent?.runAction((chapter8Letter3RotMovSeq2), completionHandler: self.stopWalkAnimation)
//                    })
//                })
                
                print("do chapter 8 stuff")

            case .Chapter9:
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
                
                workItem3 = DispatchWorkItem{
                        //Patricia looks around for Nikki
                        self.patricia6!.isPaused = true
                        self.stopWalkAnimation()
                }
                workItem2 = DispatchWorkItem{
                        //patricia flies back up into the air to find Nikki
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
                        self.patricia6!.isHidden = false
                        self.patricia6!.isPaused = false
                        self.particleItem3?.cancel()
                        self.patricia5!.childNode(withName: "Patricia", recursively: false)!.removeAllParticleSystems()
                        self.patriciaNumber = 6
                        self.patriciaFlying = true
                        self.patricia5!.isHidden = true
                        self.patricia5!.isPaused = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10.7, execute:self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //Patricia scoots back to take off again
                    self.patricia5!.isHidden = false
                    self.patricia5!.isPaused = false
                    self.particleItem3?.cancel()
                    self.patricia4!.childNode(withName: "Patricia", recursively: false)!.removeAllParticleSystems()
                    self.patriciaNumber = 5
                    self.patriciaFlying = true
                    self.patricia4!.isHidden = true
                    self.patricia4!.isPaused = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.4, execute: self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 9.6, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 9.6, execute: {
//                    //Patricia scoots back to take off again
//                    self.patricia5!.isHidden = false
//                    self.patricia5!.isPaused = false
//                    self.patricia4!.isHidden = true
//                    self.patricia4!.isPaused = true
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.4, execute: {
//                        //patricia flies back up into the air to find Nikki
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
//                        self.patricia6!.isHidden = false
//                        self.patricia6!.isPaused = false
//                        self.patricia5!.isHidden = true
//                        self.patricia5!.isPaused = true
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 10.7, execute: {
//                            //Patricia looks arounf for Nikki
//                            self.patricia6!.isPaused = true
//
//                            self.stopWalkAnimation()
//                        })
//                    })
//                })
                print("do chapter 9 stuff")
            case .Chapter10:

                //toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration15"]!, type: "mp3")
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration15"]!, fileExtension: "mp3")
                
                workItem1 = DispatchWorkItem{
                    //Finn walks over to the Xylophone
                    self.startTransitionAnimation(key: "MainCharacterWalking")
                    
                    // x= (-)west/(+)east, z= (-)north/(+)south
                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
                    let move2 = SCNAction.move(to: SCNVector3(-3.6, 0, -3.4), duration: 2.5)
                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-270)), z: 0, duration: 0.5)
                    let move3 = SCNAction.move(to: SCNVector3(2.8, 0, -3.4), duration: 4)
                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
                    let move4 = SCNAction.move(to: SCNVector3(2.8, 0, -6.25), duration: 2)
                    let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
                    let move5 = SCNAction.move(to: SCNVector3(0.85, 1.05, -6.25), duration: 1.5)
                    let move6 = SCNAction.move(to: SCNVector3(-0.7, 1.05, -6.25), duration: 1.5)
                    let rotate5 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
                    let chapter10Letter3MoveSeq = SCNAction.sequence([rotate1, move2, rotate2, move3, rotate3, move4, rotate4, move5, move6, rotate5])
                    self.mainCharacterIdle?.parent?.runAction((chapter10Letter3MoveSeq), completionHandler: self.stopWalkAnimation)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                    //Finn walks over to the Xylophone
//                    self.startTransitionAnimation(key: "MainCharacterWalking")
//
//                    // x= (-)west/(+)east, z= (-)north/(+)south
//                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
//                    let move2 = SCNAction.move(to: SCNVector3(-3.6, 0, -3.4), duration: 2.5)
//                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-270)), z: 0, duration: 0.5)
//                    let move3 = SCNAction.move(to: SCNVector3(2.8, 0, -3.4), duration: 4)
//                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
//                    let move4 = SCNAction.move(to: SCNVector3(2.8, 0, -6.25), duration: 2)
//                    let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
//                    let move5 = SCNAction.move(to: SCNVector3(0.85, 1.05, -6.25), duration: 1.5)
//                    let move6 = SCNAction.move(to: SCNVector3(-0.7, 1.05, -6.25), duration: 1.5)
//                    let rotate5 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 0.5)
//                    let chapter10Letter3MoveSeq = SCNAction.sequence([rotate1, move2, rotate2, move3, rotate3, move4, rotate4, move5, move6, rotate5])
//                    self.mainCharacterIdle?.parent?.runAction((chapter10Letter3MoveSeq), completionHandler: self.stopWalkAnimation)
//                })
                print("do chapter 10 stuf")
                print("move floor for chapter five")
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 4
        case .toLetter4:
            //change points based on Chapter
            switch currentChapter {
            case .Chapter1:
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
                let rotate1 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(0)), z: 0, duration: 1)
                let rotate2 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 1)
                let rotate3 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 7)
                let rotate4 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(90)), z: 0, duration: 1)
                let chapter1Letter4RotSeq = SCNAction.sequence([rotate1, rotate2, rotate3, rotate4])
                mainCharacterIdle?.runAction(chapter1Letter4RotSeq)
                
                workItem1 = DispatchWorkItem{
                      self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration23"]!, fileExtension: "mp3") //LM TEST
                }
                
                 DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem1!) //LM TEST
                
            case .Chapter2:
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
                
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
//                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
//                })
                
            case .Chapter3:
                //J (chapter3 - letter4)
                
                startTransitionAnimation(key: "MainCharacterSwimming")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-163.287)), y: CGFloat(GLKMathDegreesToRadians(27.438)), z: CGFloat(GLKMathDegreesToRadians(-146.911)), duration: 3)
                let chapter3Letter4RotationSeq = SCNAction.sequence([rotate1])
                mainCharacterIdle?.parent?.runAction(chapter3Letter4RotationSeq)
                let move1 = SCNAction.move(to: SCNVector3(-0.246, 0.254, -0.371), duration: 8)  //P1 to P2
                let chapter3Letter4MoveSeq = SCNAction.sequence([move1])
                mainCharacterIdle?.parent?.runAction((chapter3Letter4MoveSeq), completionHandler: stopWalkAnimation)
                
                print("move for chapter three, letter 4")
            case .Chapter4:
                //M (chapter4 - letter4)
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration30"]!, fileExtension: "mp3")
                
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterJogging")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5)
                let move1 = SCNAction.move(to: SCNVector3(23.5 ,0 ,4.5), duration: 7)
                let chapter4Letter4RotationSeq = SCNAction.sequence([rotate1, move1])
                mainCharacterIdle?.parent?.runAction((chapter4Letter4RotationSeq), completionHandler: stopWalkAnimation)
                
                //M
                print("move floor for chapter four")
                
            case .Chapter5:
                //(chapter5 -- letter4)
                
                workItem1 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.stopWalkAnimation()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
                //look around for nails at teachers desk
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //move the main character to the first letter
//                    self.stopWalkAnimation()
//                })
                //X
                
                print("move floor for chapter five")
            case .Chapter6:
                //FIXME: Chapter6 Letter 4
                //Barry hops through all spinners
                self.mainCharacterIdle.isPaused = false
                
                //play narration for transition to "g" lowbars
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3") //5.35
                
                workItem2 = DispatchWorkItem{
                    self.stopWalkAnimation()
                }
                workItem1 = DispatchWorkItem{
                    //wait 2.35 seconds and then pause animation
                    self.mainCharacterIdle.isPaused = true
                    
                    //wait 6 more seconds for transition narration  to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.35, execute:self.workItem1!)
                print("do chapter 6 stuff")
            case .Chapter7:
                //show the main character as idle
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //play walk sound
                walkSound = playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                
                //play Ursa's roation sequence
                let rotateUrsa1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(100)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 6)
                let rotateUrsa2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(150)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5)
                let rotateUrsa3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(150)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 5.5)
                let rotateUrsa4 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(130)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5)
                let chapter7Letter4RotationSeq = SCNAction.sequence([rotateUrsa1, rotateUrsa2, rotateUrsa3, rotateUrsa4])
                mainCharacterIdle?.parent?.runAction(chapter7Letter4RotationSeq)
                
                //play the floor move sequence
                let moveScene1 = SCNAction.move(to: SCNVector3(51 ,0 ,-40), duration: 6) //toward ravine
                let moveScene2 = SCNAction.move(to: SCNVector3(35 ,0 ,-7), duration: 6) //to ravine entrance
                let moveScene3 = SCNAction.move(to: SCNVector3(-13.5, 0, 33), duration: 8) //crossing the ravine
                let chapter7Letter4MoveSeq = SCNAction.sequence([moveScene1, moveScene2, moveScene3])
                mainFloor.runAction((chapter7Letter4MoveSeq), completionHandler: stopWalkAnimation)
                
                workItem1 = DispatchWorkItem{
                    //move the main character to the first letter
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    //move the main character to the first letter
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
//                })
                print("move floor for chapter seven, letter 4")
                print("Ursa walks to Windsor")
                
            case .Chapter8:
                // TODO: Lionel moves towards Jasmine
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
                
                //show the main character as walking
                self.stopTransitionAnimation(key: "MainCharacterCheering")
                self.startTransitionAnimation(key: "MainCharacterWalking")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(33)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) // Lionel turns toward right wall
                let move1 = SCNAction.move(to: SCNVector3(3, 5, 2), duration: 3)  //Lionel heads to Jasmine
                
                let chapter8Letter4RotMovSeq = SCNAction.sequence([rotate1, move1])
                mainCharacterIdle?.parent?.runAction((chapter8Letter4RotMovSeq))
                workItem1 = DispatchWorkItem {
                    self.stopWalkAnimation()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: workItem1!)
                print("do chapter 8 stuff")
            case .Chapter9:
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration26"]!, fileExtension: "mp3")
                // Mikkena approaches Patricia
                self.startAnimateSideCharacter(key: "SideCharacter5Approach", sideCharacter: "Mikkena")
                self.stopAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Mikkena")
                
                workItem2 = DispatchWorkItem{
                   self.stopWalkAnimation()
                }
                workItem1 = DispatchWorkItem{
                    self.charcterFiveIdle.isPaused = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem1!)
                
                print("do chapter 9 stuff")
            case .Chapter10:
                workItem2 = DispatchWorkItem{
                        //Finn walks over to the Zambomba
                        self.startTransitionAnimation(key: "MainCharacterWalking")
                        
                        // x= (-)west/(+)east, z= (-)north/(+)south
                        let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-270)), z: 0, duration: 0.5)
                        let move1 = SCNAction.move(to: SCNVector3(0.85, 1.05, -6.25), duration: 1.5)
                        let move2 = SCNAction.move(to: SCNVector3(2.25, 0, -6.25), duration: 1)
                        let move3 = SCNAction.move(to: SCNVector3(2.8, 0, -6.25), duration: 1)
                        let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-360)), z: 0, duration: 0.5)
                        let move4 = SCNAction.move(to: SCNVector3(2.35, 0, -0.93), duration: 4)
                        let chapter10Letter3MoveSeq = SCNAction.sequence([rotate1, move1, move2, move3, rotate2, move4])
                        self.mainCharacterIdle?.parent?.runAction((chapter10Letter3MoveSeq), completionHandler: self.stopWalkAnimation)
                }
                workItem1 = DispatchWorkItem{
                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                        //Finn walks over to the Zambomba
//                        self.startTransitionAnimation(key: "MainCharacterWalking")
//
//                        // x= (-)west/(+)east, z= (-)north/(+)south
//                        let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-270)), z: 0, duration: 0.5)
//                        let move1 = SCNAction.move(to: SCNVector3(0.85, 1.05, -6.25), duration: 1.5)
//                        let move2 = SCNAction.move(to: SCNVector3(2.25, 0, -6.25), duration: 1)
//                        let move3 = SCNAction.move(to: SCNVector3(2.8, 0, -6.25), duration: 1)
//                        let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-360)), z: 0, duration: 0.5)
//                        let move4 = SCNAction.move(to: SCNVector3(2.35, 0, -0.93), duration: 4)
//                        let chapter10Letter3MoveSeq = SCNAction.sequence([rotate1, move1, move2, move3, rotate2, move4])
//                        self.mainCharacterIdle?.parent?.runAction((chapter10Letter3MoveSeq), completionHandler: self.stopWalkAnimation)
//                    })
//                })
                print("do chapter 10 stuf")
                print("move floor for chapter five")
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 5
        case .toLetter5:
            //change points based on Chapter
            switch currentChapter {
            case .Chapter1:
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
                //let rotate1 = SCNAction.rotateBy(x: 0, y: 0.6, z: 0, duration: 1)
                let rotate1 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(25)), z: 0, duration: 1)
                let rotate2 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)
                let rotate3 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(55)), z: 0, duration: 1)
                let chapter1Letter5RotSeq = SCNAction.sequence([rotate1, rotate2, rotate3])
                mainCharacterIdle?.runAction(chapter1Letter5RotSeq)
                
            case .Chapter2:
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
                
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
//                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
//                })
                
                print("move floor for chapter two")
            case .Chapter3:
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
            case .Chapter4:
                //A (chapter4 - letter5)
                workItem1 = DispatchWorkItem{
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration41"]!, fileExtension: "mp3")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem1!)
                
                //start narration for the Ashton
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration41"]!, fileExtension: "mp3")
//                })
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
                
            case .Chapter5:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //-----
                
                print("move floor for chapter five")
            case .Chapter6:
                    //FIXME: Chapter6 Letter 5
                    //Barry crawls under all the low bars
                    self.mainCharacterIdle.isPaused = false
                    
                    //play narration for transition to "o" rings
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration24"]!, fileExtension: "mp3") //6.74
                    
                    workItem2 = DispatchWorkItem{
                        self.stopWalkAnimation()
                    }
                    workItem1 = DispatchWorkItem{
                        //wait 3 seconds and then pause animation
                        self.mainCharacterIdle.isPaused = true
                        
                        //wait for transition narration  to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.25, execute:self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute:self.workItem1!)
                    print("do chapter 6 stuff")
            case .Chapter7:
                
                //show the main character as idle
                self.stopTransitionAnimation(key: "MainCharacterIdle")
                self.startTransitionAnimation(key: "MainCharacterWalking")
                
                //play walk sound
                walkSound = self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                
                //play Ursa's roation sequence
                let rotateUrsa1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(100)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 3.5) //to hill bottom
                let rotateUrsa2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-33)), y: CGFloat(GLKMathDegreesToRadians(100)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //start climbing
                let rotateUrsa3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-33)), y: CGFloat(GLKMathDegreesToRadians(100)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 4.5) //hold rotation till half way
                let rotateUrsa4 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-15)), y: CGFloat(GLKMathDegreesToRadians(100)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //continue to top of hill
                let rotateUrsa5 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-15)), y: CGFloat(GLKMathDegreesToRadians(100)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1.5) //continue to top of hill
                let rotateUrsa6 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(100)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //levelout at top
                let rotateUrsa7 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(100)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 3) //hold rotation till at center
                let rotateUrsa8 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1) //turn to look at Isaac
                let chapter7Letter5RotationSeq = SCNAction.sequence([rotateUrsa1, rotateUrsa2, rotateUrsa3, rotateUrsa4, rotateUrsa5, rotateUrsa6, rotateUrsa7, rotateUrsa8])
                self.mainCharacterIdle?.parent?.runAction(chapter7Letter5RotationSeq)
                
                //play the floor move sequence (15 move sequence)
                let moveScene1 = SCNAction.move(to: SCNVector3(-49 ,0 ,40), duration: 4) //to hill bottom
                let moveScene2 = SCNAction.move(to: SCNVector3(-66 ,-11 ,45), duration: 5) //to halfway up hill
                let moveScene3 = SCNAction.move(to: SCNVector3(-79, -14.75, 47.75), duration: 2)//to edge of top of hill
                let moveScene4 = SCNAction.move(to: SCNVector3(-95 ,-15.2 ,48), duration: 3) //to center of top of hill
                let moveScene5 = SCNAction.move(to: SCNVector3(-95 ,-15.2 ,48), duration: 1) //stay at hilltop while rotating Ursa
                let chapter7Letter5MoveSeq = SCNAction.sequence([moveScene1, moveScene2, moveScene3, moveScene4, moveScene5])
                    self.mainFloor.runAction((chapter7Letter5MoveSeq), completionHandler: self.stopWalkAnimation)
                
                print("move floor for chapter seven, letter 5")
                print("Ursa walks to top of the hill and sees Isaac")
                
            case .Chapter8:
                //show the main character as walking
                self.stopTransitionAnimation(key: "MainCharacterCheering")
                self.startTransitionAnimation(key: "MainCharacterWalking")
                
                let move1 = SCNAction.move(to: SCNVector3(3, 5, 2), duration: 3)  //Lionel heads to stairs
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //looks down the stairs
                
                let chapter8Letter5RotMovSeq = SCNAction.sequence([move1, rotate1])
                mainCharacterIdle?.parent?.runAction((chapter8Letter5RotMovSeq))
                
                workItem2 = DispatchWorkItem{
                    self.stopTransitionAnimation(key: "MainCharacterStairwalk")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    self.mainCharacterIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y:  CGFloat(GLKMathDegreesToRadians(-60)), z: 0, duration: 0.5), completionHandler: self.stopWalkAnimation)  //looks at Ernie
                }
                workItem1 = DispatchWorkItem{
                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration27"]!, fileExtension: "mp3")
                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-1.1, 0.75, 2), duration: 3)) //Lionel heads down to level 1
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem2!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
//
//                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-1.1, 0.75, 2), duration: 3)) //Lionel heads down to level 1
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                        self.stopTransitionAnimation(key: "MainCharacterStairwalk")
//                        self.startTransitionAnimation(key: "MainCharacterIdle")
//                        self.mainCharacterIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y:  CGFloat(GLKMathDegreesToRadians(-60)), z: 0, duration: 0.5), completionHandler: self.stopWalkAnimation)  //looks at Ernie
//                    })
//                })
                print("do chapter 8 stuff")
            case .Chapter9:
                // Put Particles on Heidi
            let particles = self.createParticleSystem()
            particleItem2 = DispatchWorkItem {
                self.charcterSixIdle.childNode(withName: "HeidiGroup", recursively: false)!.removeParticleSystem(particles)
            }
            particleItem1 = DispatchWorkItem {
                self.charcterSixIdle.childNode(withName: "HeidiGroup", recursively: false)!.addParticleSystem(particles)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.particleItem2!)
            }

            workItem3 = DispatchWorkItem{
                self.stopWalkAnimation()
            }
            workItem2 = DispatchWorkItem{
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration38"]!, fileExtension: "mp3")
                // Mikkena goes back to idle
                self.startAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Mikkena")
                self.stopAnimateSideCharacter(key: "SideCharacter5Return", sideCharacter: "Mikkena")
                
                //Patricia flies back up to find Heidi
                self.patricia8!.isHidden = false
                self.patricia8!.isPaused = false
                self.patriciaNumber = 8
                self.patriciaFlying = true
                self.patricia7!.isHidden = true
                self.patricia7!.isPaused = true
                
                //Brennon gets a new Balloon
                let balloon = self.charcterOneIdle.childNode(withName: "Balloon2", recursively: true)
                balloon!.isHidden = false
                
                //Brennon comes out from the Balloon stand
                let move1 = SCNAction.move(to: SCNVector3(-9.7,  0.25, -8), duration: 2)
                let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-55)), z: 0, duration: 1)
                let move2 = SCNAction.move(to: SCNVector3(-11.15, 0.25, -7), duration: 2)
                let brennonMoveSeq = SCNAction.sequence([move1, rotate2, move2])

                self.charcterOneIdle.childNode(withName: "Brennon", recursively: true)!.runAction(brennonMoveSeq)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: self.particleItem1!)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.4, execute: self.workItem3!)
            }
            workItem1 = DispatchWorkItem {
                // Mikkena returns
                self.startAnimateSideCharacter(key: "SideCharacter5Return", sideCharacter: "Mikkena")
                self.stopAnimateSideCharacter(key: "SideCharacter5Approach", sideCharacter: "Mikkena")
                DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: self.workItem2!)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: workItem1!)
            
//                DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration27"]!, fileExtension: "mp3")
//
//                    //Patricia flies back up to find Heidi
//                    self.patricia8!.isHidden = false
//                    self.patricia8!.isPaused = false
//                    self.patricia7!.isHidden = true
//                    self.patricia7!.isPaused = true
//
//                    //Brennon gets a new Balloon
//                    let balloon = self.charcterOneIdle.childNode(withName: "Balloon2", recursively: true)
//                    balloon!.isHidden = false
//
//                    //Brennon comes out from the Balloon stand
//                    let move1 = SCNAction.move(to: SCNVector3(-9.7,  0.25, -8), duration: 2)
//                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-55)), z: 0, duration: 1)
//                    let move2 = SCNAction.move(to: SCNVector3(-11.15, 0.25, -7), duration: 2)
//                    let brennonMoveSeq = SCNAction.sequence([move1, rotate2, move2])
//
//                    self.charcterOneIdle.childNode(withName: "Brennon", recursively: true)!.runAction(brennonMoveSeq)
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 12.4, execute: {
//                        self.stopWalkAnimation()
//                    })
//                })
                
                
                
                print("do chapter 9 stuff")
            case .Chapter10:
                //toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration29"]!, type: "mp3") //the zambomba isn't for finn
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration29"]!, fileExtension: "mp3")
                
                workItem1 = DispatchWorkItem{
                    //Finn walks to the flute again
                    self.startTransitionAnimation(key: "MainCharacterWalking")
                    
                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration30"]!, type: "mp3") //finn knows which instrument he wants
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration30"]!, fileExtension: "mp3")
                    
                    // x= (-)west/(+)east, z= (-)north/(+)south
                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 1)
                    let move1 = SCNAction.move(to: SCNVector3(2.35, 0, -3.6), duration: 2)
                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
                    let move2 = SCNAction.move(to: SCNVector3(-3.6, 0, -3.6), duration: 4)
                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(0)), z: 0, duration: 0.5)
                    let move3 = SCNAction.move(to: SCNVector3(-3.6, 0, 1.75), duration: 4)
                    let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
                    let chapter10Letter3MoveSeq = SCNAction.sequence([rotate1, move1, rotate2, move2, rotate3, move3, rotate4])
                    self.mainCharacterIdle?.parent?.runAction((chapter10Letter3MoveSeq), completionHandler: self.stopWalkAnimation)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
                    
//                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                    //Finn walks to the flute again
//                    self.startTransitionAnimation(key: "MainCharacterWalking")
//
//                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration30"]!, type: "mp3") //finn knows which instrument he wants
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration30"]!, fileExtension: "mp3")
//
//                    // x= (-)west/(+)east, z= (-)north/(+)south
//                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-180)), z: 0, duration: 1)
//                    let move1 = SCNAction.move(to: SCNVector3(2.35, 0, -3.6), duration: 2)
//                    let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
//                    let move2 = SCNAction.move(to: SCNVector3(-3.6, 0, -3.6), duration: 4)
//                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(0)), z: 0, duration: 0.5)
//                    let move3 = SCNAction.move(to: SCNVector3(-3.6, 0, 1.75), duration: 4)
//                    let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 0.5)
//                    let chapter10Letter3MoveSeq = SCNAction.sequence([rotate1, move1, rotate2, move2, rotate3, move3, rotate4])
//                    self.mainCharacterIdle?.parent?.runAction((chapter10Letter3MoveSeq), completionHandler: self.stopWalkAnimation)
//                })
                print("do chapter 10 stuf")
                print("move floor for chapter five")
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 6
        case .toLetter6:
            //change points based on Chapter
            switch currentChapter {
            case .Chapter1:
                //H (chapter1 - letter 6)
                
                //show the main character as idle and hide the walking version of him (temporary; will fix animation system later)
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                // x= (-)west/(+)east, z= (-)north/(+)south
                let rotate1 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-5)), z: 0, duration: 0.5)
                let rotatePause = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 3.5)
                let rotate2 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-75)), z: 0, duration: 0.5)
                
                //move up and down the hill before Hannah
                let move1 = SCNAction.move(by: SCNVector3(x: 0.3,y: -0.04,z: -0.5), duration: 2)
                let move2 = SCNAction.move(by: SCNVector3(x: 0.2,y: 0.04,z: -0.5), duration: 2)
                let move3 = SCNAction.move(by: SCNVector3(x: 0.2,y: 0,z: 0), duration: 2)
                
                //Indy walking to Hannah
                let chapter1Letter6MoveSeq1_0 = SCNAction.sequence([move1, move2, move3])
                mainFloor.runAction(chapter1Letter6MoveSeq1_0)
                
                //Indy rotating to Hannah
                let chapter1Letter6MoveSeq1_1 = SCNAction.sequence([rotate1, rotatePause, rotate2])
                self.mainCharacterIdle.parent?.runAction((chapter1Letter6MoveSeq1_1))
                
                workItem4 = DispatchWorkItem{
                    self.stopAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
                    self.startAnimateSideCharacter(key: "SideCharacter5Surprise", sideCharacter: "Hannah")
                }
                workItem3 = DispatchWorkItem{
                        self.stopAnimateSideCharacter(key: "SideCharacter5Walk", sideCharacter: "Hannah")
                        self.startAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
                        
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: self.workItem4!)
                }
                workItem2 = DispatchWorkItem{
                        //Hannah and Indy walk together to the Tree
                        
                        //hannah sequence
                        self.stopAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
                        self.startAnimateSideCharacter(key: "SideCharacter5Walk", sideCharacter: "Hannah")
                        self.startTransitionAnimation(key: "MainCharacterWalking")
                        
                        //start walking sound
                        self.walkSound = self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                        
                        //                        let hannahRotate1 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 1)
                        let hannahRotate1 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(45)), z: 0, duration: 1)
                        let hannahMove1 = SCNAction.move(to: SCNVector3(x: 21.5,y: 1.1,z: -11.2), duration: 2)
                        let hannahMove2 = SCNAction.move(to: SCNVector3(x: 19.75,y: 1.7,z: -0.65), duration: 4)
                        let hannahMove3 = SCNAction.move(to: SCNVector3(x: 21.4,y: 1.4,z: 4.7), duration: 4)
                        
                        let hannahLetter6MoveSeq = SCNAction.sequence([hannahRotate1, hannahMove1, hannahMove2, hannahMove3])
                        self.charcterFiveIdle.parent?.runAction(hannahLetter6MoveSeq)
                        
                        //Indy sequence
                        //let rotate3 = SCNAction.rotateBy(x: 0, y: -1.50, z: 0, duration: 0.5)
                        let rotate3 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-80)), z: 0, duration: 0.5)
                        let rotatePause1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1.5)
                        //let rotate4 = SCNAction.rotateBy(x: 0, y: -0.40, z: 0, duration: 0.5)
                        let rotate4 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-20)), z: 0, duration: 0.5)
                        
                        //move indy uphill by moving the floor down
                        let move3 = SCNAction.move(by: SCNVector3(x: 0.2, y: -0.04, z: 0.4), duration: 2)
                        let move4 = SCNAction.move(by: SCNVector3(x: 0.1, y: 0, z: 0.5), duration: 4)
                        let move5 = SCNAction.move(by: SCNVector3(x: -0.1, y: -0.02, z: 0.6), duration: 4)
                        
                        //Indy rotating to H
                        let chapter1Letter6MoveSeq2_0 = SCNAction.sequence([rotate3, rotatePause1, rotate4])
                        self.mainCharacterIdle.parent?.runAction((chapter1Letter6MoveSeq2_0))
                        //Indy walking to H
                        let chapter1Letter6MoveSeq2 = SCNAction.sequence([move3, move4, move5])
                        self.mainFloor.runAction((chapter1Letter6MoveSeq2), completionHandler: self.stopWalkAnimation)
                        
                    DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //Hannah stop dancing and Idle till narration done
                    [weak self] in self?.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration42"]!, fileExtension: "mp3")
                    self?.charcterFiveIdle.parent?.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-135)), z: 0, duration: 0.5))
                    self?.stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    self?.fadeoutWalkingSound()
                    
                    self?.stopAnimateSideCharacter(key: "SideCharacter5Dancing", sideCharacter: "Hannah")
                    self?.startAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: self!.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5, execute: {
//                    //Hannah stop dancing and Idle till narration done
//                    [weak self] in self?.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration42"]!, fileExtension: "mp3")
//                    self?.charcterFiveIdle.parent?.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-135)), z: 0, duration: 0.5))
//                    self?.stopTransitionAnimation(key: "MainCharacterWalking")
//
//                    self?.fadeoutWalkingSound()
//
//                    self?.stopAnimateSideCharacter(key: "SideCharacter5Dancing", sideCharacter: "Hannah")
//                    self?.startAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
//                        //Hannah and Indy walk together to the Tree
//
//                        //hannah sequence
//                        self?.stopAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
//                        self?.startAnimateSideCharacter(key: "SideCharacter5Walk", sideCharacter: "Hannah")
//                        self?.startTransitionAnimation(key: "MainCharacterWalking")
//
//                        //start walking sound
//                        walkSound = self?.playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
//
//                        //                        let hannahRotate1 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 1)
//                        let hannahRotate1 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(45)), z: 0, duration: 1)
//                        let hannahMove1 = SCNAction.move(to: SCNVector3(x: 21.5,y: 1.1,z: -11.2), duration: 2)
//                        let hannahMove2 = SCNAction.move(to: SCNVector3(x: 19.75,y: 1.7,z: -0.65), duration: 4)
//                        let hannahMove3 = SCNAction.move(to: SCNVector3(x: 21.4,y: 1.4,z: 4.7), duration: 4)
//
//                        let hannahLetter6MoveSeq = SCNAction.sequence([hannahRotate1, hannahMove1, hannahMove2, hannahMove3])
//                        self?.charcterFiveIdle.parent?.runAction(hannahLetter6MoveSeq)
//
//                        //Indy sequence
//                        //let rotate3 = SCNAction.rotateBy(x: 0, y: -1.50, z: 0, duration: 0.5)
//                        let rotate3 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-80)), z: 0, duration: 0.5)
//                        let rotatePause1 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1.5)
//                        //let rotate4 = SCNAction.rotateBy(x: 0, y: -0.40, z: 0, duration: 0.5)
//                        let rotate4 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-20)), z: 0, duration: 0.5)
//
//                        //move indy uphill by moving the floor down
//                        let move3 = SCNAction.move(by: SCNVector3(x: 0.2, y: -0.04, z: 0.4), duration: 2)
//                        let move4 = SCNAction.move(by: SCNVector3(x: 0.1, y: 0, z: 0.5), duration: 4)
//                        let move5 = SCNAction.move(by: SCNVector3(x: -0.1, y: -0.02, z: 0.6), duration: 4)
//
//                        //Indy rotating to H
//                        let chapter1Letter6MoveSeq2_0 = SCNAction.sequence([rotate3, rotatePause1, rotate4])
//                        self?.mainCharacterIdle.parent?.runAction((chapter1Letter6MoveSeq2_0))
//                        //Indy walking to H
//                        let chapter1Letter6MoveSeq2 = SCNAction.sequence([move3, move4, move5])
//                        self?.mainFloor.runAction((chapter1Letter6MoveSeq2), completionHandler: self?.stopWalkAnimation)
//
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                            self?.stopAnimateSideCharacter(key: "SideCharacter5Walk", sideCharacter: "Hannah")
//                            self?.startAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
//                                self?.stopAnimateSideCharacter(key: "SideCharacter5Idle", sideCharacter: "Hannah")
//                                self?.startAnimateSideCharacter(key: "SideCharacter5Surprise", sideCharacter: "Hannah")
//                            })
//
//                        })
//                    })
//                })
                
                //H
                
            case .Chapter2:
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
                
                workItem1 = DispatchWorkItem{
                   self.startTransitionAnimationOnce(key: "MainCharacterStopping")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
//                    self.startTransitionAnimationOnce(key: "MainCharacterStopping")
//                })
                
                print("move floor for chapter two")
            case .Chapter3:
                //S (chapter3 - letter3)
                print("no letter 6 for chapter 3")
            case .Chapter4:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //----
                
                print("move floor for chapter four")
            case .Chapter5:
                //animate the mainFloor node to move and stop when the translation is complete
                //animate the main character to rotate a bit on the y axis
                
                //---
                
                print("move floor for chapter five")
            case .Chapter6:
                //FIXME: Chapter6 Letter 6
                //Barry swings through all the "o" rings
                self.mainCharacterIdle.isPaused = false
                
                //play narration for Barry winning the race
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Finish"]!, fileExtension: "mp3") //5.04
                
                workItem2 = DispatchWorkItem{
                    self.resetGame()
                }
                workItem1 = DispatchWorkItem{
                    //Barry win pose
                    self.mainCharacterIdle.isPaused = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute:self.workItem1!)
                print("do chapter 6 stuff")
            case .Chapter7:
                
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration35"]!, fileExtension: "mp3") //10 sec long
                
                //show the main character as walking
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //play walk sound
                walkSound = playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                
                //play Ursa's roation sequence
                //first move 3 seconds
                let rotateUrsa1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 2.5) //hold to edge of hill top
                let rotateUrsa2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(25)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //tilt down toward halfway point
                
                //second move 2 seconds
                let rotateUrsa3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(25)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1.5) //hold to halfway point
                let rotateUrsa4 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(38.25)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //tilt down toward bottom
                
                //third move 3 seconds
                let rotateUrsa5 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(38.25)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 2.5) //hold till at bottom
                let rotateUrsa6 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //level out at bottome
                
                //fourth move 2 seconds
                let rotateUrsa7 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-25)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //tilt up toward log top
                let rotateUrsa8 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-25)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1) //hold to log top
                let rotateUrsa9 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //level out at top
                
                //fith move 2 seconds
                let rotateUrsa10 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1.5) //hold level at top
                let rotateUrsa11 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(38)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //tilt toward log bottom
                
                //sixth move 2 seconds
                let rotateUrsa12 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(38)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1) //hold till at log bottom
                let rotateUrsa13 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(37)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //level out at log bottom
                
                //face tyler while moving toward him
                let rotateUrsa14 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(60)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //turn toward tyler
                
                let chapter7Letter6RotationSeq = SCNAction.sequence([rotateUrsa1, rotateUrsa2, rotateUrsa3, rotateUrsa4, rotateUrsa5, rotateUrsa6, rotateUrsa7, rotateUrsa8, rotateUrsa9, rotateUrsa10, rotateUrsa11, rotateUrsa12, rotateUrsa13, rotateUrsa14])
                mainCharacterIdle?.parent?.runAction(chapter7Letter6RotationSeq)
                
                //play the floor move sequence (17 second sequence)
                let moveScene1 = SCNAction.move(to: SCNVector3(-103, -14.75, 39), duration: 3) //to hill top edge
                
                let moveScene2 = SCNAction.move(to: SCNVector3(-112, -8.75, 27), duration: 2) //to hill mid point
                
                let moveScene3 = SCNAction.move(to: SCNVector3(-117.4, 0 , 18), duration: 3) //to hill bottom
                
                let moveScene4 = SCNAction.move(to: SCNVector3(-120.3, -3.75, 14.5), duration: 2) //to top of log
                
                let moveScene5 = SCNAction.move(to: SCNVector3(-121.4, -3.75, 13.5), duration: 2) //across log
                
                let moveScene6 = SCNAction.move(to: SCNVector3(-123, 0, 11.5), duration: 2) //to bottom of log
                
                let moveScene7 = SCNAction.move(to: SCNVector3(-131.5, 0, 6), duration: 3) //to tyler at the stream
                
                let chapter7Letter6MoveSeq = SCNAction.sequence([moveScene1, moveScene2, moveScene3, moveScene4, moveScene5, moveScene6, moveScene7])
                mainFloor.runAction((chapter7Letter6MoveSeq), completionHandler: stopWalkAnimation)
                
                print("move floor for chapter seven, letter 6")
                print("Ursa walk over the log and goes to Tyler")
                
            case .Chapter8:
                //Final Walk
                                
                //show the main character as walking
                self.stopTransitionAnimation(key: "MainCharacterCheering")
                self.startTransitionAnimation(key: "MainCharacterWalking")
                
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration34"]!, fileExtension: "mp3")
                
                workItem5 = DispatchWorkItem{
                    self.stopTransitionAnimation(key: "MainCharacterWalking")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                }
                workItem4 = DispatchWorkItem{
                    self.stopTransitionAnimation(key: "MainCharacterStairwalk")
                    self.startTransitionAnimation(key: "MainCharacterWalking")
                    
                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(430)), z: 0, duration: 0.5) // lionel turns toward center of the fidge
                    let move2 = SCNAction.move(to: SCNVector3(-1, 9.25, -1), duration: 3)  //Lionel moves to fridge center
                    let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(365)), z: 0, duration: 0.5) //looks toward front of fridge
                    let move3 = SCNAction.move(to: SCNVector3(-0.6, 9.25, 2.5), duration: 3)  //Lionel moves to fridge front
                    
                    let chapter8Letter5RotMovSeq2 = SCNAction.sequence([rotate3, move2, rotate4, move3])
                    self.mainCharacterIdle?.parent?.runAction((chapter8Letter5RotMovSeq2))
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: self.workItem5!)
                }
                workItem3 = DispatchWorkItem{
                    //walking up the stairs
                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-3, 9.25, -1.75), duration: 3)) //Lionel heads up to level 1
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem4!)
                }
                workItem2 = DispatchWorkItem{
                    self.stopTransitionAnimation(key: "MainCharacterStairwalk")
                    self.startTransitionAnimation(key: "MainCharacterWalking")
                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(205)), z: 0, duration: 0.5) // lionel turns toward the stairs to level 1
                    let move1 = SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 3)  //Lionel heads to stairs
                    let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(270)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //looks up the stairs to top level
                    
                    let chapter8Letter5RotMovSeq1 = SCNAction.sequence([rotate1, move1, rotate2])
                    self.mainCharacterIdle?.parent?.runAction((chapter8Letter5RotMovSeq1))
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //walking up the stairs
                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(3, 5, 2), duration: 3)) //Lionel heads up to level 2
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem2!)
                }
                        
                //Lionel's walk
                mainCharacterIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(90)), z: 0, duration: 0.5))// lionel turns toward the stairs up
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //walking up the stairs
//                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
//                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(3, 5, 2), duration: 3)) //Lionel heads up to level 2
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                        self.stopTransitionAnimation(key: "MainCharacterStairwalk")
//                        self.startTransitionAnimation(key: "MainCharacterWalking")
//                        let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(205)), z: 0, duration: 0.5) // lionel turns toward the stairs to level 1
//                        let move1 = SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 3)  //Lionel heads to stairs
//                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(270)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //looks up the stairs to top level
//
//                        let chapter8Letter5RotMovSeq1 = SCNAction.sequence([rotate1, move1, rotate2])
//                        self.mainCharacterIdle?.parent?.runAction((chapter8Letter5RotMovSeq1))
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                            //walking up the stairs
//                            self.startTransitionAnimation(key: "MainCharacterStairwalk")
//                            self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-3, 9.25, -1.75), duration: 3)) //Lionel heads up to level 1
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                                self.stopTransitionAnimation(key: "MainCharacterStairwalk")
//                                self.startTransitionAnimation(key: "MainCharacterWalking")
//
//                                let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(430)), z: 0, duration: 0.5) // lionel turns toward center of the fidge
//                                let move2 = SCNAction.move(to: SCNVector3(-1, 9.25, -1), duration: 3)  //Lionel moves to fridge center
//                                let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(365)), z: 0, duration: 0.5) //looks toward front of fridge
//                                let move3 = SCNAction.move(to: SCNVector3(-0.6, 9.25, 2.5), duration: 3)  //Lionel moves to fridge front
//
//                                let chapter8Letter5RotMovSeq2 = SCNAction.sequence([rotate3, move2, rotate4, move3])
//                                self.mainCharacterIdle?.parent?.runAction((chapter8Letter5RotMovSeq2))
//
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                                    self.stopTransitionAnimation(key: "MainCharacterWalking")
//                                    self.startTransitionAnimation(key: "MainCharacterIdle")
//                                })
//
//                            })
//                        })
//                    })
                
                workItem11 = DispatchWorkItem{
                    self.stopAnimateSideCharacter(key: "SideCharacter4Stairwalk", sideCharacter: "Ernie")
                    self.startAnimateSideCharacter(key: "SideCharacter4Walking", sideCharacter: "Ernie")
                    
                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(430)), z: 0, duration: 0.5) //Ernie turns to the center of the level floor
                    let move2 = SCNAction.move(to: SCNVector3(-1, 9.25, -1), duration: 3)
                        //Ernie walks to the center of the level 1 floor
                    let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(365)), z: 0, duration: 0.5) //Ernie turns to the front of the fridge
                    let move3 = SCNAction.move(to: SCNVector3(-0.34, 9.25, 0.45), duration: 3)  //Ernie walks to the front of the fridge
                    let chapter8Letter5RotMovSeq4 = SCNAction.sequence([rotate3, move2, rotate4, move3])
                    self.charcterFourIdle?.parent?.runAction((chapter8Letter5RotMovSeq4), completionHandler: self.stopWalkAnimation)

                }
                workItem10 = DispatchWorkItem{
                    //walking up the stairs
                    self.startAnimateSideCharacter(key: "SideCharacter4Stairwalk", sideCharacter: "Ernie")
                    self.charcterFourIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-3, 9.25, -1.75), duration: 3))
                    
                    //Ernie Level 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem11!)
                }
                workItem9 = DispatchWorkItem{
                        self.stopAnimateSideCharacter(key: "SideCharacter4Stairwalk", sideCharacter: "Ernie")
                        self.startAnimateSideCharacter(key: "SideCharacter4Walking", sideCharacter: "Ernie")
                        let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(205)), z: 0, duration: 0.5) //Ernie turns toward the bottom of the stairs to level 1
                        let move1 = SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 3)  //Ernie walks to the bottom of the stairs to level 1
                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(270)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Ernie looks up the stairs
                        let chapter8Letter5RotMovSeq3 = SCNAction.sequence([rotate1, move1, rotate2])
                        self.charcterFourIdle?.parent?.runAction((chapter8Letter5RotMovSeq3))
                        
                        //Ernie walks up the stairs to level 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem10!)
                }
                workItem8 = DispatchWorkItem{
                        //walking up the stairs
                        self.startAnimateSideCharacter(key: "SideCharacter4Stairwalk", sideCharacter: "Ernie")
                        self.charcterFourIdle.parent?.runAction(SCNAction.move(to: SCNVector3(3, 5, 2), duration: 3))
                        
                        //Ernie level 2
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem9!)
                }
                workItem7 = DispatchWorkItem{
                    self.charcterFourIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(90)), z: 0, duration: 0.5))
                                            
                    //Ernie walks up the stairs to Level 2
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem8!)
                }
                workItem6 = DispatchWorkItem{
                    self.stopAnimateSideCharacter(key: "SideCharacter4Cheering", sideCharacter: "Ernie")
                    self.startAnimateSideCharacter(key: "SideCharacter4Walking", sideCharacter: "Ernie")
                    self.charcterFourIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-1.1, 0.75, 2), duration: 1))
                    
                    //Ernie looks up the stairs
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem7!)
                        
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: workItem6!)
                //Ernie's walk
                //Ernie walks to the bottom of the stairs
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                    self.stopAnimateSideCharacter(key: "SideCharacter4Cheering", sideCharacter: "Ernie")
//                    self.startAnimateSideCharacter(key: "SideCharacter4Walking", sideCharacter: "Ernie")
//                    self.charcterFourIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-1.1, 0.75, 2), duration: 1))
//
//                    //Ernie looks up the stairs
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        self.charcterFourIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(90)), z: 0, duration: 0.5))
//
//                        //Ernie walks up the stairs to Level 2
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //walking up the stairs
//                            self.startAnimateSideCharacter(key: "SideCharacter4Stairwalk", sideCharacter: "Ernie")
//                            self.charcterFourIdle.parent?.runAction(SCNAction.move(to: SCNVector3(3, 5, 2), duration: 3))
//
//                            //Ernie level 2
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                                self.stopAnimateSideCharacter(key: "SideCharacter4Stairwalk", sideCharacter: "Ernie")
//                                self.startAnimateSideCharacter(key: "SideCharacter4Walking", sideCharacter: "Ernie")
//                                let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(205)), z: 0, duration: 0.5) //Ernie turns toward the bottom of the stairs to level 1
//                                let move1 = SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 3)  //Ernie walks to the bottom of the stairs to level 1
//                                let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(270)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Ernie looks up the stairs
//                                let chapter8Letter5RotMovSeq3 = SCNAction.sequence([rotate1, move1, rotate2])
//                                self.charcterFourIdle?.parent?.runAction((chapter8Letter5RotMovSeq3))
//
//                                //Ernie walks up the stairs to level 1
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                                    //walking up the stairs
//                                    self.startAnimateSideCharacter(key: "SideCharacter4Stairwalk", sideCharacter: "Ernie")
//                                    self.charcterFourIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-3, 9.25, -1.75), duration: 3))
//
//                                    //Ernie Level 1
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                                        self.stopAnimateSideCharacter(key: "SideCharacter4Stairwalk", sideCharacter: "Ernie")
//                                        self.startAnimateSideCharacter(key: "SideCharacter4Walking", sideCharacter: "Ernie")
//
//                                        let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(430)), z: 0, duration: 0.5) //Ernie turns to the center of the level floor
//                                        let move2 = SCNAction.move(to: SCNVector3(-1, 9.25, -1), duration: 3)
//                                            //Ernie walks to the center of the level 1 floor
//                                        let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(365)), z: 0, duration: 0.5) //Ernie turns to the front of the fridge
//                                        let move3 = SCNAction.move(to: SCNVector3(-0.34, 9.25, 0.45), duration: 3)  //Ernie walks to the front of the fridge
//                                        let chapter8Letter5RotMovSeq4 = SCNAction.sequence([rotate3, move2, rotate4, move3])
//                                        self.charcterFourIdle?.parent?.runAction((chapter8Letter5RotMovSeq4), completionHandler: self.stopWalkAnimation)
//
//                                    })
//                                })
//                            })
//                        })
//                    })
                
                workItem15 = DispatchWorkItem{
                    self.stopAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Kimi")
                    self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Kimi")
                }
                workItem14 = DispatchWorkItem{
                    self.stopAnimateSideCharacter(key: "SideCharacter2Stairwalk", sideCharacter: "Kimi")
                    self.startAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Kimi")
                    
                    let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(430)), z: 0, duration: 0.5) //Kimi looks at the center of the frig
                    let move2 = SCNAction.move(to: SCNVector3(-1, 9.25, -1), duration: 3)
                        //Kimi walks to the center of the frig
                    let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(365)), z: 0, duration: 0.5) //Kimi looks to the front of the frig
                    let move3 = SCNAction.move(to: SCNVector3(-0.8, 9.25, 1.25), duration: 3)  //Kimi walks to the front of the frig
                    let chapter8Letter5RotMovSeq6 = SCNAction.sequence([rotate3, move2, rotate4, move3])
                    self.charcterTwoIdle?.parent?.runAction(chapter8Letter5RotMovSeq6)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: self.workItem15!)
                }
                workItem13 = DispatchWorkItem{
                    self.startAnimateSideCharacter(key: "SideCharacter2Stairwalk", sideCharacter: "Kimi")
                    self.charcterTwoIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-3, 9.25, -1.75), duration: 3))
                    
                    //Ernie Level 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem14!)
                }
                workItem12 = DispatchWorkItem{
                    self.stopAnimateSideCharacter(key: "SideCharacter2Stairwalk", sideCharacter: "Kimi")
                    self.startAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Kimi")
                    
                    let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(115)), z: 0, duration: 0.5) //Kimi looks toward center of floor 2
                    let move1 = SCNAction.move(to: SCNVector3(-1, 5, 0.35), duration: 2)  //Kimi walks to center of floor 2
                    let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(135)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Kimi looks to bottom of stairs
                    let move2 = SCNAction.move(to: SCNVector3(1.2, 5, -1.8), duration: 2) //Kimi walks to the bottom of the stairs to level 1
                    let rotate3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(270)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Kimi looks up the stairs
                    let chapter8Letter5RotMovSeq5 = SCNAction.sequence([rotate1, move1, rotate2, move2, rotate3])
                    self.charcterTwoIdle?.parent?.runAction(chapter8Letter5RotMovSeq5)
                    
                    //Kimi walks up the stairs
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5, execute: self.workItem13!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem12!)
                
                    //Kimi's walk
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        self.stopAnimateSideCharacter(key: "SideCharacter2Stairwalk", sideCharacter: "Kimi")
//                        self.startAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Kimi")
//
//                        let rotate1 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(115)), z: 0, duration: 0.5) //Kimi looks toward center of floor 2
//                        let move1 = SCNAction.move(to: SCNVector3(-1, 5, 0.35), duration: 2)  //Kimi walks to center of floor 2
//                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(135)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Kimi looks to bottom of stairs
//                        let move2 = SCNAction.move(to: SCNVector3(1.2, 5, -1.8), duration: 2) //Kimi walks to the bottom of the stairs to level 1
//                        let rotate3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(270)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Kimi looks up the stairs
//                        let chapter8Letter5RotMovSeq5 = SCNAction.sequence([rotate1, move1, rotate2, move2, rotate3])
//                        self.charcterTwoIdle?.parent?.runAction(chapter8Letter5RotMovSeq5)
//
//                        //Kimi walks up the stairs
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5, execute: {
//                            self.startAnimateSideCharacter(key: "SideCharacter2Stairwalk", sideCharacter: "Kimi")
//                            self.charcterTwoIdle.parent?.runAction(SCNAction.move(to: SCNVector3(-3, 9.25, -1.75), duration: 3))
//
//                            //Ernie Level 1
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                                self.stopAnimateSideCharacter(key: "SideCharacter2Stairwalk", sideCharacter: "Kimi")
//                                self.startAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Kimi")
//
//                                let rotate3 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(430)), z: 0, duration: 0.5) //Kimi looks at the center of the frig
//                                let move2 = SCNAction.move(to: SCNVector3(-1, 9.25, -1), duration: 3)
//                                    //Kimi walks to the center of the frig
//                                let rotate4 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(365)), z: 0, duration: 0.5) //Kimi looks to the front of the frig
//                                let move3 = SCNAction.move(to: SCNVector3(-0.8, 9.25, 1.25), duration: 3)  //Kimi walks to the front of the frig
//                                let chapter8Letter5RotMovSeq6 = SCNAction.sequence([rotate3, move2, rotate4, move3])
//                                self.charcterTwoIdle?.parent?.runAction(chapter8Letter5RotMovSeq6)
//
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                                    self.stopAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Kimi")
//                                    self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Kimi")
//                                })
//                            })
//                        })
//
//                    })
                
                print("do chapter 8 stuff")
            case .Chapter9:
                self.patricia9!.isPaused = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 17, execute: {
                    self.stopWalkAnimation()
                })
                print("do chapter 9 stuff")
            case .Chapter10:
                print("do chapter 10 stuf")
                print("move floor for chapter five")
            default:
                break
            }
            
            //Finish
            //----------------------------------------------------
        //MARK: Chapter Finish
        case .chapterFinished:
            
            print("Reached the end of the chapter")
            
            switch currentChapter {
            case .Chapter1:
                print("end sequence for chapter one")
            case .Chapter2:
                print("end sequence for chapter two")
            case .Chapter3:
                print("end sequence for chapter three")
            case .Chapter4:
                print("end sequence for chapter four")
            case .Chapter5:
                print("end sequence for chapter five")
            case .Chapter6:
                print("end sequence for chapter six")
            case .Chapter7:
                print("end sequence for chapter seven")
                print("Ursa walks to her parents")
            case .Chapter8:
                print("end sequence for chapter eight")
            case .Chapter9:
                print("end sequence for chapter nine")
            case .Chapter10:
                print("end sequence for chapter ten")
            default:
                break
            }
        }
    }
}
