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
            switch currentChapter {
            case .Chapter10:
                stopTransitionAnimation(key: "MainCharacterWalking")
                
                //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration4"]!, type: "mp3")
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration4"]!, fileExtension: "mp3")
                
                workItem1 = DispatchWorkItem{
                    //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
                    self.shatterLetterOne = true
                    
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    //play narration for the first audio instructions for the activity
                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration5"]!, type: "mp3")
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration5"]!, fileExtension: "mp3")
                    
                    print("stopwalk chapter 10 stuff")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                    //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
//                    self.shatterLetterOne = true
//
//                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//                    //play narration for the first audio instructions for the activity
//                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration5"]!, type: "mp3")
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration5"]!, fileExtension: "mp3")
//
//                    print("stopwalk chapter 10 stuff")
//                })
                print("stopwalk chapter 10 stuff")
            case .Chapter9:
                //letter l intro
                playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration4"]!, fileExtension: "mp3")
                
                // Light on Patricia
                let lightNode = self.createSpotLightNode(intensity: 20, spotInnerAngle: 0, spotOuterAngle: 45)
                lightNode.position = SCNVector3Make(0, 10, 0)
                lightNode.eulerAngles = SCNVector3Make(-.pi/2, 0, 0)
                lightItem1 = DispatchWorkItem{
                    lightNode.removeFromParentNode()
                }
                self.mainCharacterIdle.childNode(withName: "Patricia", recursively: false)!.addChildNode(lightNode)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.lightItem1!)
                //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
                self.shatterLetterOne = true
                
                workItem1 = DispatchWorkItem{
                    self.mainCharacterIdle.isHidden = true
                        self.patricia1?.isHidden = false
                        //load first letter for activityView page
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration5"]!, fileExtension: "mp3")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
//                    self.mainCharacterIdle.isHidden = true
//                    self.patricia1?.isHidden = false
//                    //load first letter for activityView page
//                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//                    //play narration for the first audio instructions for the activity
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration5"]!, fileExtension: "mp3")
//                })
                print("stopwalk chapter 9 stuff")
            case .Chapter8:
                //self.stopTransitionAnimation(key: "MainCharacterStandup")
                //self.startTransitionAnimation(key: "MainCharacterIdle")
                
                //letter l intro
                playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
                
                //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
                self.shatterLetterOne = true
                
                workItem1 = DispatchWorkItem{
                    //load first letter for activityView page
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration4"]!, fileExtension: "mp3")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                    //load first letter for activityView page
//                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//                    //play narration for the first audio instructions for the activity
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration4"]!, fileExtension: "mp3")
//                })
                print("stopwalk chapter 8 stuff")
            case .Chapter7:
                fadeoutWalkingSound()
                
                stopTransitionAnimation(key: "MainCharacterWalking")
                startTransitionAnimation(key: "MainCharacterIdle")
                
                workItem3 = DispatchWorkItem{
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
                }
                workItem2 = DispatchWorkItem{
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 1")
                    self.shatterLetterOne = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![0])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //play game intro2 (segway into first letter activity)
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
                    
                    //wait 6 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute:self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
                //wait 1 seconds (small pause)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //play game intro2 (segway into first letter activity)
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
//
//                    //wait 6 seconds for game intro2 to finish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 1")
//                        self.shatterLetterOne = true
//
//                        //trasition to the activity page for the first letter
//                        print("Loading activity \(chapterSelectedLetterArray![0])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
//                        })
//                    })
//                })
                print("Ursa stops at mid-path")
            case .Chapter6:
                //FIXME: chapter 6 letter 1
                self.shatterLetterOne = true
                
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
                
                workItem1 = DispatchWorkItem{
                    //load first letter for activityView page
                    print("Loading activity \(chapterSelectedLetterArray![0])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration4"]!, fileExtension: "mp3")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: workItem1!)
                
                print("stopwalk chapter 6 stuff")
            case .Chapter5:
                print("Prepare to shatter letter 1")
                self.shatterLetterOne = true
                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration4"]!, fileExtension: "mp3")
                
                workItem1 = DispatchWorkItem{
                    //load first letter for activityView page
                    print("Loading activity \(chapterSelectedLetterArray![0])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration5"]!, fileExtension: "mp3")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                    //load first letter for activityView page
//                    print("Loading activity \(chapterSelectedLetterArray![0])")
//                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//                    //play narration for the first audio instructions for the activity
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration5"]!, fileExtension: "mp3")
//                })
                
            case .Chapter4:
                workItem1 = DispatchWorkItem{
                    //stopTransitionAnimation(key: "MainCharacterWalking")
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 1")
                    self.shatterLetterOne = true
                    //load first letter for activityView page
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //stopTransitionAnimation(key: "MainCharacterWalking")
//                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                    print("Prepare to shatter letter 1")
//                    self.shatterLetterOne = true
//                    //load first letter for activityView page
//                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//                    //play narration for the first audio instructions for the activity
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
//                })
            case .Chapter3:
                workItem3 = DispatchWorkItem{
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![0])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")

                }
                workItem2 = DispatchWorkItem{
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 1")
                    self.shatterLetterOne = true
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2_1"]!, fileExtension: "mp3")
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:self.workItem3!)

                }
                workItem1 = DispatchWorkItem{
                    //play game intro part 2 (segway into first letter activity)
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 22, execute:self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //play game intro part 2 (segway into first letter activity)
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
//
//                    //wait 5 seconds for game intro2 to finish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 22, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 1")
//                        self.shatterLetterOne = true
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2_1"]!, fileExtension: "mp3")
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                            //trasition to the activity page for the first letter
//                            print("Loading activity \(chapterSelectedLetterArray![0])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
//                        })
//                    })
//                })
            case .Chapter2:
                print("skip stopping the skate animation")
                workItem4 = DispatchWorkItem{
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration4"]!, fileExtension: "mp3")
                }
                workItem3 = DispatchWorkItem{
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem4!)
                }
                workItem2 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 1")
                        self.shatterLetterOne = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![0])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //play game intro part 2 (segway into first letter activity)
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2_1"]!, fileExtension: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
                //wait 1 seconds (small pause)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //play game intro part 2 (segway into first letter activity)
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2_1"]!, fileExtension: "mp3")
//
//                    //wait 5 seconds for game intro2 to finish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 1")
//                        self.shatterLetterOne = true
//
//                        //trasition to the activity page for the first letter
//                        print("Loading activity \(chapterSelectedLetterArray![0])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
//
//                            //wait 1 seconds for the activity page to load
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration4"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
//                })
            case .Chapter1:
                fadeoutWalkingSound()
                stopTransitionAnimation(key: "MainCharacterWalking")
                workItem3 = DispatchWorkItem{
                    //play narration for the first audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
                }
                workItem2 = DispatchWorkItem{
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    print("Prepare to shatter letter 1")
                    self.shatterLetterOne = true
                    
                    //trasition to the activity page for the first letter
                    print("Loading activity \(chapterSelectedLetterArray![0])")
                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
                    
                    //wait 1 seconds for the activity page to load
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem3!)
                }
                workItem1 = DispatchWorkItem{
                    //play game intro part 2 (segway into first letter activity)
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
                    
                    //wait 5 seconds for game intro2 to finish
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:self.workItem2!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                
                //wait 1 seconds (small pause)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    //play game intro part 2 (segway into first letter activity)
//                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration2"]!, fileExtension: "mp3")
//
//                    //wait 5 seconds for game intro2 to finish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 1")
//                        self.shatterLetterOne = true
//
//                        //trasition to the activity page for the first letter
//                        print("Loading activity \(chapterSelectedLetterArray![0])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![0])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration3"]!, fileExtension: "mp3")
//                        })
//                    })
//                })
            default:
                break
            }
            
            gameProgress = .toLetter2
            //----------------------------------------------------
        //MARK: Letter 2
        case .toLetter2:
            switch currentChapter {
                case .Chapter10:
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration10"]!, type: "mp3")
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration10"]!, fileExtension: "mp3")
                    
                    workItem1 = DispatchWorkItem{
                       //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
                        self.shatterLetterTwo = true
                        
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        //play narration for the first audio instructions for the activity
                        //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
//                        self.shatterLetterTwo = true
//
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//                        //play narration for the first audio instructions for the activity
//                        //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration11"]!, type: "mp3")
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
//                    })
                    print("stopwalk chapter 10 stuff")
                case .Chapter9:
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
                    //patricia idles in the air looking for Brennon
                    
                    // Light on Ryan
                    let lightNode = self.createSpotLightNode(intensity: 20, spotInnerAngle: 0, spotOuterAngle: 45)
                    lightNode.position = SCNVector3Make(0, 15, 0)
                    lightNode.eulerAngles = SCNVector3Make(-.pi/2, 0, 0)
                    lightItem2 = DispatchWorkItem{
                        lightNode.removeFromParentNode()
                    }
                    lightItem1 = DispatchWorkItem{
                        self.charcterThreeIdle.childNode(withName: "Ryan", recursively: false)!.addChildNode(lightNode)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.lightItem2!)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.lightItem1!)
                    
                    self.shatterLetterTwo = true
                    
                    workItem1 = DispatchWorkItem{
                        self.particleItem3?.cancel()
                        self.patricia2!.childNode(withName: "Patricia", recursively: true)!.removeAllParticleSystems()
                        self.patriciaNumber = 3
                        self.patriciaFlying = true
                        self.patricia2!.isHidden = true
                        self.patricia3!.isHidden = false
                        //load first letter for activityView page
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 13, execute: {
//                        self.patricia2!.isHidden = true
//                        self.patricia3!.isHidden = false
//                        //load first letter for activityView page
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
//                    })
                    
                    print("stopwalk chapter 9 stuff")
                case .Chapter8:
                    //self.stopTransitionAnimation(key: "MainCharacterWalking")
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration7"]!, fileExtension: "mp3")
                    self.shatterLetterTwo = true
                    
                    workItem1 = DispatchWorkItem{
                        //load first letter for activityView page
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration8"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                        //load first letter for activityView page
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration8"]!, fileExtension: "mp3")
//                    })
                    print("stopwalk chapter 8 stuff")
                case .Chapter7:
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    startTransitionAnimation(key: "MainCharacterIdle")
                    
                    workItem3 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration9"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 2")
                        self.shatterLetterTwo = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                       //play game intro2 (segway into first letter activity)
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration8"]!, fileExtension: "mp3")
                        self.stopAnimateSideCharacter(key: "SideCharacter1Idle", sideCharacter: "Stanley")
                        self.startAnimateSideCharacter(key: "SideCharacter1Talking", sideCharacter: "Stanley")
                        
                        //wait 6 seconds for game intro2 to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute:self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //play game intro2 (segway into first letter activity)
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration8"]!, fileExtension: "mp3")
//                        self.stopAnimateSideCharacter(key: "SideCharacter1Idle", sideCharacter: "Stanley")
//                        self.startAnimateSideCharacter(key: "SideCharacter1Talking", sideCharacter: "Stanley")
//
//                        //wait 6 seconds for game intro2 to finish
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 18, execute: {
//                            //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                            print("Prepare to shatter letter 2")
//                            self.shatterLetterTwo = true
//
//                            //trasition to the activity page for the first letter
//                            print("Loading activity \(chapterSelectedLetterArray![1])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//
//                            //wait 1 seconds for the activity page to load
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration9"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                    print("Ursa stops at Stanley")
                case .Chapter6:
                    //FIXME: chapter 6 letter 2
                    print("Prepare to shatter letter 2")
                    self.shatterLetterTwo = true
                    
                    //play intro narration for "a"
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration7"]!, fileExtension: "mp3") //7.08
                    
                    workItem1 = DispatchWorkItem{
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration8"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: workItem1!)
                    
                    
                    print("stopwalk chapter 6 stuff")
                case .Chapter5:
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
                    
                    workItem1 = DispatchWorkItem{
                        print("Prepare to shatter letter 2")
                        self.shatterLetterTwo = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: workItem1!)
                    
                    //look around for nails at teachers desk
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                        print("Prepare to shatter letter 2")
//                        self.shatterLetterTwo = true
//
//                        print("Loading activity \(chapterSelectedLetterArray![1])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
//                    })
                    
                case .Chapter4:
                    //transition the animation from walking to idle
                    stopTransitionAnimation(key: "MainCharacterJogging")
                    startTransitionAnimation(key: "MainCharacterIdle")
                    //play narration for the second audio instructions for the activity
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
                    self.shatterLetterTwo = true
                    
                    workItem1 = DispatchWorkItem{
                      //trasition to the activity page for the second letter
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: workItem1!)
                    
                    //wait 10 seconds for the intro narration to finish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
//                        //trasition to the activity page for the second letter
//                        print("Loading activity \(chapterSelectedLetterArray![1])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
//                    })
                    
                case .Chapter3:
                    workItem4 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
                    }
                    workItem3 = DispatchWorkItem{
                        self.stopTransitionAnimation(key: "MainChracterSwimming")
                        self.startTransitionAnimation(key: "MainCharacterIdle")
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: self.workItem4!)
                    }
                    workItem2 = DispatchWorkItem{
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
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute:self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        self.stopTransitionAnimation(key: "MainChracterSwimming")
                        self.startTransitionAnimation(key: "MainCharacterIdle")
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
                        
                        //wait 5 seconds for game intro2 to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute:self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        self.stopTransitionAnimation(key: "MainChracterSwimming")
//                        self.startTransitionAnimation(key: "MainCharacterIdle")
//
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
//
//                        //wait 5 seconds for game intro2 to finish
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
//                            //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                            print("Prepare to shatter letter 1")
//                            self.shatterLetterTwo = true
//
//                            self.stopTransitionAnimation(key: "MainChracterIdle")
//                            self.startTransitionAnimation(key: "MainCharacterSwimming")
//                            self.stopAnimateSideCharacter(key: "SideCharacter2Swimming", sideCharacter: "Quinn")
//                            self.startAnimateSideCharacter(key: "SideCharacter2Idle", sideCharacter: "Quinn")
//
//                            //move to Ollie
//                            let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
//                            let chapter3Letter1RotationSeq = SCNAction.sequence([rotate1])
//                            self.mainCharacterIdle?.parent?.runAction(chapter3Letter1RotationSeq)
//                            let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P2 to P1
//                            let chapter3Letter2MoveSeq = SCNAction.sequence([move1])
//                            self.mainCharacterIdle?.parent?.runAction(chapter3Letter2MoveSeq)
//
//                            //move Quinn to Ollie
//                            let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(79.606)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
//                            let chapter3Letter2RotationSeq2 = SCNAction.sequence([rotate2])
//                            self.charcterTwoIdle?.parent?.runAction(chapter3Letter2RotationSeq2)
//                            let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)  //P2 to P1
//                            let chapter3Letter2MoveSeq2 = SCNAction.sequence([move2])
//                            self.charcterTwoIdle?.parent?.runAction(chapter3Letter2MoveSeq2)
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
//                                self.stopTransitionAnimation(key: "MainChracterSwimming")
//                                self.startTransitionAnimation(key: "MainCharacterIdle")
//
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
//
//                                //wait 1 seconds for the activity page to load
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
//                                    //trasition to the activity page for the first letter
//                                    print("Loading activity \(chapterSelectedLetterArray![1])")
//                                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//
//                                    //play narration for the first audio instructions for the activity
//                                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
//                                })
//                            })
//                        })
//                    })
                    
                case .Chapter2:
                    print("skip stopping the skate animation")
                    workItem3 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 2")
                        self.shatterLetterTwo = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 2")
//                        self.shatterLetterTwo = true
//
//                        //trasition to the activity page for the first letter
//                        print("Loading activity \(chapterSelectedLetterArray![1])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
//
//                            //wait 1 seconds for the activity page to load
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                case .Chapter1:
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    workItem3 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 2")
                        self.shatterLetterTwo = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![1])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem3!)
                            
                    }
                    workItem1 = DispatchWorkItem{
                        [weak self] in self?.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
                        //wait 4 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self!.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: workItem1!) //LM Test
                    
                    //wait 2 seconds
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                        [weak self] in self?.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration11"]!, fileExtension: "mp3")
//                        //wait 4 seconds
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                            //get ready to shatter a when ViewDidAppear() is called
//                            print("Prepare to shatter letter 2")
//                            self.shatterLetterTwo = true
//
//                            print("Loading activity \(chapterSelectedLetterArray![1])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![1])
//
//                            //wait 6 seconds
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                default:
                    break
            }
            gameProgress = .toLetter3
            //----------------------------------------------------
        //MARK: Letter 3
        case .toLetter3:
            switch currentChapter {
                case .Chapter10:
                    stopTransitionAnimation(key: "MainCharacterWalking")
                     
                     //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration16"]!, type: "mp3")
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration16"]!, fileExtension: "mp3")
                    
                     workItem1 = DispatchWorkItem{
                         //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
                          self.shatterLetterThree = true
                          
                          self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                          //play narration for the first audio instructions for the activity
                          //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration17"]!, type: "mp3")
                         self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration17"]!, fileExtension: "mp3")
                     }
                     
                     DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: workItem1!)
                    
//                     DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
//                         //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
//                         self.shatterLetterThree = true
//
//                         self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//                         //play narration for the first audio instructions for the activity
//                         //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration17"]!, type: "mp3")
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration17"]!, fileExtension: "mp3")
//                     })
                    print("stopwalk chapter 10 stuff")
                case .Chapter9:
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
                    self.shatterLetterThree = true
                    
                    // Light on Nikki
                    let lightNode = self.createSpotLightNode(intensity: 20, spotInnerAngle: 0, spotOuterAngle: 45)
                    lightNode.position = SCNVector3Make(0, 10, 0)
                    lightNode.eulerAngles = SCNVector3Make(-.pi/2, 0, 0)
                    lightItem2 = DispatchWorkItem{
                        lightNode.removeFromParentNode()
                    }
                    lightItem1 = DispatchWorkItem{
                        self.charcterFourIdle.addChildNode(lightNode)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.lightItem2!)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.lightItem1!)
                    
                    workItem1 = DispatchWorkItem{
                        self.particleItem3?.cancel()
                        self.patricia6!.childNode(withName: "Patricia", recursively: false)!.removeAllParticleSystems()
                        self.patriciaNumber = 7
                        self.patriciaFlying = true
                        self.patricia6!.isHidden = true
                        self.patricia7!.isHidden = false
                        //load first letter for activityView page
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                        self.patricia6!.isHidden = true
//                        self.patricia7!.isHidden = false
//                        //load first letter for activityView page
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
//                    })
                    print("stopwalk chapter 9 stuff")
                case .Chapter8:
                    self.startTransitionAnimation(key: "MainCharacterIdle")
                    //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                    self.shatterLetterThree = true
                    
                    workItem1 = DispatchWorkItem{
                        //load first letter for activityView page
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration14"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //load first letter for activityView page
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration14"]!, fileExtension: "mp3")
//                    })
                    print("stopwalk chapter 8 stuff")
                case .Chapter7:
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    workItem4 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration14"]!, fileExtension: "mp3")
                    }
                    workItem3 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem4!)
                    }
                    workItem2 = DispatchWorkItem{
                        print("Prepare to shatter letter 3")
                        self.shatterLetterThree = true
                        
                        self.startAnimateSideCharacter(key: "SideCharacter2Talking", sideCharacter: "Vivian")
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //play game intro2 (segway into first letter activity)
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
                        
                        //wait 9 seconds for game intro2 to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //play game intro2 (segway into first letter activity)
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration12"]!, fileExtension: "mp3")
//
//                        //wait 9 seconds for game intro2 to finish
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
//                            print("Prepare to shatter letter 3")
//                            self.shatterLetterThree = true
//
//                            self.startAnimateSideCharacter(key: "SideCharacter2Talking", sideCharacter: "Vivian")
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3")
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
//                                //trasition to the activity page for the first letter
//                                print("Loading activity \(chapterSelectedLetterArray![2])")
//                                self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//
//                                //wait 1 seconds for the activity page to load
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                                    //play narration for the first audio instructions for the activity
//                                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration14"]!, fileExtension: "mp3")
//                                })
//                            })
//                        })
//                    })
                    print("Ursa stops at Vivian")
                case .Chapter6:
                    //FIXME: chapter 6 letter 3
                    print("Prepare to shatter letter 3")
                    self.shatterLetterThree = true
                    
                    //play intro narration for "d"
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration13"]!, fileExtension: "mp3") //7.22
                    
                    workItem1 = DispatchWorkItem{
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration14"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8.5, execute: workItem1!)
                    print("stopwalk chapter 6 stuff")
                case .Chapter5:
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
                    
                    workItem1 = DispatchWorkItem{
                        print("Prepare to shatter letter 3")
                        self.shatterLetterThree = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: workItem1!)
                    
                    //look around for nails at teachers desk
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                        print("Prepare to shatter letter 3")
//                        self.shatterLetterThree = true
//
//                        print("Loading activity \(chapterSelectedLetterArray![2])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
//                    })
                    
                case .Chapter4:
                    stopTransitionAnimation(key: "MainCharacterJogging")
                    startTransitionAnimation(key: "MainCharacterIdle")
                    
                    workItem2 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
                    }
                    workItem1 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
                        print("Prepare to shatter letter 3")
                        self.shatterLetterThree = true
                        
                        //wait 6 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds for the activity page to load
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
//                        print("Prepare to shatter letter 3")
//                        self.shatterLetterThree = true
//
//                        //wait 6 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                            //trasition to the activity page for the first letter
//                            print("Loading activity \(chapterSelectedLetterArray![2])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
//                        })
//                    })
                case .Chapter3:
                    workItem4 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
                    }
                    workItem3 = DispatchWorkItem{
                        self.stopTransitionAnimation(key: "MainChracterSwimming")
                        self.startTransitionAnimation(key: "MainCharacterIdle")
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: self.workItem4!)
                    }
                    workItem2 = DispatchWorkItem{
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
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        self.stopTransitionAnimation(key: "MainChracterSwimming")
                        self.startTransitionAnimation(key: "MainCharacterIdle")
                        //play game intro part 2 (segway into first letter activity)
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")

                        //wait 5 seconds for game intro2 to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        self.stopTransitionAnimation(key: "MainChracterSwimming")
//                        self.startTransitionAnimation(key: "MainCharacterIdle")
//                        //play game intro part 2 (segway into first letter activity)
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
//
//                        //wait 5 seconds for game intro2 to finish
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 16, execute: {
//
//                            print("Set up trigger for after activityView")
//                            self.shatterLetterThree = true
//
//                            self.stopTransitionAnimation(key: "MainChracterIdle")
//                            self.startTransitionAnimation(key: "MainCharacterSwimming")
//
//                            //move to Ollie
//                            let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
//                            let chapter3Letter3RotationSeq = SCNAction.sequence([rotate1])
//                            self.mainCharacterIdle?.parent?.runAction(chapter3Letter3RotationSeq)
//                            let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P1 to P2
//                            let chapter3Letter3MoveSeq = SCNAction.sequence([move1])
//                            self.mainCharacterIdle?.parent?.runAction(chapter3Letter3MoveSeq)
//
//                            //move Simon to Ollie
//                            let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(79.606)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 3)
//                            let chapter3Letter3RotationSeq2 = SCNAction.sequence([rotate2])
//                            self.charcterThreeIdle?.parent?.runAction(chapter3Letter3RotationSeq2)
//                            let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)  //P1 to P2
//                            let chapter3Letter3MoveSeq2 = SCNAction.sequence([move2])
//                            self.charcterThreeIdle?.parent?.runAction(chapter3Letter3MoveSeq2)
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
//                                self.stopTransitionAnimation(key: "MainChracterSwimming")
//                                self.startTransitionAnimation(key: "MainCharacterIdle")
//
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
//
//                                //wait 1 seconds for the activity page to load
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                                    //trasition to the activity page for the first letter
//                                    print("Loading activity \(chapterSelectedLetterArray![2])")
//                                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//
//                                    //play narration for the first audio instructions for the activity
//                                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
//                                })
//                            })
//                        })
//                    })
                    
                case .Chapter2:
                    print("skip stopping the skate animation")
                    
                    workItem3 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 2")
                        self.shatterLetterThree = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 2")
//                        self.shatterLetterThree = true
//
//                        //trasition to the activity page for the first letter
//                        print("Loading activity \(chapterSelectedLetterArray![2])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
//
//                            //wait 1 seconds for the activity page to load
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                case .Chapter1:
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    workItem3 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 3")
                        self.shatterLetterThree = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![2])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
                        //wait 4 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem1!)
                    
                    //wait 2 seconds
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration18"]!, fileExtension: "mp3")
//                        //wait 4 seconds
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                            //get ready to shatter a when ViewDidAppear() is called
//                            print("Prepare to shatter letter 3")
//                            self.shatterLetterThree = true
//
//                            print("Loading activity \(chapterSelectedLetterArray![2])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![2])
//
//                            //wait 6 seconds
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                default:
                    break
            }
            gameProgress = .toLetter4
            //----------------------------------------------------
        //MARK: Letter 4
        case .toLetter4:
            switch currentChapter {
                case .Chapter10:
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration22"]!, type: "mp3") //Trace the Letter Z to Try the Zambomba
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration22"]!, fileExtension: "mp3")
                    
                    workItem1 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
                        self.shatterLetterFour = true
                        
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        //play narration for the first audio instructions for the activity
                        //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration23"]!, type: "mp3")
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration23"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 17, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 17, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (letter activity page disappears)
//                        self.shatterLetterFour = true
//
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//                        //play narration for the first audio instructions for the activity
//                        //self.toggleAudioNarrationFile(file: chapterSelectedSoundDict!["Narration23"]!, type: "mp3")
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration23"]!, fileExtension: "mp3")
//                    })
                    print("stopwalk chapter 10 stuff")
                case .Chapter9:
                    //patricia stops when she finds Heidi
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration28"]!, fileExtension: "mp3")
                    self.patricia8!.isPaused = true
                    
                    self.shatterLetterFour = true
                    
                    workItem1 = DispatchWorkItem{
                        self.particleItem3?.cancel()
                        self.patricia8!.childNode(withName: "Patricia", recursively: false)!.removeAllParticleSystems()
                        self.patriciaNumber = 9
                        self.patriciaFlying = true
                        self.patricia8!.isHidden = true
                        self.patricia9!.isHidden = false
                        
                        //load first letter for activityView page
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration29"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                        self.patricia8!.isHidden = true
//                        self.patricia9!.isHidden = false
//
//                        //load first letter for activityView page
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration29"]!, fileExtension: "mp3")
//                    })
                        
                    print("stopwalk chapter 9 stuff")
                case .Chapter8:
                    workItem2 = DispatchWorkItem{
                        //load first letter for activityView page
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration23"]!, fileExtension: "mp3")
                    }
                    workItem1 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration22"]!, fileExtension: "mp3")
                        
                        self.shatterLetterFour = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration22"]!, fileExtension: "mp3")
//
//                        self.shatterLetterFour = true
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                            //load first letter for activityView page
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration23"]!, fileExtension: "mp3")
//                        })
//                    })
                    
                    print("stopwalk chapter 8 stuff")
                case .Chapter7:
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    startTransitionAnimation(key: "MainCharacterIdle")
                    
                    workItem4 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
                    }
                    workItem3 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem4!)
                    }
                    workItem2 = DispatchWorkItem{
                        print("Prepare to shatter letter 4")
                        self.shatterLetterFour = true
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //play game intro2 (segway into first letter activity)
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
                        
                        //Windsor starts talking
                        self.stopAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Windsor")
                        self.startAnimateSideCharacter(key: "SideCharacter3Talking", sideCharacter: "Windsor")
                        
                        //wait 9 seconds for game intro2 to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //play game intro2 (segway into first letter activity)
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3")
//
//                        //Windsor starts talking
//                        self.stopAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Windsor")
//                        self.startAnimateSideCharacter(key: "SideCharacter3Talking", sideCharacter: "Windsor")
//
//                        //wait 9 seconds for game intro2 to finish
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
//                            print("Prepare to shatter letter 4")
//                            self.shatterLetterFour = true
//
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
//                                //trasition to the activity page for the first letter
//                                print("Loading activity \(chapterSelectedLetterArray![3])")
//                                self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//
//                                //wait 1 seconds for the activity page to load
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                                    //play narration for the first audio instructions for the activity
//                                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration21"]!, fileExtension: "mp3")
//                                })
//                            })
//                        })
//                    })
                    
                    print("Ursa stops at Windsor")
                    
                case .Chapter6:
                    //FIXME: chapter 6 letter 4
                    print("Prepare to shatter letter 4")
                    self.shatterLetterFour = true
                    
                    //play intro narration for "g"
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration19"]!, fileExtension: "mp3") //7.78
                    
                    workItem1 = DispatchWorkItem{
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration20"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: workItem1!)
                    
                    
                    print("stopwalk chapter 6 stuff")
                case .Chapter5:
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration30"]!, fileExtension: "mp3")
                    
                    workItem2 = DispatchWorkItem{
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
                    }
                    workItem1 = DispatchWorkItem{
                        print("Prepare to shatter letter 4")
                        self.shatterLetterFour = true
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: workItem1!)
                    
                    //look around for nails at teachers desk
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                        print("Prepare to shatter letter 4")
//                        self.shatterLetterFour = true
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                            print("Loading activity \(chapterSelectedLetterArray![3])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
//                        })
//                    })
                    
                case .Chapter4:
                    stopTransitionAnimation(key: "MainCharacterJogging")
                    startTransitionAnimation(key: "MainCharacterIdle")
                    
                    workItem2 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
                    }
                    workItem1 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
                        print("Prepare to shatter letter 4")
                        self.shatterLetterFour = true
                        
                        //wait 6 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds for the activity page to load
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
//                        print("Prepare to shatter letter 4")
//                        self.shatterLetterFour = true
//
//                        //wait 6 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
//                            //trasition to the activity page for the first letter
//                            print("Loading activity \(chapterSelectedLetterArray![3])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
//                        })
//                    })
                    
                case .Chapter3:
                    workItem8 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration27"]!, fileExtension: "mp3")

                    }
                    workItem7 = DispatchWorkItem{
                        self.stopTransitionAnimation(key: "MainChracterSwimming")
                        self.startTransitionAnimation(key: "MainCharacterIdle")
                        self.stopAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
                        self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration26"]!, fileExtension: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem8!)
                    }
                    workItem6 = DispatchWorkItem{
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
                            
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: self.workItem7!)
                    }
                    workItem5 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration25"]!, fileExtension: "mp3")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 25, execute: self.workItem6!)
                    }
                    workItem4 = DispatchWorkItem{
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
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem5!)
                    }
                    workItem3 = DispatchWorkItem{
                        //Gary is shocked
                        //self.mainCharacterIdle.animationPlayer(forKey: "MainCharacterShocked")?.speed = 3.0
                        self.stopTransitionAnimation(key: "MainCharacterSwimming")
                        self.startTransitionAnimation(key: "MainCharacterShocked")
                        self.playAudio(type: .Effect, file: "Electrocuted", fileExtension: "mp3", rate: 1)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem4!)
                    }
                    workItem2 = DispatchWorkItem{
                        print("Set up trigger for after activityView")
                        self.shatterLetterFour = true
                        
                        //Gary touches Jillian
                        let ratationGary1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-173.658)), y: CGFloat(GLKMathDegreesToRadians(54.663)), z: CGFloat(GLKMathDegreesToRadians(-165.956)), duration: 1)
                        let moveGary1 = SCNAction.move(to: SCNVector3(-0.299,0.21,-0.435), duration: 1)
                        let moveToJillian = SCNAction.sequence([ratationGary1, moveGary1])
                        self.mainCharacterIdle?.parent?.runAction(moveToJillian)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        self.stopTransitionAnimation(key: "MainChracterSwimming")
                        self.startTransitionAnimation(key: "MainCharacterIdle")
                        
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration24"]!, fileExtension: "mp3")
                        
                        //wait 5 seconds for game intro2 to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //Jillian the Jellyfish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        self.stopTransitionAnimation(key: "MainChracterSwimming")
