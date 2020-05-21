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
                switch currentChapter {
                    case .Chapter10:
                        print("Nothing to shatter for this chapter")
                    case .Chapter9:
                        print("Nothing to shatter for this chapter")
                    case .Chapter8:
                        
                        workItem2 = DispatchWorkItem{
                            self.resetGame()
                        }
                        workItem1 = DispatchWorkItem{
                            //play the final narration
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration37"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem1!)
                        print("Nothing to shatter for this chapter")
                    case .Chapter7:
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Finish1"]!, fileExtension: "mp3")
                        
                        self.stopAnimateSideCharacter(key: "SideCharacter5Talking", sideCharacter: "Tyler")
                        self.startAnimateSideCharacter(key: "SideCharacter5Walking", sideCharacter: "Tyler")
                        
                        workItem5 = DispatchWorkItem{
                            self.resetGame()
                        }
                        workItem4 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterWalking")
                            self.startTransitionAnimation(key: "MainCharacterIdle")
                            //Final narration
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Finish2"]!, fileExtension: "mp3")
                            
                            //wait while finaldialog plays
                            DispatchQueue.main.asyncAfter(deadline: .now() + 14, execute: self.workItem5!)
                        }
                        workItem3 = DispatchWorkItem{
                            //show the main character as idle
                            self.stopTransitionAnimation(key: "MainCharacterIdle")
                            self.startTransitionAnimation(key: "MainCharacterWalking")
                            
                            //play walk sound
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["WalkSound"]!, fileExtension: "wav", rate: 0.5)
                            
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
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            //stop tyler and start idle animation
                                self.stopAnimateSideCharacter(key: "SideCharacter5Walking", sideCharacter: "Tyler")
                                self.startAnimateSideCharacter(key: "SideCharacter5Standby", sideCharacter: "Tyler")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
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
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: self.workItem2!)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        print("Tyler brings Ursa back to her family")
                        
                    case .Chapter6:
                        //FIXME: chapter 6 letter 6
                        print("Nothing to shatter for this chapter")
                    case .Chapter5:
                        letterOne!.isPaused = false
                        animateLetterHide(fadeThis: letterOne!)
                        playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                    case .Chapter4:
                        letterOne!.isPaused = false
                        animateLetterHide(fadeThis: letterOne!)
                        playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                    case .Chapter3:
                        print("Nothing to shatter for this chapter")
                        print("not 6 letters in this chapter")
                        
                    case .Chapter2:
                        print("Nothing to shatter for this chapter")
                        print("Character cheers and does skateboard animation")
                        
                        workItem4 = DispatchWorkItem{
                            self.resetGame()
                        }
                        workItem3 = DispatchWorkItem{
                            //after the final animation, play the fishing narration
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["chapterFinish"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterU")
                            
                            //after the U trick play the walk to next letter animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //play game intro 1
                            self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                            //wait 3 seconds and then play animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                                
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                    case .Chapter1:
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
                        playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                    default:
                        break
                }
                //----------------------------------------------------
            //MARK: Letter 5
            case shatterLetterFive:
                switch currentChapter {
                    case .Chapter10:
                        workItem7 = DispatchWorkItem{
                            //go back to the menu
                            self.resetGame()
                        }
                        workItem6 = DispatchWorkItem{
                            //self.stopTransitionAnimation(key: "MainCharacterFlute")

                            //finn waves at the camera
                            self.startTransitionAnimation(key: "MainCharacterWaving")
                            //play final narration clip
                            //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: self.workItem7!)
                        }
                        workItem5 = DispatchWorkItem{
                            //play flute clip
                            //self.toggleAudioFXFile(file: chapterSelectedSoundDict!["Narration33"]!, type: "wav", rate: 1)
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
                        
                            DispatchQueue.main.asyncAfter(deadline: .now() + 14.7, execute: self.workItem6!)
                        }
                        workItem4 = DispatchWorkItem{
                            //self.stopTransitionAnimation(key: "MainCharacterPickup")
                            //play the flute playing animation
                            self.startTransitionAnimationOnce(key: "MainCharacterFlute")
                            //finn turns around to face the camera
                            self.mainCharacterIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(90)), z: 0, duration: 1))
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem5!)
                        }
                        workItem3 = DispatchWorkItem{
                            //about 1 second into the pickup animation turn on the flute
                            let flute = self.mainCharacterIdle.childNode(withName: "Flute", recursively: true)
                            flute!.isHidden = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.6, execute:self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterPickup")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem3!)
                            
                        }
                        workItem1 = DispatchWorkItem{
                            //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration31"]!, type: "mp3") //finns first choise was the right one
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        print("Nothing to shatter for this chapter")
                    case .Chapter9:
                        print("Nothing to shatter for this chapter")
                    case .Chapter8:
                        print("Nothing to shatter for this chapter")
                    case .Chapter7:
                        //Isaac goes back to what he was doing
                        self.stopAnimateSideCharacter(key: "SideCharacter4Talking", sideCharacter: "Isaac")
                        self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Isaac")
                        
                        workItem7 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem7!)
                        print("Ursa begins climbing over the log and finds Tyler by the stream")
                        
                    case .Chapter6:
                        //FIXME: chapter 6 letter 5
                        workItem1 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        
                        //wait 1 second for the screen to return from the activity screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter5:
                        print("Nothing to shatter for this chapter")
                        print("Xylophone gets put back together again")
                        
                    case .Chapter4:
                        //letter A completed, finishing chapter narration
                        print("Nothing to shatter for this chapter")
                        
                        workItem4 = DispatchWorkItem{
                            self.resetGame()
                        }
                        workItem3 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Finish2"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute:self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            let brace = self.charcterFiveIdle.childNode(withName: "Brace", recursively: true)
                            brace!.isHidden = false
                            
                            //play last narration for chapter
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Finish1"]!, fileExtension: "mp3")
                            //Keelie fixed Ashton
                            self.stopAnimateSideCharacter(key: "SideCharacter5Problem", sideCharacter: "Ashton")
                            self.startAnimateSideCharacter(key: "SideCharacter5Happy", sideCharacter: "Ashton")
                            
                            //show brace on Ashton
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem2!)
                                
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                    case .Chapter3:
                        //letter J completed, finishing narration
                        print("Nothing to shatter for this chapter")
                        
                        workItem3 = DispatchWorkItem{
                            self.resetGame()
                        }
                        workItem2 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["chapterFinish2"]!, fileExtension: "mp3")
                            self.stopAnimateSideCharacter(key: "SideCharacter1Idle5", sideCharacter: "Ollie")
                            self.startAnimateSideCharacter(key: "SideCharacter1Twirl", sideCharacter: "Ollie")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["chapterFinish1"]!, fileExtension: "mp3")
                            self.stopAnimateSideCharacter(key: "SideCharacter1Idle4", sideCharacter: "Ollie")
                            self.startAnimateSideCharacter(key: "SideCharacter1Idle5", sideCharacter: "Ollie")
                            
                            self.charcterOneIdle.parent?.runAction(SCNAction.rotateBy(x: CGFloat(GLKMathDegreesToRadians(-5)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 0.5))
                            let moveOllieFinish = SCNVector3(x: 0, y: 1.339, z: 0.168)
                            self.charcterOneIdle.parent?.runAction(SCNAction.move(to: moveOllieFinish, duration: 2))
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                    case .Chapter2:
                        print("Nothing to shatter for this chapter")
                        print("Character cheers and does skateboard animation")
                        
                        workItem3 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterD")
                            
                            //after the D trick play the walk to next letter animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 15.5, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //play game intro 1
                            self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                            //wait 3 seconds and then play animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                    case .Chapter1:
                        //drop Eric down from letter E
                        self.startAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
                        
                        workItem2 = DispatchWorkItem{
                            self.stopAnimateSideCharacter(key: "SideCharacter4Climb", sideCharacter: "Eric")
                            self.startAnimateSideCharacter(key: "SideCharacter4Dance1", sideCharacter: "Eric")
                            self.charcterFourIdle.parent?.position = SCNVector3(x: 19.5, y: 2, z: 7.5)
                            self.charcterFourIdle.parent?.eulerAngles = SCNVector3(x: 0, y: GLKMathDegreesToRadians(180), z: 0)
                        }
                        workItem1 = DispatchWorkItem{
                            self.letterFive!.isPaused = false
                            self.animateLetterHide(fadeThis: self.letterFive!)
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                            
                            //wait 5 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute:self.workItem2!)
                                
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 12.5, execute:self.workItem1!)
                    default:
                        break
                }
                //----------------------------------------------------
            //MARK: Letter 4
            case shatterLetterFour:
                switch currentChapter {
                    case .Chapter10:
                        let butterstick = self.mainCharacterIdle.childNode(withName: "ButterStick", recursively: true)
                        
                        workItem5 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterZambomba")
                            //start playwalk for letter 5
                            self.playWalkAnimation()
                        }
                        workItem4 = DispatchWorkItem{
                            //turn off the butterstick
                            butterstick!.isHidden = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem5!)
                        }
                        workItem3 = DispatchWorkItem{
                            //turn on the butterstick
                            butterstick!.isHidden = false
                            //play quill sound clip
                            //self.toggleAudioFXFile(file: chapterSelectedSoundDict!["Narration36"]!, type: "wav", rate: 1)
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Narration36"]!, fileExtension: "mp3")
                                    
                            DispatchQueue.main.asyncAfter(deadline: .now() + 8.5, execute:self.workItem4!)
                                    
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterZambomba")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration40"]!, type: "mp3") //Great Job
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration40"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                        print("Nothing to shatter for this chapter")
                    case .Chapter9:
                        //Patricia thanks Heidi after she tells him where Brennon is and flies off
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
                        
                        workItem1 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute:self.workItem1!)
                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
