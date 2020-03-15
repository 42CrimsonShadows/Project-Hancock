import UIKit
import SceneKit
import ARKit
import AVFoundation

//
//  StopWalk.swift
//  Hancock
//
//  Created by Chris Ross on 2/5/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import Foundation

extension ViewController{
    func stopWalkAnimation() {
        switch gameProgress {
            //----------------------------------------------------
        //MARK: Letter 1
        case .toLetter1:
            switch true {
            case chapterTen:
                print("stopwalk chapter 10 stuff")
            case chapterNine:
                print("stopwalk chapter 9 stuff")
            case chapterEight:
                //FIXME: chapter 8 letter 1
                self.startTransitionAnimation(key: "MainCharacterIdle")
                self.stopTransitionAnimation(key: "MainCharacterStandup")
                
                //TODO: add letter l intro
                //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                
                //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
                self.shatterLetterOne = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                //load first letter for activityView page
                self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                //play narration for the first audio instructions for the activity
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration5"]!, type: "mp3")
                })
                print("stopwalk chapter 8 stuff")
            case chapterSeven:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    
                    //wait 6 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterOne = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![0])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                        })
                    })
                })
                print("Ursa stops at mid-path")
            case chapterSix:
                print("stopwalk chapter 6 stuff")
            case chapterFive:
                print("Prepare to shatter letter 1")
                self.shatterLetterOne = true
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    //load first letter for activityView page
                    print("Loading activity \(chapterSelectedLetterArray![0])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration5"]!, type: "mp3")
                })
                
            case chapterFour:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //stopTransitionAnimation(key: "MainCharacterWalking")
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 1")
                    self.shatterLetterOne = true
                    //load first letter for activityView page
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                })
            case chapterThree:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro part 2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 22, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterOne = true
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2_1"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            //trasition to the activity page for the first letter
                            print("Loading activity \(chapterSelectedLetterArray![0])")
                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                            
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                        })
                    })
                })
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro part 2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2_1"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterOne = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![0])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                            
                            //wait 1 seconds for the activity page to load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                //play narration for the first audio instructions for the activity
                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                            })
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro part 2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration2"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterOne = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![0])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration3"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter2
            //----------------------------------------------------
        //MARK: Letter 2
        case .toLetter2:
            switch true {
            case chapterTen:
                print("stopwalk chapter 10 stuff")
            case chapterNine:
                print("stopwalk chapter 9 stuff")
            case chapterEight:
                //FIXME: chapter 8 letter 2
                
                //self.stopTransitionAnimation(key: "MainCharacterWalking")
                self.startTransitionAnimation(key: "MainCharacterIdle")
                //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration7"]!, type: "mp3")
                self.shatterLetterTwo = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
                    //load first letter for activityView page
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration8"]!, type: "mp3")
                })
                print("stopwalk chapter 8 stuff")
            case chapterSeven:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration8"]!, type: "mp3")
                    self.stopAnimateSideCharacter(key: "SideCharacter1Idle", sideCharacter: "Stanley")
                    self.startAnimateSideCharacter(key: "SideCharacter1Talking", sideCharacter: "Stanley")
                    
                    //wait 6 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 2")
                        self.shatterLetterTwo = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration9"]!, type: "mp3")
                        })
                    })
                })
                print("Ursa stops at Stanley")
            case chapterSix:
                print("stopwalk chapter 6 stuff")
            case chapterFive:
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    print("Prepare to shatter letter 2")
                    self.shatterLetterTwo = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![1])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                    
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration13"]!, type: "mp3")
                })
                
            case chapterFour:
                //transition the animation from walking to idle
                stopTransitionAnimation(key: "MainCharacterJogging")
                startTransitionAnimation(key: "MainCharacterIdle")
                //play narration for the second audio instructions for the activity
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                self.shatterLetterTwo = true
                //wait 10 seconds for the intro narration to finish
                DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                    //trasition to the activity page for the second letter
                    print("Loading activity \(chapterSelectedLetterArray![1])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                    
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration13"]!, type: "mp3")
                })
                
            case chapterThree:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopTransitionAnimation(key: "MainChracterSwimming")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterTwo = true
                        
                        self.stopTransitionAnimation(key: "MainChracterIdle")
                        self.startTransitionAnimation(key: "MainCharacterSwimming")
                        self.stopAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
                        self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
                        
                        //move to Ollie
                        let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
                        let chapter3Letter1RotationSeq = SCNAction.sequence([rotate1])
                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter1RotationSeq)
                        let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P2 to P1
                        let chapter3Letter2MoveSeq = SCNAction.sequence([move1])
                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter2MoveSeq)
                        
                        //move Quinn to Ollie
                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(79.606)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                        let chapter3Letter2RotationSeq2 = SCNAction.sequence([rotate2])
                        self.charcterTwoIdle?.parent?.runAction(chapter3Letter2RotationSeq2)
                        let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)  //P2 to P1
                        let chapter3Letter2MoveSeq2 = SCNAction.sequence([move2])
                        self.charcterTwoIdle?.parent?.runAction(chapter3Letter2MoveSeq2)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
                            self.stopTransitionAnimation(key: "MainChracterSwimming")
                            self.startTransitionAnimation(key: "MainCharacterIdle")
                            
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                            
                            //wait 1 seconds for the activity page to load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                                //trasition to the activity page for the first letter
                                print("Loading activity \(chapterSelectedLetterArray![1])")
                                self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                                
                                //play narration for the first audio instructions for the activity
                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration13"]!, type: "mp3")
                            })
                        })
                    })
                })
                
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterTwo = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![1])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    [weak self] in self?.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 2")
                        self?.shatterLetterTwo = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self?.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self?.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter3
            //----------------------------------------------------
        //MARK: Letter 3
        case .toLetter3:
            switch true {
            case chapterTen:
                print("stopwalk chapter 10 stuff")
            case chapterNine:
                print("stopwalk chapter 9 stuff")
            case chapterEight:
                //FIXME: chapter 8 letter 3
                
                self.startTransitionAnimation(key: "MainCharacterIdle")
                //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                self.shatterLetterThree = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //load first letter for activityView page
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration14"]!, type: "mp3")
                })
                print("stopwalk chapter 8 stuff")
            case chapterSeven:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration12"]!, type: "mp3")
                    
                    //wait 9 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
                        print("Prepare to shatter letter 3")
                        self.shatterLetterThree = true
                        
                        self.startAnimateSideCharacter(key: "SideCharacter2Talking", sideCharacter: "Vivian")
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration13"]!, type: "mp3")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
                            //trasition to the activity page for the first letter
                            print("Loading activity \(chapterSelectedLetterArray![2])")
                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                            
                            //wait 1 seconds for the activity page to load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                //play narration for the first audio instructions for the activity
                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration14"]!, type: "mp3")
                            })
                        })
                    })
                })
                print("Ursa stops at Vivian")
            case chapterSix:
                print("stopwalk chapter 6 stuff")
            case chapterFive:
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    print("Prepare to shatter letter 3")
                    self.shatterLetterThree = true
                    
                    print("Loading activity \(chapterSelectedLetterArray![2])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                    
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                })
                
            case chapterFour:
                stopTransitionAnimation(key: "MainCharacterJogging")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //wait 1 seconds for the activity page to load
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                    print("Prepare to shatter letter 3")
                    self.shatterLetterThree = true
                    
                    //wait 6 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                    })
                })
            case chapterThree:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopTransitionAnimation(key: "MainChracterSwimming")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    //play game intro part 2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
                        
                        print("Set up trigger for after activityView")
                        self.shatterLetterThree = true
                        
                        self.stopTransitionAnimation(key: "MainChracterIdle")
                        self.startTransitionAnimation(key: "MainCharacterSwimming")
                        
                        //move to Ollie
                        let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
                        let chapter3Letter3RotationSeq = SCNAction.sequence([rotate1])
                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter3RotationSeq)
                        let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P1 to P2
                        let chapter3Letter3MoveSeq = SCNAction.sequence([move1])
                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter3MoveSeq)
                        
                        //move Simon to Ollie
                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(79.606)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 3)
                        let chapter3Letter3RotationSeq2 = SCNAction.sequence([rotate2])
                        self.charcterThreeIdle?.parent?.runAction(chapter3Letter3RotationSeq2)
                        let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)  //P1 to P2
                        let chapter3Letter3MoveSeq2 = SCNAction.sequence([move2])
                        self.charcterThreeIdle?.parent?.runAction(chapter3Letter3MoveSeq2)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
                            self.stopTransitionAnimation(key: "MainChracterSwimming")
                            self.startTransitionAnimation(key: "MainCharacterIdle")
                            
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                            
                            //wait 1 seconds for the activity page to load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                                //trasition to the activity page for the first letter
                                print("Loading activity \(chapterSelectedLetterArray![2])")
                                self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                                
                                //play narration for the first audio instructions for the activity
                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                            })
                        })
                    })
                })
                
                
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterThree = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![2])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration18"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 3")
                        self.shatterLetterThree = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter4
            //----------------------------------------------------
        //MARK: Letter 4
        case .toLetter4:
            switch true {
            case chapterTen:
                print("stopwalk chapter 10 stuff")
            case chapterNine:
                print("stopwalk chapter 9 stuff")
            case chapterEight:
                //FIXME: chapter 8 letter 4
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration22"]!, type: "mp3")
                    
                    self.shatterLetterFour = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        //load first letter for activityView page
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration23"]!, type: "mp3")
                    })
                })
                
                print("stopwalk chapter 8 stuff")
            case chapterSeven:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro2 (segway into first letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration19"]!, type: "mp3")
                    
                    //Windsor starts talking
                    self.stopAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Windsor")
                    self.startAnimateSideCharacter(key: "SideCharacter3Talking", sideCharacter: "Windsor")
                    
                    //wait 9 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                        print("Prepare to shatter letter 4")
                        self.shatterLetterFour = true
                        
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration20"]!, type: "mp3")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
                            //trasition to the activity page for the first letter
                            print("Loading activity \(chapterSelectedLetterArray![3])")
                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                            
                            //wait 1 seconds for the activity page to load
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                //play narration for the first audio instructions for the activity
                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration21"]!, type: "mp3")
                            })
                        })
                    })
                })
                
                print("Ursa stops at Windsor")
                
            case chapterSix:
                print("stopwalk chapter 6 stuff")
            case chapterFive:
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration30"]!, type: "mp3")
                
                //look around for nails at teachers desk
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    print("Prepare to shatter letter 4")
                    self.shatterLetterFour = true
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration31"]!, type: "mp3")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                    })
                })
                
            case chapterFour:
                stopTransitionAnimation(key: "MainCharacterJogging")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //wait 1 seconds for the activity page to load
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration31"]!, type: "mp3")
                    print("Prepare to shatter letter 4")
                    self.shatterLetterFour = true
                    
                    //wait 6 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                    })
                })
                
            case chapterThree:
                //Jillian the Jellyfish
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.stopTransitionAnimation(key: "MainChracterSwimming")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration24"]!, type: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
                        
                        print("Set up trigger for after activityView")
                        self.shatterLetterFour = true
                        
                        //Gary touches Jillian
                        let ratationGary1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-173.658)), y: CGFloat(GLKMathDegreesToRadians(54.663)), z: CGFloat(GLKMathDegreesToRadians(-165.956)), duration: 1)
                        let moveGary1 = SCNAction.move(to: SCNVector3(-0.299,0.21,-0.435), duration: 1)
                        let moveToJillian = SCNAction.sequence([ratationGary1, moveGary1])
                        self.mainCharacterIdle?.parent?.runAction(moveToJillian)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            //Gary is shocked
                            //self.mainCharacterIdle.animationPlayer(forKey: "MainCharacterShocked")?.speed = 3.0
                            self.stopTransitionAnimation(key: "MainCharacterSwimming")
                            self.startTransitionAnimation(key: "MainCharacterShocked")
                            self.toggleAudioFXFile(file: "Electrocuted", type: "mp3", rate: 1)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                //Gary and Jillian move back away from each other
                                self.stopTransitionAnimation(key: "MainCharacterShocked")
                                self.startTransitionAnimation(key: "MainCharacterSwimming")
                                self.stopAnimateSideCharacter(key: "SideCharacter4Sleeping", sideCharacter: "Jillian")
                                self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                                //Gary move
                                let rotationGary2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-163.287)), y: CGFloat(GLKMathDegreesToRadians(27.438)), z: CGFloat(GLKMathDegreesToRadians(-146.911)), duration: 1)
                                let moveGary2 = SCNAction.move(to: SCNVector3(-0.246, 0.254, -0.371), duration: 1)
                                let moveAwayfromJillian = SCNAction.sequence([moveGary2, rotationGary2])
                                self.mainCharacterIdle?.parent?.runAction(moveAwayfromJillian)
                                //Jillian move
                                let moveJillian = SCNAction.move(to: SCNVector3(-0.396,0.198,-0.466), duration: 1)
                                let rotationJillian = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
                                let moveAwayfromGary = SCNAction.sequence([moveJillian, rotationJillian])
                                self.charcterFourIdle?.parent?.runAction(moveAwayfromGary)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration25"]!, type: "mp3")
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 25, execute: {
                                        //move to Gary to Top
                                        self.stopTransitionAnimation(key: "MainCharacterIdle")
                                        self.startTransitionAnimation(key: "MainCharacterSwimming")
                                        let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
                                        let chapter3Letter4RotationSeq = SCNAction.sequence([rotate1])
                                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter4RotationSeq)
                                        let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P1 to P2
                                        let chapter3Letter4MoveSeq = SCNAction.sequence([move1])
                                        self.mainCharacterIdle?.parent?.runAction(chapter3Letter4MoveSeq)
                                        
                                        //move Jillian to Top
                                        self.stopAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                                        self.startAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
                                        let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 3)
                                        let chapter3Letter4RotationSeq2 = SCNAction.sequence([rotate2])
                                        self.charcterFourIdle?.parent?.runAction(chapter3Letter4RotationSeq2)
                                        let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)
                                        let chapter3Letter4MoveSeq2 = SCNAction.sequence([move2])
                                        self.charcterFourIdle?.parent?.runAction(chapter3Letter4MoveSeq2)
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
                                            self.stopTransitionAnimation(key: "MainChracterSwimming")
                                            self.startTransitionAnimation(key: "MainCharacterIdle")
                                            self.stopAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
                                            self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                                            
                                            //play narration for the first audio instructions for the activity
                                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration26"]!, type: "mp3")
                                            
                                            //wait 1 seconds for the activity page to load
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                                                //trasition to the activity page for the first letter
                                                print("Loading activity \(chapterSelectedLetterArray![3])")
                                                self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                                                
                                                //play narration for the first audio instructions for the activity
                                                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration27"]!, type: "mp3")
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
                
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterFour = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![3])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration24"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration25"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                ///wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration24"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 4")
                        self.shatterLetterFour = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration25"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter5
            //----------------------------------------------------
        //MARK: Letter 5
        case .toLetter5:
            switch true {
            case chapterTen:
                print("stopwalk chapter 10 stuff")
            case chapterNine:
                print("stopwalk chapter 9 stuff")
            case chapterEight:
                //FIXME: chapter 8 letter 5
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //play instructions to touch Lionel the lemon
                toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration29"]!, type: "mp3") //can you tap the lemon?
                shatterLetterFive = true
                //Find and unhide the plate
                let plate =  mainFloor.childNode(withName: "Plate", recursively: true)
                plate!.isHidden = false
                
                print("stopwalk chapter 8 stuff")
            case chapterSeven:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play game intro (segway into letter activity)
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration30"]!, type: "mp3")
                    
                    self.stopAnimateSideCharacter(key: "SideCharacter4Talking", sideCharacter: "Isaac")
                    self.startAnimateSideCharacter(key: "SideCharacter4Talking", sideCharacter: "Isaac")
                    
                    print("Prepare to shatter letter 5")
                    self.shatterLetterFive = true
                    
                    //wait 12 seconds for game intro to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration31"]!, type: "mp3")
                        })
                    })
                })
                
                print("Trace the letter i to have Ursa climb over the log")
            case chapterSix:
                print("stopwalk chapter 6 stuff")
            case chapterFive:
                stopTransitionAnimation(key: "MainCharacterWalking")
            case chapterFour:
                stopTransitionAnimation(key: "MainCharacterJogging")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                //wait 1 seconds for the activity page to load
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //play narration for the first audio instructions for the activity
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration42"]!, type: "mp3")
                    print("Prepare to shatter letter 5")
                    self.shatterLetterFive = true
                    
                    //wait 6 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                        //trasition to the activity page for the fifth letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration43"]!, type: "mp3")
                    })
                })
                
            case chapterThree:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //convince Ollie to swimm
                    print("Prepare to shatter letter 1")
                    self.shatterLetterFive = true
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                    
                    //wait 3 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration33"]!, type: "mp3")
                    })
                })
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterFive = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![4])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration33"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                //wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration32"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 5")
                        self.shatterLetterFive = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration33"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .toLetter6
            //----------------------------------------------------
        //MARK: Letter 6
        case .toLetter6:
            switch true {
            case chapterTen:
                print("stopwalk chapter 10 stuff")
            case chapterNine:
                print("stopwalk chapter 9 stuff")
            case chapterEight:
                print("stopwalk chapter 8 stuff")
            case chapterSeven:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)

                //play game intro (segway into letter activity)
                self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration36"]!, type: "mp3")
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                startTransitionAnimation(key: "MainCharacterIdle")
                    
                //rotate Tyler to look at Ursa
                self.charcterFiveIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-60)), z: 0, duration: 1))
                
                //start tylers talking animation
                self.stopAnimateSideCharacter(key: "SideCharacter5Fishing", sideCharacter: "Tyler")
                self.startAnimateSideCharacter(key: "SideCharacter5Talking", sideCharacter: "Tyler")
                
                print("Prepare to shatter letter 6")
                self.shatterLetterSix = true
                
                //wait 12 seconds for game intro to finish
                DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
                    //trasition to the activity page for the sixth letter
                    print("Loading activity \(chapterSelectedLetterArray![5])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration37"]!, type: "mp3")
                    })
                })
                
                print("Ursa stops at Tyler and he tells her to follow him")
                
            case chapterSix:
                print("stopwalk chapter 6 stuff")
            case chapterFive:
                stopTransitionAnimation(key: "MainCharacterWalking")
            case chapterFour:
                stopTransitionAnimation(key: "MainCharacterWalking")
            case chapterThree:
                stopTransitionAnimation(key: "MainCharacterWalking")
            case chapterTwo:
                print("skip stopping the skate animation")
                //wait 1 seconds (small pause)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 2")
                    self.shatterLetterSix = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![5])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        //play narration for the first audio instructions for the activity
                        self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration44"]!, type: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            //play narration for the first audio instructions for the activity
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration45"]!, type: "mp3")
                        })
                    })
                })
            case chapterOne:
                //fade out the walking sound
                FXPlayer.setVolume(0, fadeDuration: 1)
                //stop playing the walking sound
                FXPlayer.stop()
                FXPlayer.setVolume(1, fadeDuration: 0)
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //wait 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration44"]!, type: "mp3")
                    //wait 4 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 6")
                        self.shatterLetterSix = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![5])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration45"]!, type: "mp3")
                        })
                    })
                })
            default:
                break
            }
            
            gameProgress = .chapterFinished
        //----------------------------------------------------
        case .chapterFinished:
            
            //finish chapter stuff
            print("Finish Chapter after animation stopped")
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            //                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish"]!, type: "mp3")
            //            })
            
            //TODO: trigger finishing event
        }
    }
}