//                        self.startTransitionAnimation(key: "MainCharacterIdle")
//
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration24"]!, fileExtension: "mp3")
//
//                        //wait 5 seconds for game intro2 to finish
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
//
//                            print("Set up trigger for after activityView")
//                            self.shatterLetterFour = true
//
//                            //Gary touches Jillian
//                            let ratationGary1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-173.658)), y: CGFloat(GLKMathDegreesToRadians(54.663)), z: CGFloat(GLKMathDegreesToRadians(-165.956)), duration: 1)
//                            let moveGary1 = SCNAction.move(to: SCNVector3(-0.299,0.21,-0.435), duration: 1)
//                            let moveToJillian = SCNAction.sequence([ratationGary1, moveGary1])
//                            self.mainCharacterIdle?.parent?.runAction(moveToJillian)
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                                //Gary is shocked
//                                //self.mainCharacterIdle.animationPlayer(forKey: "MainCharacterShocked")?.speed = 3.0
//                                self.stopTransitionAnimation(key: "MainCharacterSwimming")
//                                self.startTransitionAnimation(key: "MainCharacterShocked")
//                                self.playAudio(type: .Effect, file: "Electrocuted", fileExtension: "mp3", rate: 1)
//
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                                    //Gary and Jillian move back away from each other
//                                    self.stopTransitionAnimation(key: "MainCharacterShocked")
//                                    self.startTransitionAnimation(key: "MainCharacterSwimming")
//                                    self.stopAnimateSideCharacter(key: "SideCharacter4Sleeping", sideCharacter: "Jillian")
//                                    self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
//                                    //Gary move
//                                    let rotationGary2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(-163.287)), y: CGFloat(GLKMathDegreesToRadians(27.438)), z: CGFloat(GLKMathDegreesToRadians(-146.911)), duration: 1)
//                                    let moveGary2 = SCNAction.move(to: SCNVector3(-0.246, 0.254, -0.371), duration: 1)
//                                    let moveAwayfromJillian = SCNAction.sequence([moveGary2, rotationGary2])
//                                    self.mainCharacterIdle?.parent?.runAction(moveAwayfromJillian)
//                                    //Jillian move
//                                    let moveJillian = SCNAction.move(to: SCNVector3(-0.396,0.198,-0.466), duration: 1)
//                                    let rotationJillian = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(-45)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 1)
//                                    let moveAwayfromGary = SCNAction.sequence([moveJillian, rotationJillian])
//                                    self.charcterFourIdle?.parent?.runAction(moveAwayfromGary)
//
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration25"]!, fileExtension: "mp3")
//
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 25, execute: {
//                                            //move to Gary to Top
//                                            self.stopTransitionAnimation(key: "MainCharacterIdle")
//                                            self.startTransitionAnimation(key: "MainCharacterSwimming")
//                                            let rotate1 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0.113)), y: CGFloat(GLKMathDegreesToRadians(-8.133)), z: CGFloat(GLKMathDegreesToRadians(6.971)), duration: 8)
//                                            let chapter3Letter4RotationSeq = SCNAction.sequence([rotate1])
//                                            self.mainCharacterIdle?.parent?.runAction(chapter3Letter4RotationSeq)
//                                            let move1 = SCNAction.move(to: SCNVector3(-0.225, 1.375, 0.005), duration: 8)  //P1 to P2
//                                            let chapter3Letter4MoveSeq = SCNAction.sequence([move1])
//                                            self.mainCharacterIdle?.parent?.runAction(chapter3Letter4MoveSeq)
//
//                                            //move Jillian to Top
//                                            self.stopAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
//                                            self.startAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
//                                            let rotate2 = SCNAction.rotateTo(x: CGFloat(GLKMathDegreesToRadians(0)), y: CGFloat(GLKMathDegreesToRadians(0)), z: CGFloat(GLKMathDegreesToRadians(0)), duration: 3)
//                                            let chapter3Letter4RotationSeq2 = SCNAction.sequence([rotate2])
//                                            self.charcterFourIdle?.parent?.runAction(chapter3Letter4RotationSeq2)
//                                            let move2 = SCNAction.move(to: SCNVector3(-0.221, 1.349, 0.11), duration: 8)
//                                            let chapter3Letter4MoveSeq2 = SCNAction.sequence([move2])
//                                            self.charcterFourIdle?.parent?.runAction(chapter3Letter4MoveSeq2)
//
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 7.9, execute: {
//                                                self.stopTransitionAnimation(key: "MainChracterSwimming")
//                                                self.startTransitionAnimation(key: "MainCharacterIdle")
//                                                self.stopAnimateSideCharacter(key: "SideCharacter4Swimming", sideCharacter: "Jillian")
//                                                self.startAnimateSideCharacter(key: "SideCharacter4Idle", sideCharacter: "Jillian")
//
//                                                //play narration for the first audio instructions for the activity
//                                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration26"]!, fileExtension: "mp3")
//
//                                                //wait 1 seconds for the activity page to load
//                                                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                                                    //trasition to the activity page for the first letter
//                                                    print("Loading activity \(chapterSelectedLetterArray![3])")
//                                                    self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//
//                                                    //play narration for the first audio instructions for the activity
//                                                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration27"]!, fileExtension: "mp3")
//                                                })
//                                            })
//                                        })
//                                    })
//                                })
//                            })
//                        })
//                    })
                    
                case .Chapter2:
                    print("skip stopping the skate animation")
                    
                    workItem3 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration25"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration24"]!, fileExtension: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 2")
                        self.shatterLetterFour = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 2")
//                        self.shatterLetterFour = true
//
//                        //trasition to the activity page for the first letter
//                        print("Loading activity \(chapterSelectedLetterArray![3])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration24"]!, fileExtension: "mp3")
//
//                            //wait 1 seconds for the activity page to load
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration25"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                case .Chapter1:
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    workItem3 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration25"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 4")
                        self.shatterLetterFour = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![3])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem3!)
                            
                    }
                    workItem1 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration24"]!, fileExtension: "mp3")
                        //wait 4 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: workItem1!)//LM
                    
                    //wait 2 seconds
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration24"]!, fileExtension: "mp3")
//                        //wait 4 seconds
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                            //get ready to shatter a when ViewDidAppear() is called
//                            print("Prepare to shatter letter 4")
//                            self.shatterLetterFour = true
//
//                            print("Loading activity \(chapterSelectedLetterArray![3])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![3])
//
//                            //wait 6 seconds
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration25"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                default:
                    break
            }
            gameProgress = .toLetter5
            //----------------------------------------------------
        //MARK: Letter 5
        case .toLetter5:
            switch currentChapter {
                case .Chapter10:
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    self.shatterLetterFive = true
                    self.playShatterAnimation()
                    print("stopwalk chapter 10 stuff")
                case .Chapter9:
                    //patricia lands by Brennon
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration34"]!, fileExtension: "mp3")
                    
                    self.shatterLetterFive = true
                    
                    // Light on Patricia
                    let lightNode = self.createSpotLightNode(intensity: 20, spotInnerAngle: 0, spotOuterAngle: 45)
                    lightNode.position = SCNVector3Make(0, 5, 0)
                    lightNode.eulerAngles = SCNVector3Make(-.pi/2, 0, 0)
                    lightItem2 = DispatchWorkItem{
                        lightNode.removeFromParentNode()
                    }
                    lightItem1 = DispatchWorkItem{
                        self.patricia1?.childNode(withName: "Patricia", recursively: false)!.addChildNode(lightNode)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.lightItem2!)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.lightItem1!)
                    
                    workItem5 = DispatchWorkItem{
                        self.resetGame()
                    }
                    workItem4 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration36"]!, fileExtension: "mp3")
                        
                        //Patricia is off to the races
                        self.patricia11!.isHidden = false
                        self.patricia11!.isPaused = false
                        self.patricia10!.isHidden = true
                        self.patricia10!.isPaused = true
                        
                        //Brennon is off to the races
                        let rotate1 = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)
                        let move1 = SCNAction.move(to: SCNVector3(-9.7, 0.25, 13.7), duration: 8)
                        let brennonMoveSeq = SCNAction.sequence([rotate1, move1])
                         
                         self.charcterOneIdle.childNode(withName: "Brennon", recursively: true)!.runAction(brennonMoveSeq)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: self.workItem5!)
                            
                    }
                    workItem3 = DispatchWorkItem{
                        //Brennon gives Patricia her Balloon
                        let balloon4Patricia = self.charcterOneIdle.childNode(withName: "Balloon2", recursively: true)
                        balloon4Patricia!.isHidden = true
                        
                        //Patricia Recieves her Balloon
                        let returnedBalloon = self.patricia10?.childNode(withName: "BrennonsBalloon", recursively: true)
                        returnedBalloon!.isHidden = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem4!)
                            
                    }
                    workItem2 = DispatchWorkItem{
                        //Patricia give Brennon back his Balloon
                        let returnedBalloon = self.patricia10?.childNode(withName: "BrennonsBalloon", recursively: true)
                        returnedBalloon!.isHidden = true
                        
                        //Brennon receives his Balloon
                        let balloon = self.charcterOneIdle.childNode(withName: "Balloon", recursively: true)
                        balloon!.isHidden = false
                        
                        //Brennon thanks Patricia and gives her a Balloon too
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration35"]!, fileExtension: "mp3")
                                                
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        self.patricia10!.isHidden = false
                        self.patricia10!.isPaused = false
                        self.particleItem3?.cancel()
                        self.patricia9!.childNode(withName: "Patricia", recursively: false)!.removeAllParticleSystems()
                        self.patriciaNumber = 0
                        self.patriciaFlying = false
                        self.patricia9!.isHidden = true
                        self.patricia9!.isPaused = true
                                                                
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
//                        self.patricia10!.isHidden = false
//                        self.patricia10!.isPaused = false
//                        self.patricia9!.isHidden = true
//                        self.patricia9!.isPaused = true
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//
//                            //Patricia give Brennon back his Balloon
//                            let returnedBalloon = self.patricia10?.childNode(withName: "BrennonsBalloon", recursively: true)
//                            returnedBalloon!.isHidden = true
//
//                            //Brennon receives his Balloon
//                            let balloon = self.charcterOneIdle.childNode(withName: "Balloon", recursively: true)
//                            balloon!.isHidden = false
//
//                            //Brennon thanks Patricia and gives her a Balloon too
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration35"]!, fileExtension: "mp3")
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                                //Brennon gives Patricia her Balloon
//                                let balloon4Patricia = self.charcterOneIdle.childNode(withName: "Balloon2", recursively: true)
//                                balloon4Patricia!.isHidden = true
//
//                                //Patricia Recieves her Balloon
//                                returnedBalloon!.isHidden = false
//
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration36"]!, fileExtension: "mp3")
//
//                                    //Patricia is off to the races
//                                    self.patricia11!.isHidden = false
//                                    self.patricia11!.isPaused = false
//                                    self.patricia10!.isHidden = true
//                                    self.patricia10!.isPaused = true
//
//                                    //Brennon is off to the races
//                                    let rotate1 = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)
//                                    let move1 = SCNAction.move(to: SCNVector3(-9.7, 0.25, 13.7), duration: 8)
//                                    let brennonMoveSeq = SCNAction.sequence([rotate1, move1])
//
//                                     self.charcterOneIdle.childNode(withName: "Brennon", recursively: true)!.runAction(brennonMoveSeq)
//
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
//                                        self.resetGame()
//                                    })
//                                })
//                            })
//                        })
//                    })
                    
                    print("stopwalk chapter 9 stuff")
                case .Chapter8:
                    self.stopAnimateSideCharacter(key: "SideCharacter3Walking", sideCharacter: "Ernie")
                    self.startAnimateSideCharacter(key: "SideCharacter3Idle", sideCharacter: "Ernie")
                    
                    
                    //play instructions to touch Lionel the lemon
                    playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration29"]!, fileExtension: "mp3") //can you tap the lemon?
                    shatterLetterFive = true
                    
                    //Find and unhide the plate
                    let plate =  mainFloor.childNode(withName: "Plate", recursively: true)
                    plate!.isHidden = false
                    
                    print("stopwalk chapter 8 stuff")
                case .Chapter7:
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    workItem3 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //play game intro (segway into letter activity)
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration30"]!, fileExtension: "mp3")
                        
                        self.stopAnimateSideCharacter(key: "SideCharacter4Talking", sideCharacter: "Isaac")
                        self.startAnimateSideCharacter(key: "SideCharacter4Talking", sideCharacter: "Isaac")
                        
                        print("Prepare to shatter letter 5")
                        self.shatterLetterFive = true
                        
                        //wait 12 seconds for game intro to finish
                        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //play game intro (segway into letter activity)
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration30"]!, fileExtension: "mp3")
//
//                        self.stopAnimateSideCharacter(key: "SideCharacter4Talking", sideCharacter: "Isaac")
//                        self.startAnimateSideCharacter(key: "SideCharacter4Talking", sideCharacter: "Isaac")
//
//                        print("Prepare to shatter letter 5")
//                        self.shatterLetterFive = true
//
//                        //wait 12 seconds for game intro to finish
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
//                            //trasition to the activity page for the first letter
//                            print("Loading activity \(chapterSelectedLetterArray![4])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
//
//                            //wait 1 seconds for the activity page to load
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                    
                    print("Trace the letter i to have Ursa climb over the log")
                case .Chapter6:
                    //FIXME: chapter 6 letter 5
                    print("Prepare to shatter letter 5")
                    self.shatterLetterFive = true
                    
                    //play intro narration for "o"
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration25"]!, fileExtension: "mp3") //9.1
                    
                    workItem1 = DispatchWorkItem{
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration26"]!, fileExtension: "mp3")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: workItem1!)
                    print("stopwalk chapter 6 stuff")
                case .Chapter5:
                    stopTransitionAnimation(key: "MainCharacterWalking")
                case .Chapter4:
                    stopTransitionAnimation(key: "MainCharacterJogging")
                    startTransitionAnimation(key: "MainCharacterIdle")
                    
                    workItem2 = DispatchWorkItem{
                        //trasition to the activity page for the fifth letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration43"]!, fileExtension: "mp3")
                    }
                    workItem1 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration42"]!, fileExtension: "mp3")
                        print("Prepare to shatter letter 5")
                        self.shatterLetterFive = true
                        
                        //wait 6 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds for the activity page to load
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //play narration for the first audio instructions for the activity
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration42"]!, fileExtension: "mp3")
//                        print("Prepare to shatter letter 5")
//                        self.shatterLetterFive = true
//
//                        //wait 6 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
//                            //trasition to the activity page for the fifth letter
//                            print("Loading activity \(chapterSelectedLetterArray![4])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
//
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration43"]!, fileExtension: "mp3")
//                        })
//                    })
                    
                case .Chapter3:
                    workItem2 = DispatchWorkItem{
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
                    }
                    workItem1 = DispatchWorkItem{
                        //convince Ollie to swimm
                        print("Prepare to shatter letter 1")
                        self.shatterLetterFive = true
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
                        
                        //wait 3 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //convince Ollie to swimm
//                        print("Prepare to shatter letter 1")
//                        self.shatterLetterFive = true
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
//
//                        //wait 3 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                            //trasition to the activity page for the first letter
//                            print("Loading activity \(chapterSelectedLetterArray![4])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
//
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
//                        })
//                    })
                case .Chapter2:
                    print("skip stopping the skate animation")
                    
                    workItem3 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 2")
                        self.shatterLetterFive = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 2")
//                        self.shatterLetterFive = true
//
//                        //trasition to the activity page for the first letter
//                        print("Loading activity \(chapterSelectedLetterArray![4])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
//
//                            //wait 1 seconds for the activity page to load
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                case .Chapter1:
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    workItem3 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //get ready to shatter a when ViewDidAppear() is called
                        print("Prepare to shatter letter 5")
                        self.shatterLetterFive = true
                        
                        print("Loading activity \(chapterSelectedLetterArray![4])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
                         self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3") //LM
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
                         self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration31"]!, fileExtension: "mp3")
                        //wait 4 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: self.workItem2!)//LM
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem1!)//LM
                    
                    //wait 2 seconds
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration32"]!, fileExtension: "mp3")
//                        //wait 4 seconds
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                            //get ready to shatter a when ViewDidAppear() is called
//                            print("Prepare to shatter letter 5")
//                            self.shatterLetterFive = true
//
//                            print("Loading activity \(chapterSelectedLetterArray![4])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![4])
//
//                            //wait 6 seconds
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration33"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                default:
                    break
            }
            gameProgress = .toLetter6
            //----------------------------------------------------
        //MARK: Letter 6
        case .toLetter6:

            switch currentChapter {
                case .Chapter10:
                    print("stopwalk chapter 10 stuff")
                case .Chapter9:
                    print("stopwalk chapter 9 stuff")
                case .Chapter8:
                    print("stopwalk chapter 8 stuff")
                case .Chapter7:
                    fadeoutWalkingSound()

                    //play game intro (segway into letter activity)
                    self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration36"]!, fileExtension: "mp3")
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    startTransitionAnimation(key: "MainCharacterIdle")
                        
                    //rotate Tyler to look at Ursa
                    self.charcterFiveIdle?.parent?.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(GLKMathDegreesToRadians(-60)), z: 0, duration: 1))
                    
                    //start tylers talking animation
                    self.stopAnimateSideCharacter(key: "SideCharacter5Fishing", sideCharacter: "Tyler")
                    self.startAnimateSideCharacter(key: "SideCharacter5Talking", sideCharacter: "Tyler")
                    
                    print("Prepare to shatter letter 6")
                    self.shatterLetterSix = true
                    
                    workItem2 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration37"]!, fileExtension: "mp3")
                    }
                    workItem1 = DispatchWorkItem{
                        //trasition to the activity page for the sixth letter
                        print("Loading activity \(chapterSelectedLetterArray![5])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: workItem1!)
                    
                    //wait 12 seconds for game intro to finish
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 11, execute: {
//                        //trasition to the activity page for the sixth letter
//                        print("Loading activity \(chapterSelectedLetterArray![5])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration37"]!, fileExtension: "mp3")
//                        })
//                    })
                    
                    print("Ursa stops at Tyler and he tells her to follow him")
                    
                case .Chapter6:
                    //FIXME: chapter 6 letter 6
                    
                    
                    
                    print("stopwalk chapter 6 stuff")
                case .Chapter5:
                    stopTransitionAnimation(key: "MainCharacterWalking")
                case .Chapter4:
                    stopTransitionAnimation(key: "MainCharacterWalking")
                case .Chapter3:
                    stopTransitionAnimation(key: "MainCharacterWalking")
                case .Chapter2:
                    print("skip stopping the skate animation")
                    
                    workItem3 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration45"]!, fileExtension: "mp3")
                    }
                    workItem2 = DispatchWorkItem{
                        //play narration for the first audio instructions for the activity
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration44"]!, fileExtension: "mp3")
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
                        print("Prepare to shatter letter 2")
                        self.shatterLetterSix = true
                        
                        //trasition to the activity page for the first letter
                        print("Loading activity \(chapterSelectedLetterArray![5])")
                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                        
                        //wait 1 seconds for the activity page to load
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1!)
                    
                    //wait 1 seconds (small pause)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                        //get ready to shatter the first letter when ViewDidAppear() is called again (activity page disappears)
//                        print("Prepare to shatter letter 2")
//                        self.shatterLetterSix = true
//
//                        //trasition to the activity page for the first letter
//                        print("Loading activity \(chapterSelectedLetterArray![5])")
//                        self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
//
//                        //wait 1 seconds for the activity page to load
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            //play narration for the first audio instructions for the activity
//                            self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration44"]!, fileExtension: "mp3")
//
//                            //wait 1 seconds for the activity page to load
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                                //play narration for the first audio instructions for the activity
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration45"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                case .Chapter1://LM 
                    fadeoutWalkingSound()
                    
                    stopTransitionAnimation(key: "MainCharacterWalking")
                    
                    workItem5 = DispatchWorkItem {
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration45"]!, fileExtension: "mp3")
                    }
                    workItem3 = DispatchWorkItem{
                        //self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration45"]!, fileExtension: "mp3")
                        print("Prepare to shatter letter 6")
                                               self.shatterLetterSix = true
                                               
                                               print("Loading activity \(chapterSelectedLetterArray![5])")
                                               self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.workItem5!)
                                               
                    }
                    workItem2 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration44"]!, fileExtension: "mp3")
                        //get ready to shatter a when ViewDidAppear() is called
                      //  print("Prepare to shatter letter 6")
                       // self.shatterLetterSix = true
                        
                       // print("Loading activity \(chapterSelectedLetterArray![5])")
                       // self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
                        
                        //wait 6 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.workItem3!)
                    }
                    workItem1 = DispatchWorkItem{
                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration43"]!, fileExtension: "mp3")
                       // self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration44"]!, fileExtension: "mp3")
                        //wait 4 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 17, execute:self.workItem2!)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem1!)
                    
                    //wait 2 seconds
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                        self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration44"]!, fileExtension: "mp3")
//                        //wait 4 seconds
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                            //get ready to shatter a when ViewDidAppear() is called
//                            print("Prepare to shatter letter 6")
//                            self.shatterLetterSix = true
//
//                            print("Loading activity \(chapterSelectedLetterArray![5])")
//                            self.loadActivityLetter(activityString: chapterSelectedLetterArray![5])
//
//                            //wait 6 seconds
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                                self.playAudio(type: .Narration, file: chapterSelectedSoundDict!["Narration45"]!, fileExtension: "mp3")
//                            })
//                        })
//                    })
                default:
                    break
            }
            gameProgress = .chapterFinished
        //----------------------------------------------------
        case .chapterFinished:
            
            //finish chapter stuff
            print("Finish Chapter after animation stopped")
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            //                self.playAudioNarrationFile(file: chapterSelectedSoundDict!["chapterFinish"]!, fileExtension: "mp3")
            //            })
            
            //TODO: trigger finishing event
        }
    }
}