//                            self.playWalkAnimation()
//                        })
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter8:
                        //letter E completed, starting final sequence
                        print("Nothing to shatter for this chapter")
                        print("Ernie gets up and turns to Lionel and they cheer")
                        
                        self.startAnimateSideCharacter(key: "SideCharacter3Standup", sideCharacter: "Ernie")
                        
                        workItem2 = DispatchWorkItem{
                            //Ernie stops cheering and looks back toward camera
                            self.stopAnimateSideCharacter(key: "SideCharacter3Cheering", sideCharacter: "Ernie")
                            self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Ernie")
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            //Ernie turns to Lionel and they both cheer
                            self.stopAnimateSideCharacter(key: "SideCharacter3Standup", sideCharacter: "Ernie")
                            self.startAnimateSideCharacter(key: "SideCharacter3Cheering", sideCharacter: "Ernie")
                            self.charcterThreeIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(115)), z: 0, duration: 0.5))
                            
                            self.startTransitionAnimation(key: "MainCharacterCheering")
                            
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration27"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem1!)
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter7:
                        //Windsor goes back to what he was doing
                        self.stopAnimateSideCharacter(key: "SideCharacter3Talking", sideCharacter: "Windsor")
                        self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Windsor")
                        
                        //Ursa climbs the hill
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration29"]!, fileExtension: "mp3")
                        
                        workItem2 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                             //animate the main character to rotate a bit on the y axis
                             self.mainCharacterIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(100)), z: 0, duration: 1))
            
                             //wait 4 seconds and then play animation
                             DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem2!)
                                 
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                                                
                        print("Ursa climbs the slope and sees Isaac")
                        
                    case .Chapter6:
                        //FIXME: chapter 6 letter 4
                        workItem1 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        
                        //wait 1 second for the screen to return from the activity screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter5:
                        print("Nothing to shatter for this chapter")
                        print("Xylophone gets put back together again")
                        
                        //show empty Xylophone
                        let xylophone_4 = self.mainCharacterIdle.childNode(withName: "xylophone_4 reference", recursively: true)
                        xylophone_4!.isHidden = false
                        
                        //hide busted xylophone
                        let xylophone_3 = self.mainCharacterIdle.childNode(withName: "xylophone_3 reference", recursively: true)
                        xylophone_3!.isHidden = true
                        
                        //"xylophone back together"
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Finish1"]!, fileExtension: "mp3")
                        
                        workItem2 = DispatchWorkItem{
                            self.resetGame()
                        }
                        workItem1 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Finish2"]!, fileExtension: "mp3")
                            self.mainCharacterIdle?.parent?.runAction(SCNAction.move(to: SCNVector3(0 ,11.5 ,0), duration: 4))
                            self.mainCharacterIdle?.parent?.runAction(SCNAction.scale(to: 0.05, duration: 5))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 90, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem1!)
                        
                    case .Chapter4:
                        //letter M completed, starting letter A
                        print("Nothing to shatter for this chapter")
                        print("Keelie fixes Manny")
                        
                        workItem2 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration40"]!, fileExtension: "mp3")
                            self.stopAnimateSideCharacter(key: "SideCharacter4Problem", sideCharacter: "Manny")
                            self.startAnimateSideCharacter(key: "SideCharacter4Happy", sideCharacter: "Manny")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                    case .Chapter3:
                        //letter J completed, starting letter O
                        print("Nothing to shatter for this chapter")
                        
                        workItem3 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem2 = DispatchWorkItem{
                            self.stopAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                            self.startAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
                            //Jillian leaves
                            let rotateJillian = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                            let chapter3Letter4RotationJillian = SCNAction.sequence([rotateJillian])
                            self.charcterFourIdle?.parent?.runAction(chapter3Letter4RotationJillian)
                            
                            let moveJillian = SCNAction.move(to: SCNVector3(-0.369, 0.198, -0.445), duration: 8)  //P1 to P2
                            let chapter3Letter4MoveJillian = SCNAction.sequence([moveJillian])
                            self.charcterFourIdle?.parent?.runAction(chapter3Letter4MoveJillian)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                    case .Chapter2:
                        print("Nothing to shatter for this chapter")
                        print("Character cheers and does skateboard animation")
                        
                        workItem3 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem2 = DispatchWorkItem{
                            print("Starting MainCharacterC trick")
                            self.startTransitionAnimationOnce(key: "MainCharacterC")
                            
                            //after the C trick play the walk to next letter animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 13.5, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //play game intro 1
                            self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                            
                            //wait 3 seconds and then play animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                    case .Chapter1:
                        letterFour!.isPaused = false
                        animateLetterHide(fadeThis: letterFour!)
                        playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                        
                        //drop side Francine down from letter F
                        let rotateTo0 = SCNAction.rotateTo(x: 0, y: 3.5, z: 0, duration: 0.1)
                        let moveOut = SCNAction.moveBy(x:0, y: 0, z: -2.5, duration: 0.5)
                        let moveDown = SCNAction.moveBy(x:0, y: -2.4, z: -0.5, duration: 0.5)
                        let francineMoveSeq0 = SCNAction.sequence([rotateTo0, moveOut, moveDown])
                        self.charcterThreeIdle.parent?.runAction(francineMoveSeq0)
                        self.startAnimateSideCharacter(key: "SideCharacter3Jump", sideCharacter: "Francine")
                        
                        workItem4 = DispatchWorkItem{
                            self.stopAnimateSideCharacter(key: "SideCharacter3Walk", sideCharacter: "Francine")
                            self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Francine")
                        }
                        workItem3 = DispatchWorkItem{
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute:self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            self.stopAnimateSideCharacter(key: "SideCharacter3Walk", sideCharacter: "Francine")
                            self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Francine")
                            
                            //wait 5 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute:self.workItem1!)
                    default:
                        break
                }
                //----------------------------------------------------
            //MARK: Letter 3
            case shatterLetterThree:
                switch currentChapter {
                    case .Chapter10:
                        let mallet1 = self.mainCharacterIdle.childNode(withName: "XylophoneMallet1", recursively: true)
                        let mallet2 = self.mainCharacterIdle.childNode(withName: "XylophoneMallet2", recursively: true)
                        
                        workItem7 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterXylophone")
                            //start playwalk for letter two
                            self.playWalkAnimation()
                        }
                        workItem6 = DispatchWorkItem{
                            //about 22 seconds into the xylophone animation turn off the first mallet
                            mallet1!.isHidden = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute:self.workItem7!)
                        }
                        workItem5 = DispatchWorkItem{
                            //about 21 seconds into the xylophone animation turn off the second mallet
                            mallet2!.isHidden = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem6!)
                        }
                        workItem4 = DispatchWorkItem{
                            //about 1 second into the pickup animation turn on the second mallet
                             mallet2!.isHidden = false
                             //play quill sound clip
                            //self.toggleAudioFXFile(file: chapterSelectedSoundDict!["Narration35"]!, type: "wav", rate: 1)
                             self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Narration35"]!, fileExtension: "mp3")
                             DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute:self.workItem5!)
                        }
                        workItem3 = DispatchWorkItem{
                            //about 0.15 seconds into the pickup animation turn on the first mallet
                            mallet1!.isHidden = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.85, execute:self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterXylophone")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration39"]!, type: "mp3") //Great Job
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration39"]!, fileExtension: "mp3")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        print("Nothing to shatter for this chapter")
                    case .Chapter9:
                        //Patricia lands down by Nikki
                        self.patricia7!.isPaused = false
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration25"]!, fileExtension: "mp3")
                        
                        workItem1 = DispatchWorkItem{
                            self.patricia7!.isPaused = true
                            self.playWalkAnimation()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 12.4, execute:self.workItem1!)
                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 12.4, execute: {
//                            self.patricia7!.isPaused = true
//
//                            self.playWalkAnimation()
//                        })
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter8:
                        //letter k completed, starting letter e
                        print("Nothing to shatter for this chapter")
                        print("Kimi turns to Lionel and they cheer")
                        
                        workItem2 = DispatchWorkItem{
                            //Kimi stops cheering and looks back toward camera
                            self.stopAnimateSideCharacter(key: "SideCharacter2Cheering", sideCharacter: "Kimi")
                            self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Kimi")
                            self.charcterTwoIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(35)), z: 0, duration: 0.5))
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                          //Kimi turns to Lionel and they both cheer
                            self.charcterTwoIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(115)), z: 0, duration: 0.5))
                            self.startAnimateSideCharacter(key: "SideCharacter2Cheering", sideCharacter: "Kimi")
                            self.startTransitionAnimation(key: "MainCharacterCheering")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        print("Nothing to shatter for this chapter")
                    case .Chapter7:
                        //Vivian goes back to what she was doing
                        stopAnimateSideCharacter(key: "SideCharacter2Talking", sideCharacter: "Vivian")
                        startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Vivian")
                        
                        workItem1 = DispatchWorkItem{
                             self.playWalkAnimation()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                        print("You traced the letter V and Ursa has made it across the ravine")
                        
                    case .Chapter6:
                        //FIXME: chapter 6 letter 3
                        workItem1 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        
                        //wait 1 second for the screen to return from the activity screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter5:
                        print("Nothing to shatter for this chapter")
                        print("Xylophone gets Yarn for mallet")
                        //show mallet head
                        let malletHead = self.mainCharacterIdle.childNode(withName: "Head", recursively: true)
                        malletHead!.isHidden = false
                        
                        //"we now have all the yarn we need"
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration29"]!, fileExtension: "mp3")
                        
                        workItem1 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem1!)

                    case .Chapter4:
                        //letter W completed, starting letter M
                        print("Nothing to shatter for this chapter")
                        print("Keelie fixes Wallace")
                        
                        workItem2 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration29"]!, fileExtension: "mp3")
                                
                            //Keelie helps Velma
                            self.stopAnimateSideCharacter(key: "SideCharacter2Problem", sideCharacter: "Wallace")
                            self.startAnimateSideCharacter(key: "SideCharacter2Happy", sideCharacter: "Wallace")
                            
                            self.stopAnimateSideCharacter(key: "SideCharacter3Comforting", sideCharacter: "Winona")
                            self.startAnimateSideCharacter(key: "SideCharacter3Clapping", sideCharacter: "Winona")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                    case .Chapter3:
                        //letter S completed, starting letter J
                        print("Nothing to shatter for this chapter")
                        print("Ollie relaxes a little")
                        
                        workItem3 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem2 = DispatchWorkItem{
                            //Simon leaves
                            let rotateSimon = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-90)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 8)
                            let chapter3Letter3RotationSimon = SCNAction.sequence([rotateSimon])
                            self.charcterThreeIdle?.parent?.runAction(chapter3Letter3RotationSimon)
                            let moveSimon = SCNAction.move(to: SCNVector3(0.41, 0.23, 0.6), duration: 8)  //P2 to P1
                            let chapter3Letter3MoveSimon = SCNAction.sequence([moveSimon])
                            self.charcterThreeIdle?.parent?.runAction(chapter3Letter3MoveSimon)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute:self.workItem3!)
                                
                        }
                        workItem1 = DispatchWorkItem{
                          self.stopAnimateSideCharacter(key: "SideCharacter1Idle3", sideCharacter: "Ollie")
                            self.startAnimateSideCharacter(key: "SideCharacter1Idle4", sideCharacter: "Ollie")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration23"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 27, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                    case .Chapter2:
                        print("Nothing to shatter for this chapter")
                        print("Character cheers and does skateboard animation")
                        
                        workItem3 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterB")
                           //after the B trick play the walk to next letter animation
                           DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //play game intro 1
                            self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                            //wait 3 seconds and then play animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                    case .Chapter1:
                        letterThree!.isPaused = false
                        animateLetterHide(fadeThis: letterThree!)
                        playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                        
                        workItem3 = DispatchWorkItem{
                            //TO-DO: Fix Bone structure for Lin so that transitions of animations work correctly
                            //self.stopAnimateSideCharacter(key: "SideCharacter2Walking", sideCharacter: "Lin")
                            //self.startAnimateSideCharacter(key: "SideCharacter2Dancing", sideCharacter: "Lin")
                        }
                        workItem2 = DispatchWorkItem{
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //drop side Lin down from letter L
                            self.charcterTwoIdle.parent?.runAction(SCNAction.moveBy(x:0, y: -0.8, z: 0, duration: 0.5))
                            
                            //wait 5 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute:self.workItem1!)
                        
                    default:
                        break
                }
                //----------------------------------------------------
            //MARK: Letter 2
            case shatterLetterTwo:
                switch currentChapter {
                    case .Chapter10:
                        let quill = self.mainCharacterIdle.childNode(withName: "PanFlute", recursively: true)
                        
                        workItem8 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterPutBack")
                            //start playwalk for letter two
                            self.playWalkAnimation()
                        }
                        workItem7 = DispatchWorkItem{
                            quill!.isHidden = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3, execute:self.workItem8!)
                        }
                        workItem6 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterQuill")
                            self.startTransitionAnimationOnce(key: "MainCharacterPutBack")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.75, execute:self.workItem7!)
                        }
                        workItem5 = DispatchWorkItem{
                            //play quill sound clip
                            //self.toggleAudioFXFile(file: chapterSelectedSoundDict!["Narration34"]!, type: "wav", rate: 1)
                            self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Narration34"]!, fileExtension: "mp3")
                        
                            DispatchQueue.main.asyncAfter(deadline: .now() + 20.8, execute:self.workItem6!)
                        }
                        workItem4 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterPickup")
                            //play the Quill playing animation
                            self.startTransitionAnimationOnce(key: "MainCharacterQuill")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2, execute:self.workItem5!)
                        }
                        workItem3 = DispatchWorkItem{
                            //about 1 second into the pickup animation turn on the flute
                            quill!.isHidden = false
                                
                            //DispatchQueue.main.asyncAfter(deadline: .now() + 2.6, execute: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterPickup")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration38"]!, type: "mp3") //Great Job
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration38"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                        print("Nothing to shatter for this chapter")
                    case .Chapter9:
                        //Patricia flies down to Ryan and asks where Brennon is
                        self.patricia3!.isHidden = false
                        self.patricia3!.isPaused = false
                        self.patricia2!.isHidden = true
                        
                        workItem2 = DispatchWorkItem{
                            //Patricia idles on the track while talking to Ryan
                            self.patricia4!.isHidden = false
                            self.patricia4!.isPaused = false
                            self.patricia3!.isHidden = true
                            
                            //start playwalk for letter two
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration17"]!, fileExtension: "mp3")
                                                
                            DispatchQueue.main.asyncAfter(deadline: .now() + 9.8, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter8:
                        //letter y completed, starting letter k
                        print("Nothing to shatter for this chapter")
                        print("Yogi turns to Lionel and they cheer")
                        
                        workItem2 = DispatchWorkItem{
                            //yogi stops cheering and looks back toward camera
                            self.startAnimateSideCharacter(key: "SideCharacter1Idle", sideCharacter: "Yogi")
                            self.charcterOneIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-36)), z: 0, duration: 0.5))
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            //yogi turns to Lionel and they both cheer
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
                            
                            self.charcterOneIdle.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-125)), z: 0, duration: 0.5))
                            
                            self.startAnimateSideCharacter(key: "SideCharacter1Cheering", sideCharacter: "Yogi")
                            self.startTransitionAnimation(key: "MainCharacterCheering")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                        print("Nothing to shatter for this chapter")
                    case .Chapter7:
                        //stanley goes back to what he was doing
                        self.stopAnimateSideCharacter(key: "SideCharacter1Talking", sideCharacter: "Stanley")
                        self.startAnimateSideCharacter(key: "SideCharacter1Idle", sideCharacter: "Stanley")
                        
                        workItem1 = DispatchWorkItem{
                            //animate the main character to rotate a bit on the y axis
                            self.mainCharacterIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(100)), z: 0, duration: 0.5))
                            self.playWalkAnimation()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                        print("Ursa is on her way down the trail to vivian")
                        
                    case .Chapter6:
                        //FIXME: chapter 6 letter 2
                        workItem1 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        
                        //wait 1 second for the screen to return from the activity screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter5:
                        print("Nothing to shatter for this chapter")
                        print("Xylophone gets zebra stripes")
                        
                        //show empty Xylophone
                        let xylophone_3 = self.mainCharacterIdle.childNode(withName: "xylophone_3 reference", recursively: true)
                        xylophone_3!.isHidden = false
                        
                        //hide busted xylophone
                        let xylophone_2 = self.mainCharacterIdle.childNode(withName: "xylophone_2 reference", recursively: true)
                        xylophone_2!.isHidden = true
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
                        
                        workItem1 = DispatchWorkItem{
                         self.playWalkAnimation()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute:self.workItem1!)
                        
                    case .Chapter4:
                        print("Nothing to shatter for this chapter")
                        print("Keelie fixes Velma")
                        
                        workItem2 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                           self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
                            
                            //Keelie helps Velma
                            self.stopAnimateSideCharacter(key: "SideCharacter1Problem", sideCharacter: "Velma")
                            self.startAnimateSideCharacter(key: "SideCharacter1Happy", sideCharacter: "Velma")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                    case .Chapter3:
                        //letter Q completed, starting letter S
                        print("Nothing to shatter for this chapter")
                        print("Ollie relaxes a little")
                        
                        workItem4 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem3 = DispatchWorkItem{
                            //Quinn leaves
                            let rotateQuinn = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                            let chapter3Letter2RotationQuinn = SCNAction.sequence([rotateQuinn])
                            self.charcterTwoIdle?.parent?.runAction(chapter3Letter2RotationQuinn)
                            let moveQuinn = SCNAction.move(to: SCNVector3(-0.226, 0.05, 0.237), duration: 8)  //P1 to P2
                            let chapter3Letter2MoveQuinn = SCNAction.sequence([moveQuinn])
                            self.charcterTwoIdle?.parent?.runAction(chapter3Letter2MoveQuinn)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            self.stopAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
                            self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            self.stopAnimateSideCharacter(key: "SideCharacter1Idle2", sideCharacter: "Ollie")
                            self.startAnimateSideCharacter(key: "SideCharacter1Idle3", sideCharacter: "Ollie")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
                            self.stopAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
                            self.startAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                    case .Chapter2:
                        print("Nothing to shatter for this chapter")
                        print("Character cheers and does skateboard animation")
                        
                        workItem3 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterR")
                            
                            //after the R trick play the walk to next letter animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //play game intro 1
                            self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                            //wait 3 seconds and then play animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                    case .Chapter1:
                        letterTwo!.isPaused = false
                        animateLetterHide(fadeThis: letterTwo!)
                        playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                        
                        workItem3 = DispatchWorkItem{
                            self.stopAnimateSideCharacter(key: "SideCharacter1Walking", sideCharacter: "Terry")
                            self.startAnimateSideCharacter(key: "SideCharacter1Waving", sideCharacter: "Terry")
                        }
                        workItem2 = DispatchWorkItem{
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //drop side terry down from the top of the letter T
                            self.charcterOneIdle.parent?.runAction(SCNAction.moveBy(x:0, y: -4.1, z: 0.2, duration: 1))
                            
                            //wait 5 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute:self.workItem1!)

                    default:
                        break
                }
                //----------------------------------------------------
            //MARK: Letter 1
            case shatterLetterOne:
                switch currentChapter {
                    case .Chapter10:
                        let flute = self.mainCharacterIdle.childNode(withName: "Flute", recursively: true)
                        
                        workItem8 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterPickup")
                            self.stopTransitionAnimation(key: "MainCharacterPutBack")
                            //start playwalk for letter two
                            self.playWalkAnimation()
                        }
                        workItem7 = DispatchWorkItem{
                            flute!.isHidden = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.25, execute:self.workItem8!)
                                
                        }
                        workItem6 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterFlute")
                            self.startTransitionAnimationOnce(key: "MainCharacterPutBack")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.75, execute:self.workItem7!)
                        }
                        workItem5 = DispatchWorkItem{
                            //play flute clip
                                //self.toggleAudioFXFile(file: chapterSelectedSoundDict!["Narration33"]!, type: "wav", rate: 1)
                                self.playAudio(type: .Effect, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
                            
                                DispatchQueue.main.asyncAfter(deadline: .now() + 14.7, execute:self.workItem6!)
                        }
                        workItem4 = DispatchWorkItem{
                            //self.stopTransitionAnimation(key: "MainCharacterPickup")
                            //play the flute playing animation
                            self.startTransitionAnimationOnce(key: "MainCharacterFlute")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem5!)
                        }
                        workItem3 = DispatchWorkItem{
                            //about 1 second into the pickup animation turn on the flute
                            flute!.isHidden = false
                                
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.6, execute:self.workItem4!)
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterPickup")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration37"]!, type: "mp3") //Great Job
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration37"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                        print("Nothing to shatter for this chapter")
                    case .Chapter9:
                        
                        workItem3 = DispatchWorkItem{
                            //start playwalk for letter two
                            self.playWalkAnimation()
                        }
                        workItem2 = DispatchWorkItem{
                            //Brennon goes to the Balloon stand
                            let move1 = SCNAction.move(to: SCNVector3(-9.32, 0.25, -8), duration: 4)
                            let rotate2 = SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(90)), z: 0, duration: 0.5)
                            let move2 = SCNAction.move(to: SCNVector3(-7,  0.25, -8), duration: 2)
                            let brennonMoveSeq = SCNAction.sequence([move1, rotate2, move2])
                            
                            self.charcterOneIdle.childNode(withName: "Brennon", recursively: true)!.runAction(brennonMoveSeq)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.4, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration9"]!, fileExtension: "mp3")
                            
                            //Patricia flies into the air to get the balloon
                            self.patricia1!.isPaused = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter8:
                        self.startTransitionAnimation(key: "MainCharacterStandup")
                        self.stopTransitionAnimation(key: "MainCharacterLaying")
                        
                        workItem2 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            self.mainCharacterIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-15)), z: 0, duration: 0.5))
                            self.stopTransitionAnimation(key: "MainCharacterStandup")
                            self.startTransitionAnimation(key: "MainCharacterCheering")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration6"]!, fileExtension: "mp3")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem1!)
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter7:
                        print("Ursa has calls out for her parents and continues down the path")
                        
                        workItem2 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            self.stopTransitionAnimation(key: "MainCharacterIdle")
                            self.startTransitionAnimation(key: "MainCharacterShouting")
                            
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration7"]!, fileExtension: "mp3")
                            //wait 3 seconds and then play animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                    case .Chapter6:
                        //FIXME: chapter 6 letter 1
                        workItem1 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        //wait 1 second for the screen to return from the activity screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                        print("Nothing to shatter for this chapter")
                    case .Chapter5:
                        print("Nothing to shatter for this chapter")
                        print("Xylophone get nail pegs")
                        
                        //show empty Xylophone
                        let xylophone_2 = self.mainCharacterIdle.childNode(withName: "xylophone_2 reference", recursively: true)
                        xylophone_2!.isHidden = false
                        
                        //hide busted xylophone
                        let xylophone_1 = self.mainCharacterIdle.childNode(withName: "xylophone_1 reference", recursively: true)
                        xylophone_1!.isHidden = true
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
                        
                        workItem1 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute:self.workItem1!)
                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
