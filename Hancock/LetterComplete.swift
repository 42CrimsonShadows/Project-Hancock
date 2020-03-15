import UIKit
import SceneKit
import ARKit
import AVFoundation

//
//  Lettercomplete.swift
//  Hancock
//
//  Created by Chris Ross on 2/5/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import Foundation

extension ViewController{
    func playShatterAnimation() {
        switch true {
            //----------------------------------------------------
        //MARK: Letter 6
        case shatterLetterSix:
            switch true{
            case chapterTen:
                print("Nothing to shatter for this chapter")
            case chapterNine:
                print("Nothing to shatter for this chapter")
            case chapterEight:
                print("Nothing to shatter for this chapter")
            case chapterSeven:
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish1"]!, type: "mp3")
                
                self.stopAnimateSideCharacter(key: "SideCharacter5Talking", sideCharacter: "Tyler")
                self.startAnimateSideCharacter(key: "SideCharacter5Walking", sideCharacter: "Tyler")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:{
                    //move tyler to Ursa's parents (14 second walk)
                    let rotateTyler1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-24)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //turn toward stream path
                    let moveTyler1 = SCNAction.move(to: SCNVector3(144, 0, -5), duration: 2)  //move toward the stream path
                    let rotateTyler2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(11)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //turn toward the rocks ion the stream
                    let moveTyler2 = SCNAction.move(to: SCNVector3(146, 1.75, 6.5), duration: 3)  //move onto the rocks
                    let rotateTyler4 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(30)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1) //turn toward Ursa's parents
                    let moveTyler3 = SCNAction.move(to: SCNVector3(174, 0, 50), duration: 6)  //move to the Ursa's parents
                    let rotateTyler5 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-150)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1) //turn around to face Ursa as she meets her parents
                    let TylerMoveSequence = SCNAction.sequence([rotateTyler1, moveTyler1, rotateTyler2, moveTyler2, rotateTyler4, moveTyler3, rotateTyler5])
                    self.charcterFiveIdle?.parent?.runAction(TylerMoveSequence)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute:{
                        //stop tyler and start idle animation
                        self.stopAnimateSideCharacter(key: "SideCharacter5Walking", sideCharacter: "Tyler")
                        self.startAnimateSideCharacter(key: "SideCharacter5Standby", sideCharacter: "Tyler")
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:{
                        
                        //show the main character as idle
                        self.stopTransitionAnimation(key: "MainCharacterIdle")
                        self.startTransitionAnimation(key: "MainCharacterWalking")
                        
                        //play walk sound
                        self.toggleAudioFXFile(file: chapterSelectedSoundDict!["WalkSound"]!, type: "wav", rate: 0.5)
                        
                        //rotate Ursa
                        let rotateUrsa1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(60)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 5) //hold rotate while moving
                        let rotateUrsa2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //look toward the rock
                        let rotateUrsa3 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 5) //hold rotate while moving to the rock
                        let rotateUrsa4 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(10)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5) //look toward Ursa's parents
                        let chapter7FinalRotateSeq = SCNAction.sequence([rotateUrsa1, rotateUrsa2, rotateUrsa3, rotateUrsa4])
                        self.mainCharacterIdle?.parent?.runAction(chapter7FinalRotateSeq)
                        
                        //play Ursa's move sequence
                        let moveScene1 = SCNAction.move(to: SCNVector3(-138 ,-1.1 ,-12.5), duration: 5) //to the stream rocks
                        let moveScene2 = SCNAction.move(to: SCNVector3(-151 ,0 ,-28), duration: 5) //move to the stream rock
                        let moveScene3 = SCNAction.move(to: SCNVector3(-152.5 ,0 ,-50), duration: 5) //move to Ursa's parents
                        let chapter7FinalMoveSeq = SCNAction.sequence([moveScene1, moveScene2, moveScene3])
                        self.mainFloor.runAction(chapter7FinalMoveSeq)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
                            self.stopTransitionAnimation(key: "MainCharacterWalking")
                            self.startTransitionAnimation(key: "MainCharacterIdle")
                            //Final narration
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish2"]!, type: "mp3")
                            
                            //wait while finaldialog plays
                            DispatchQueue.main.asyncAfter(deadline: .now() + 14, execute: {
                                self.resetGame()
                            })
                        })
                    })
                })
                print("Tyler brings Ursa back to her family")
                
            case chapterSix:
                print("Nothing to shatter for this chapter")
            case chapterFive:
                letterOne!.isPaused = false
                animateLetterHide(fadeThis: letterOne!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            case chapterFour:
                letterOne!.isPaused = false
                animateLetterHide(fadeThis: letterOne!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            case chapterThree:
                print("Nothing to shatter for this chapter")
                print("not 6 letters in this chapter")
                
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterU")
                        
                        //after the U trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                            //after the final animation, play the fishing narration
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish"]!, type: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
                                self.resetGame()
                            })
                        })
                    })
                })
            case chapterOne:
                //francine stop idle /dancing
                self.stopAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Francine")
                self.startAnimateSideCharacter(key: "SideCharacter3Dance2", sideCharacter: "Francine")
                
                //maincharacter start dancing
                self.startTransitionAnimation(key: "MainCharacterDance")
                
                //hanna stop surprise/start dancing
                self.stopAnimateSideCharacter(key: "SideCharacter5Surprise", sideCharacter: "Hannah")
                self.startAnimateSideCharacter(key: "SideCharacter5Dance", sideCharacter: "Hannah")
                
                //terry stop waving and start dancing
                self.stopAnimateSideCharacter(key: "SideCharacter1Waving", sideCharacter: "Terry")
                self.startAnimateSideCharacter(key: "SideCharacter1Dancing", sideCharacter: "Terry")
                
                letterSix!.isPaused = false
                animateLetterHide(fadeThis: letterSix!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 5
        case shatterLetterFive:
            switch true{
            case chapterTen:
                print("Nothing to shatter for this chapter")
            case chapterNine:
                print("Nothing to shatter for this chapter")
            case chapterEight:
                //FIXME: chapter 8 letter 5
                
                print("Nothing to shatter for this chapter")
            case chapterSeven:
                //Isaac goes back to what he was doing
                self.stopAnimateSideCharacter(key: "SideCharacter4Talking", sideCharacter: "Isaac")
                self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Isaac")
                
                //wait 4 seconds and then play animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playWalkAnimation()
                })
                
                print("Ursa begins climbing over the log and finds Tyler by the stream")
                
            case chapterSix:
                print("Nothing to shatter for this chapter")
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone gets put back together again")
                
            case chapterFour:
                //letter A completed, finishing chapter narration
                print("Nothing to shatter for this chapter")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish1"]!, type: "mp3")
                    //Keelie fixed Ashton
                    self.stopAnimateSideCharacter(key: "SideCharacter5Problem", sideCharacter: "Ashton")
                    self.startAnimateSideCharacter(key: "SideCharacter5Happy", sideCharacter: "Ashton")
                    
                    //show brace on Ashton
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        let brace = self.charcterFiveIdle.childNode(withName: "Brace", recursively: true)
                        brace!.isHidden = false
                        
                        //play last narration for chapter
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish2"]!, type: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                                self.resetGame()
                            })
                        })
                    })
                })
            case chapterThree:
                //letter J completed, finishing narration
                print("Nothing to shatter for this chapter")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish1"]!, type: "mp3")
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle4", sideCharacter: "Ollie")
                    self.startAnimateSideCharacter(key: "SideCharacter1Idle5", sideCharacter: "Ollie")
                    
                    self.charcterOneIdle.parent?.runAction(SCNAction.rotateBy(x: CGFloat(GLKMathDegreesToRadians(-5)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5))
                    let moveOllieFinish = SCNVector3(x: 0, y: 1.339, z: 0.168)
                    self.charcterOneIdle.parent?.runAction(SCNAction.move(to: moveOllieFinish, duration: 2))
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish2"]!, type: "mp3")
                        self.stopAnimateSideCharacter(key: "SideCharacter1Idle5", sideCharacter: "Ollie")
                        self.startAnimateSideCharacter(key: "SideCharacter1Twirl", sideCharacter: "Ollie")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                            self.resetGame()
                        })
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterD")
                        
                        //after the D trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15.5, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
                //drop Eric down from letter E
                self.startAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
                //play for 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.5, execute: {
                    //set new position for Eric's transform where the next animation will begin
                    //self.charcterFourIdle.parent?.position = SCNVector3(6.25, 1.2, -4.7)
                    
                    //play Eric through a sequence of movements so he turns and then walks to the Letter H
                    //                    let endSpot = SCNVector3(x: 19.5, y: 2.5, z: 7.5)
                    //                    let move1 = SCNAction.move(to: endSpot, duration: 10)
                    //                    let rotate2 = SCNAction.rotateBy(x: 0.0, y: 1.75, z: 0.0, duration: 0.5)
                    //                    let ericMoveSeq = SCNAction.sequence([move1, rotate2])
                    //                    self.charcterFourIdle.parent?.runAction(ericMoveSeq)
                    
                    //play side character animation
                    //                    self.stopAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
                    //                    self.startAnimateSideCharacter(key: "SideCharacter4Walk", sideCharacter: "Eric")
                    
                    self.letterFive!.isPaused = false
                    self.animateLetterHide(fadeThis: self.letterFive!)
                    self.toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
                    
                    //wait 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                        self.stopAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
                        self.startAnimateSideCharacter(key: "SideCharacter4Dance1", sideCharacter: "Eric")
                        self.charcterFourIdle.parent?.position = SCNVector3(x: 19.5, y: 2, z: 7.5)
                        self.charcterFourIdle.parent?.eulerAngles = SCNVector3(x: 0, y: GLKMathDegreesToRadians(180), z: 0)
                    })
                })
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 4
        case shatterLetterFour:
            switch true{
            case chapterTen:
                print("Nothing to shatter for this chapter")
            case chapterNine:
                print("Nothing to shatter for this chapter")
            case chapterEight:
                //FIXME: chapter 8 letter 4
                
                //letter E completed, starting final sequence
                print("Nothing to shatter for this chapter")
                print("Ernie gets up and turns to Lionel and they cheer")
                
                self.stopAnimateSideCharacter(key: "SideCharacter3Laying", sideCharacter: "Ernie")
                self.startAnimateSideCharacter(key: "SideCharacter3Standup", sideCharacter: "Ernie")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    //Kimi turns to Lionel and they both cheer
                    self.charcterThreeIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(115)), z: 0, duration: 0.5))
                    self.stopAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Ernie")
                    self.startAnimateSideCharacter(key: "SideCharacter3Cheering", sideCharacter: "Ernie")
                    self.startTransitionAnimation(key: "MainCharacterCheering")
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                        //Kimi stops cheering and looks back toward camera
                        self.stopAnimateSideCharacter(key: "SideCharacter3Cheering", sideCharacter: "Ernie")
                        self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Ernie")
                        self.charcterThreeIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(35)), z: 0, duration: 0.5))
                        self.playWalkAnimation()
                    })
                })
                
                print("Nothing to shatter for this chapter")
            case chapterSeven:
                //Windsor goes back to what he was doing
                self.stopAnimateSideCharacter(key: "SideCharacter3Talking", sideCharacter: "Windsor")
                self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Windsor")
                
                //Ursa climbs the hill
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration29"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //animate the main character to rotate a bit on the y axis
                    self.mainCharacterIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(100)), z: 0, duration: 1))
   
                    //wait 4 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.playWalkAnimation()
                    })
                })
                
                print("Ursa climbs the slope and sees Isaac")
                
            case chapterSix:
                print("Nothing to shatter for this chapter")
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone gets put back together again")
                
                //show empty Xylophone
                let xylophone_4 = self.mainCharacterIdle.childNode(withName: "xylophone_4 reference", recursively: true)
                xylophone_4!.isHidden = false
                
                //hide busted xylophone
                let xylophone_3 = self.mainCharacterIdle.childNode(withName: "xylophone_3 reference", recursively: true)
                xylophone_3!.isHidden = true
                
                //"xylophone back together"
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish1"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Finish2"]!, type: "mp3")
                    
                    self.mainCharacterIdle?.parent?.runAction(SCNAction.move(to: SCNVector3(0 ,11.5 ,0), duration: 4))
                    self.mainCharacterIdle?.parent?.runAction(SCNAction.scale(to: 0.05, duration: 5))
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 90, execute: {
                        self.resetGame()
                    })
                })
            case chapterFour:
                //letter M completed, starting letter A
                print("Nothing to shatter for this chapter")
                print("Keelie fixes Manny")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration40"]!, type: "mp3")
                    
                    self.stopAnimateSideCharacter(key: "SideCharacter4Problem", sideCharacter: "Manny")
                    self.startAnimateSideCharacter(key: "SideCharacter4Happy", sideCharacter: "Manny")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterThree:
                //letter J completed, starting letter O
                print("Nothing to shatter for this chapter")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration31"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
                        self.stopAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                        self.startAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
                        //Jillian leaves
                        let rotateJillian = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                        let chapter3Letter4RotationJillian = SCNAction.sequence([rotateJillian])
                        self.charcterFourIdle?.parent?.runAction(chapter3Letter4RotationJillian)
                        
                        let moveJillian = SCNAction.move(to: SCNVector3(-0.369, 0.198, -0.445), duration: 8)  //P1 to P2
                        let chapter3Letter4MoveJillian = SCNAction.sequence([moveJillian])
                        self.charcterFourIdle?.parent?.runAction(chapter3Letter4MoveJillian)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        print("Starting MainCharacterC trick")
                        self.startTransitionAnimationOnce(key: "MainCharacterC")
                        
                        //after the C trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 13.5, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
                letterFour!.isPaused = false
                animateLetterHide(fadeThis: letterFour!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
                
                //drop side Francine down from letter F
                let rotateTo0 = SCNAction.rotateTo(x: 0, y: 3.5, z: 0, duration: 0.1)
                let moveOut = SCNAction.moveBy(x:0, y: 0, z: -2.5, duration: 0.5)
                let moveDown = SCNAction.moveBy(x:0, y: -2.4, z: -0.5, duration: 0.5)
                let francineMoveSeq0 = SCNAction.sequence([rotateTo0, moveOut, moveDown])
                self.charcterThreeIdle.parent?.runAction(francineMoveSeq0)
                self.startAnimateSideCharacter(key: "SideCharacter3Jump", sideCharacter: "Francine")
                
                //play for 2.5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter3Jump", sideCharacter: "Francine")
                    self.startAnimateSideCharacter(key: "SideCharacter3Walk", sideCharacter: "Francine")
                    
                    //Francine walks to Indy after the jump - Left turn and walk for 0.5 seconds
                    //let rotate1 = SCNAction.rotateBy(x: 0.0, y: 1.5, z: 0.0, duration: 0.5)
                    let rotate1 = SCNAction.rotateBy(x: 0.0, y: CGFloat(GLKMathDegreesToRadians(90)), z: 0.0, duration: 0.5)
                    let endSpot1 = SCNVector3(x: 2, y: 1.3, z: 9.0)
                    let move1 = SCNAction.move(to: endSpot1, duration: 1.5)
                    let francineMoveSeq1 = SCNAction.sequence([rotate1, move1])
                    self.charcterThreeIdle.parent?.runAction(francineMoveSeq1)
                    
                    //play for 3 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.1, execute: {
                        self.stopAnimateSideCharacter(key: "SideCharacter3Walk", sideCharacter: "Francine")
                        self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Francine")
                        
                        //wait 5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //play Francine through a sequence of movements so he turns and then walks to the Letter H
                            //let rotate2 = SCNAction.rotateBy(x: 0.0, y: -2.9, z: 0.0, duration: 0.5)
                            let rotate2 = SCNAction.rotateBy(x: 0.0, y: CGFloat(GLKMathDegreesToRadians(170)), z: 0.0, duration: 0.5)
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
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 3
        case shatterLetterThree:
            switch true{
            case chapterTen:
                print("Nothing to shatter for this chapter")
            case chapterNine:
                print("Nothing to shatter for this chapter")
            case chapterEight:
                //FIXME: chapter 8 letter 3
                
                //letter k completed, starting letter e
                print("Nothing to shatter for this chapter")
                print("Kimi turns to Lionel and they cheer")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //Kimi turns to Lionel and they both cheer
                    self.charcterTwoIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(115)), z: 0, duration: 0.5))
                    self.stopAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Kimi")
                    self.startAnimateSideCharacter(key: "SideCharacter2Cheering", sideCharacter: "Kimi")
                    self.startTransitionAnimation(key: "MainCharacterCheering")
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                        //Kimi stops cheering and looks back toward camera
                        self.stopAnimateSideCharacter(key: "SideCharacter2Cheering", sideCharacter: "Kimi")
                        self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Kimi")
                        self.charcterTwoIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(35)), z: 0, duration: 0.5))
                        self.playWalkAnimation()
                    })
                })
                print("Nothing to shatter for this chapter")
            case chapterSeven:
                //Vivian goes back to what she was doing
                stopAnimateSideCharacter(key: "SideCharacter2Talking", sideCharacter: "Vivian")
                startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Vivian")
                
                //jump straight to crossing the ravine
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.playWalkAnimation()
                })
                
                print("You traced the letter V and Ursa has made it across the ravine")
                
            case chapterSix:
                print("Nothing to shatter for this chapter")
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone gets Yarn for mallet")
                //show mallet head
                let malletHead = self.mainCharacterIdle.childNode(withName: "Head", recursively: true)
                malletHead!.isHidden = false
                
                //"we now have all the yarn we need"
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration29"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    self.playWalkAnimation()
                })
            case chapterFour:
                //letter W completed, starting letter M
                print("Nothing to shatter for this chapter")
                print("Keelie fixes Wallace")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration29"]!, type: "mp3")
                    
                    //Keelie helps Velma
                    self.stopAnimateSideCharacter(key: "SideCharacter2Problem", sideCharacter: "Wallace")
                    self.startAnimateSideCharacter(key: "SideCharacter2Happy", sideCharacter: "Wallace")
                    
                    self.stopAnimateSideCharacter(key: "SideCharacter3Comforting", sideCharacter: "Winona")
                    self.startAnimateSideCharacter(key: "SideCharacter3Clapping", sideCharacter: "Winona")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterThree:
                //letter S completed, starting letter J
                print("Nothing to shatter for this chapter")
                print("Ollie relaxes a little")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle3", sideCharacter: "Ollie")
                    self.startAnimateSideCharacter(key: "SideCharacter1Idle4", sideCharacter: "Ollie")
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration23"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 27, execute: {
                        //Simon leaves
                        let rotateSimon = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 8)
                        let chapter3Letter3RotationSimon = SCNAction.sequence([rotateSimon])
                        self.charcterThreeIdle?.parent?.runAction(chapter3Letter3RotationSimon)
                        let moveSimon = SCNAction.move(to: SCNVector3(0.41, 0.23, 0.6), duration: 8)  //P2 to P1
                        let chapter3Letter3MoveSimon = SCNAction.sequence([moveSimon])
                        self.charcterThreeIdle?.parent?.runAction(chapter3Letter3MoveSimon)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterB")
                        
                        //after the B trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
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
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 2
        case shatterLetterTwo:
            switch true{
            case chapterTen:
                print("Nothing to shatter for this chapter")
            case chapterNine:
                print("Nothing to shatter for this chapter")
            case chapterEight:
                //FIXME: chapter 8 letter 2
                //letter y completed, starting letter k
                print("Nothing to shatter for this chapter")
                print("Yogi turns to Lionel and they cheer")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //yogi turns to Lionel and they both cheer
                    self.charcterOneIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-125)), z: 0, duration: 0.5))
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle", sideCharacter: "Yogi")
                    self.startAnimateSideCharacter(key: "SideCharacter1Cheering", sideCharacter: "Yogi")
                    self.startTransitionAnimation(key: "MainCharacterCheering")
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                        //yogi stops cheering and looks back toward camera
                        self.stopAnimateSideCharacter(key: "SideCharacter1Cheering", sideCharacter: "Yogi")
                        self.startAnimateSideCharacter(key: "SideCharacter1Idle", sideCharacter: "Yogi")
                        self.charcterOneIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-36)), z: 0, duration: 0.5))
                        self.playWalkAnimation()
                    })
                })
                print("Nothing to shatter for this chapter")
            case chapterSeven:
                //stanley goes back to what he was doing
                self.stopAnimateSideCharacter(key: "SideCharacter1Talking", sideCharacter: "Stanley")
                self.startAnimateSideCharacter(key: "SideCharacter1Idle", sideCharacter: "Stanley")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //animate the main character to rotate a bit on the y axis
                    self.mainCharacterIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(100)), z: 0, duration: 0.5))
                    
                    self.playWalkAnimation()
                })
                print("Ursa is on her way down the trail to vivian")
                
            case chapterSix:
                print("Nothing to shatter for this chapter")
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone gets zebra stripes")
                
                //show empty Xylophone
                let xylophone_3 = self.mainCharacterIdle.childNode(withName: "xylophone_3 reference", recursively: true)
                xylophone_3!.isHidden = false
                
                //hide busted xylophone
                let xylophone_2 = self.mainCharacterIdle.childNode(withName: "xylophone_2 reference", recursively: true)
                xylophone_2!.isHidden = true
                
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                    self.playWalkAnimation()
                })
                
            case chapterFour:
                print("Nothing to shatter for this chapter")
                print("Keelie fixes Velma")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                    
                    //Keelie helps Velma
                    self.stopAnimateSideCharacter(key: "SideCharacter1Problem", sideCharacter: "Velma")
                    self.startAnimateSideCharacter(key: "SideCharacter1Happy", sideCharacter: "Velma")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        self.playWalkAnimation()
                    })
                })
                
            case chapterThree:
                //letter Q completed, starting letter S
                print("Nothing to shatter for this chapter")
                print("Ollie relaxes a little")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle2", sideCharacter: "Ollie")
                    self.startAnimateSideCharacter(key: "SideCharacter1Idle3", sideCharacter: "Ollie")
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                    self.stopAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
                    self.startAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                        self.stopAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
                        self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                            //Quinn leaves
                            let rotateQuinn = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                            let chapter3Letter2RotationQuinn = SCNAction.sequence([rotateQuinn])
                            self.charcterTwoIdle?.parent?.runAction(chapter3Letter2RotationQuinn)
                            let moveQuinn = SCNAction.move(to: SCNVector3(-0.226, 0.05, 0.237), duration: 8)  //P1 to P2
                            let chapter3Letter2MoveQuinn = SCNAction.sequence([moveQuinn])
                            self.charcterTwoIdle?.parent?.runAction(chapter3Letter2MoveQuinn)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                self.playWalkAnimation()
                            })
                        })
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro 1
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterR")
                        
                        //after the R trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
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
            default:
                break
            }
            //----------------------------------------------------
        //MARK: Letter 1
        case shatterLetterOne:
            switch true{
            case chapterTen:
                print("Nothing to shatter for this chapter")
            case chapterNine:
                print("Nothing to shatter for this chapter")
            case chapterEight:
                //FIXME: chapter 8 letter 1
                self.startTransitionAnimation(key: "MainCharacterCheering")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.playWalkAnimation()
                })

                print("Nothing to shatter for this chapter")
            case chapterSeven:
                print("Ursa has calls out for her parents and continues down the path")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopTransitionAnimation(key: "MainCharacterIdle")
                    self.startTransitionAnimation(key: "MainCharacterShouting")
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration7"]!, type: "mp3")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterSix:
                print("Nothing to shatter for this chapter")
            case chapterFive:
                print("Nothing to shatter for this chapter")
                print("Xylophone get nail pegs")
                
                //show empty Xylophone
                let xylophone_2 = self.mainCharacterIdle.childNode(withName: "xylophone_2 reference", recursively: true)
                xylophone_2!.isHidden = false
                
                //hide busted xylophone
                let xylophone_1 = self.mainCharacterIdle.childNode(withName: "xylophone_1 reference", recursively: true)
                xylophone_1!.isHidden = true
                
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
                    self.playWalkAnimation()
                })
            case chapterFour:
                print("Nothing to shatter for this chapter")
                print("Character gets coat on")
                //letterOne!.isPaused = false
                //animateLetterHide(fadeThis: letterOne!)
                //toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    let coat = self.mainCharacterIdle.childNode(withName: "Coat", recursively: true)
                    coat?.isHidden = false
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterThree:
                //letter G completed, starting letter Q
                print("Nothing to shatter for this chapter")
                print("Ollie relaxes a little")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle1", sideCharacter: "Ollie")
                    self.startAnimateSideCharacter(key: "SideCharacter1Idle2", sideCharacter: "Ollie")
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration10"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
                        self.playWalkAnimation()
                    })
                })
            case chapterTwo:
                print("Nothing to shatter for this chapter")
                print("Character cheers and does skateboard animation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                    //wait 3 seconds and then play animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.startTransitionAnimationOnce(key: "MainCharacterP")
                        
                        //after the P trick play the walk to next letter animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
                            self.playWalkAnimation()
                        })
                    })
                })
            case chapterOne:
                letterOne!.isPaused = false
                animateLetterHide(fadeThis: letterOne!)
                toggleAudioFXFile(file: chapterSelectedSoundDict!["Shatter1"]!, type: "wav", rate: 1.5)
            default:
                break
            }
            
        default:
            break
        }
    }
}
