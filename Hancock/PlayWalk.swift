import UIKit
import SceneKit
import ARKit
import AVFoundation

//
//  Playwalk.swift
//  Hancock
//
//  Created by Chris Ross on 2/5/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import Foundation

extension ViewController {
    
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
                //animate the main character to rotate a bit on the y axis
                mainCharacterIdle?.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new chapter 1
                //animate the mainFloor node to move and stop when the translation is complete
                mainFloor.runAction(SCNAction.moveBy(x:0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation)
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
            case chapterSix:
                print("do chapter 6 stuff")
                
            case chapterSeven:
                
                //show the main character as idle
                startTransitionAnimation(key: "MainCharacterWalking")
                //play walk sound
                toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                //animate the main character to rotate a bit on the y axis
                mainCharacterIdle?.parent?.runAction(SCNAction.rotateBy(x: 0, y: 0.0, z: 0, duration: 1)) //new chapter 1
                //animate the mainFloor node to move and stop when the translation is complete
                //mainFloor.runAction(SCNAction.moveBy(x:0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation)
                mainFloor.runAction(SCNAction.move(to: SCNVector3(173, 0, -75), duration: 4), completionHandler: stopWalkAnimation)
                print("move floor for chapter seven, letter 1")
                print("Ursa walks a little bit down the path")
                
            case chapterEight:
                //FIXME: 8 letter 1
                
                //self.stopTransitionAnimation(key: "MainCharacterLaying")
                self.startTransitionAnimationOnce(key: "MainCharacterStandup")
                //play transition to letter l
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                    self.mainCharacterIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-15)), z: 0, duration: 0.5), completionHandler: self.stopWalkAnimation)
                })
                print("do chapter 8 stuff")
                
            case chapterNine:
                print("do chapter 9 stuff")
                
            case chapterTen:
                print("do chapter 10 stuf")
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
                    self.stopWalkAnimation()
                })
                
                //Z
                
                print("move floor for chapter five")
            case chapterSix:
                print("do chapter 6 stuff")
            case chapterSeven:
                //show the main character as walking
                stopTransitionAnimation(key: "MainCharacterShouting")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //play walk sound
                toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                //animate the mainFloor node to move and stop when the translation is complete
                mainFloor.runAction(SCNAction.move(to: SCNVector3(148, 0, -50), duration: 6), completionHandler: stopWalkAnimation)
                print("move floor for chapter seven, letter 2")
                print("Ursa was to Stanley")
                
            case chapterEight:
                //FIXME: 8 letter 2
                
                //show the main character as walking
                stopTransitionAnimation(key: "MainCharacterCheering")
                startTransitionAnimation(key: "MainCharacterWalking")

                let move1 = SCNAction.move(to: SCNVector3(-0.55, 9.25, 1), duration: 4)  //to yogi the yogurt
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(40)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //look at yogi
                let chapter8Letter2RotMovSeq = SCNAction.sequence([move1, rotate1])
                mainCharacterIdle?.parent?.runAction((chapter8Letter2RotMovSeq), completionHandler: stopWalkAnimation)
                
                print("do chapter 8 stuff")
            case chapterNine:
                print("do chapter 9 stuff")
            case chapterTen:
                print("do chapter 10 stuf")
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
                //let rotate2 = SCNAction.rotateBy(x: 0, y: -1.75, z: 0, duration: 1)
                let rotate2 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)) , z: 0, duration: 1)
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
                
                //TODO: Chapter 5 - ADD touches and raytracing to select Yarn
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //move the main character to the first letter
                    self.stopWalkAnimation()
                })
                
                //Y
                
                print("move floor for chapter five")
            case chapterSix:
                print("do chapter 6 stuff")
            case chapterSeven:
                
                //show the main character as idle
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                
                //play walk sound
                toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                //animate the mainFloor node to move and stop when the translation is complete
                //mainFloor.runAction(SCNAction.moveBy(x:0, y: 0, z: -0.2, duration: 2), completionHandler: stopWalkAnimation)
                mainFloor.runAction(SCNAction.move(to: SCNVector3(86, 0, -40), duration: 8), completionHandler: stopWalkAnimation)
                print("move floor for chapter seven, letter 3")
                print("Ursa walks to Vivian")
                
            case chapterEight:
                //FIXME: 8 letter 3
                
                //show the main character as walking
                startTransitionAnimation(key: "MainCharacterWalking")
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration13"]!, type: "mp3")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(200)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) // lionel turns around
                let move1 = SCNAction.move(to: SCNVector3(-1.2, 9.25, -0.8), duration: 2)  //to heads to back of fridge
                let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(242)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //look at left wall
                let move2 = SCNAction.move(to: SCNVector3(-3, 9.25, -1.75), duration: 2)  //to heads to top of stairs
                let rotate3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(95)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Lionel looks down stairs
                
                let chapter8Letter3RotMovSeq1 = SCNAction.sequence([rotate1, move1, rotate2, move2, rotate3])
                mainCharacterIdle?.parent?.runAction((chapter8Letter3RotMovSeq1))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5, execute: {
                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
                    
                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 2)) //Lionel heads down to level 2
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.startTransitionAnimation(key: "MainCharacterWalking")
                        let rotate4 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //looks forward
                        let move4 = SCNAction.move(to: SCNVector3(1.1, 5, -0.78), duration: 2)  //Heads forward
                        let rotate5 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-50)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //Lionel looks at Kimi
                        
                        let chapter8Letter3RotMovSeq2 = SCNAction.sequence([rotate4, move4, rotate5])
                        self.mainCharacterIdle?.parent?.runAction((chapter8Letter3RotMovSeq2), completionHandler: self.stopWalkAnimation)
                    })
                })
                
                print("do chapter 8 stuff")
            case chapterNine:
                print("do chapter 9 stuff")
            case chapterTen:
                print("do chapter 10 stuf")
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
                let rotate1 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(0)), z: 0, duration: 1)
                let rotate2 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-90)), z: 0, duration: 1)
                let rotate3 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 7)
                let rotate4 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(90)), z: 0, duration: 1)
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
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //move the main character to the first letter
                    self.stopWalkAnimation()
                })
                //X
                
                print("move floor for chapter five")
            case chapterSix:
                print("do chapter 6 stuff")
            case chapterSeven:
                //show the main character as idle
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //play walk sound
                toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                    //move the main character to the first letter
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                })
                print("move floor for chapter seven, letter 4")
                print("Ursa walks to Windsor")
                
            case chapterEight:
                //FIXME: 8 letter 4
                
                //show the main character as walking
                startTransitionAnimation(key: "MainCharacterWalking")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(33)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) // lionel turns toward right wall
                let move1 = SCNAction.move(to: SCNVector3(3, 5, 2), duration: 3)  //Lionel heads to stairs
                let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //looks down the stairs
                
                let chapter8Letter4RotMovSeq = SCNAction.sequence([rotate1, move1, rotate2])
                mainCharacterIdle?.parent?.runAction((chapter8Letter4RotMovSeq))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5, execute: {
                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                    
                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 3)) //Lionel heads down to level 2
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimation(key: "MainCharacterIdle")
                        self.mainCharacterIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y:  CGFloat(GLKMathDegreesToRadians(-60)), z: 0, duration: 0.5), completionHandler: self.stopWalkAnimation)  //looks at Ernie
                    })
                })
                print("do chapter 8 stuff")
            case chapterNine:
                print("do chapter 9 stuff")
            case chapterTen:
                print("do chapter 10 stuf")
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
                //let rotate1 = SCNAction.rotateBy(x: 0, y: 0.6, z: 0, duration: 1)
                let rotate1 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(25)), z: 0, duration: 1)
                let rotate2 = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 1)
                let rotate3 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(55)), z: 0, duration: 1)
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
            case chapterSix:
                    print("do chapter 6 stuff")
            case chapterSeven:
                
                //show the main character as idle
                self.stopTransitionAnimation(key: "MainCharacterIdle")
                self.startTransitionAnimation(key: "MainCharacterWalking")
                
                //play walk sound
                self.toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                
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
                
            case chapterEight:
                //FIXME: 8 Final Walk
                
                //show the main character as walking
                //stopTransitionAnimation(key: "MainCharacterCheering")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                
                let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(33)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) // lionel turns toward right wall
                let move1 = SCNAction.move(to: SCNVector3(3, 5, 2), duration: 3)  //Lionel heads to stairs
                let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //looks down the stairs
                let move2 = SCNAction.move(to: SCNVector3(-1.1, 0.75, 2), duration: 2)  //to heads to top of stairs
                let rotate3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-60)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //lionel looks down stairs
                
                let chapter8Letter4RotMovSeq = SCNAction.sequence([rotate1, move1, rotate2, move2, rotate3])
                mainCharacterIdle?.parent?.runAction((chapter8Letter4RotMovSeq))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5, execute: {
                    //stopTransitionAnimation(key: "MainCharacterWalking")
                    self.startTransitionAnimation(key: "MainCharacterStairwalk")
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                    
                    self.mainCharacterIdle.parent?.runAction(SCNAction.move(to: SCNVector3(1.1, 5, -2.1), duration: 3)) //Lionel heads down to level 2
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        //stopTransitionAnimation(key: "MainCharacterStairwalk")
                        self.startTransitionAnimation(key: "MainCharacterIdle")
                        self.mainCharacterIdle.parent?.runAction(SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5), completionHandler: self.stopWalkAnimation)  //looks at Ernie
                    })
                })
                
                print("do chapter 8 stuff")
            case chapterNine:
                print("do chapter 9 stuff")
            case chapterTen:
                print("do chapter 10 stuf")
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5, execute: {
                    //Hannah stop dancing and Idle till narration done
                    [weak self] in self?.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration42"]!, type: "mp3")
                    self?.charcterFiveIdle.parent?.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(-135)), z: 0, duration: 0.5))
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
                        
                        //                        let hannahRotate1 = SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 1)
                        let hannahRotate1 = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(45)), z: 0, duration: 1)
                        let hannahMove1 = SCNAction.move(to: SCNVector3(x: 21.5,y: 1.1,z: -11.2), duration: 2)
                        let hannahMove2 = SCNAction.move(to: SCNVector3(x: 19.75,y: 1.7,z: -0.65), duration: 4)
                        let hannahMove3 = SCNAction.move(to: SCNVector3(x: 21.4,y: 1.4,z: 4.7), duration: 4)
                        
                        let hannahLetter6MoveSeq = SCNAction.sequence([hannahRotate1, hannahMove1, hannahMove2, hannahMove3])
                        self?.charcterFiveIdle.parent?.runAction(hannahLetter6MoveSeq)
                        
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
            case chapterSix:
                print("do chapter 6 stuff")
            case chapterSeven:
                
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration35"]!, type: "mp3") //10 sec long
                
                //show the main character as walking
                stopTransitionAnimation(key: "MainCharacterIdle")
                startTransitionAnimation(key: "MainCharacterWalking")
                
                //play walk sound
                toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                
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
                
            case chapterEight:
                print("do chapter 8 stuff")
            case chapterNine:
                print("do chapter 9 stuff")
            case chapterTen:
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
            case chapterSix:
                print("end sequence for chapter six")
            case chapterSeven:
                print("end sequence for chapter seven")
                print("Ursa walks to her parents")
            case chapterEight:
                print("end sequence for chapter eight")
            case chapterNine:
                print("end sequence for chapter nine")
            case chapterTen:
                print("end sequence for chapter ten")
            default:
                break
            }
        }
    }
}