//                            self.playWalkAnimation()
//                        })
                    case .Chapter4:
                        print("Nothing to shatter for this chapter")
                        print("Character gets coat on")
                        //letterOne!.isPaused = false
                        //animateLetterHide(fadeThis: letterOne!)
                        //playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                        
                        workItem2 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            let coat = self.mainCharacterIdle.childNode(withName: "Coat", recursively: true)
                            coat?.isHidden = false
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)

                    case .Chapter3:
                        //letter G completed, starting letter Q
                        print("Nothing to shatter for this chapter")
                        print("Ollie relaxes a little")
                        
                        workItem2 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem1 = DispatchWorkItem{
                            self.stopAnimateSideCharacter(key: "SideCharacter1Idle1", sideCharacter: "Ollie")
                            self.startAnimateSideCharacter(key: "SideCharacter1Idle2", sideCharacter: "Ollie")
                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration10"]!, fileExtension: "mp3")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                    case .Chapter2:
                        print("Nothing to shatter for this chapter")
                        print("Character cheers and does skateboard animation")
                        
                        workItem3 = DispatchWorkItem{
                            self.playWalkAnimation()
                        }
                        workItem2 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterP")
                            //after the P trick play the walk to next letter animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute:self.workItem3!)
                        }
                        workItem1 = DispatchWorkItem{
                            self.startTransitionAnimationOnce(key: "MainCharacterCheering")
                            //wait 3 seconds and then play animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem2!)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem1!)
                        
                    case .Chapter1:
                        letterOne!.isPaused = false
                        animateLetterHide(fadeThis: letterOne!)
                        playAudio(type: .Effect, file: chapterSelectedSoundDict!["Shatter1"]!, fileExtension: "wav", rate: 1.5)
                    default:
                        break
                }
                
            default:
                break
        }
    }
}
