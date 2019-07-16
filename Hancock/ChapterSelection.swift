//
//  ChapterSelection.swift
//  Hancock
//
//  Created by Chris Ross on 7/2/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import Foundation
import UIKit
import ARKit

//GLOBAL VARIABLE THAT CAN BE ACCESSED BY NAME
var chapterSelected: [SCNNode]?

class ChapterSelection {
    
    var storyNode: SCNNode!
    var groundNode: SCNNode!
    let maskingNode = SCNNode()
    let idleNode = SCNNode()
    let walkingNode = SCNNode()
    let animationNode = SCNNode()
    let letterANode = SCNNode()
    
    func chapterLoader(picked: Int) {
        print("The picked chapter = ", picked)
        
        //change what is loaded into the chapterSelected GLOBAL variable based on what chapter number you pass into this function
        switch picked {
        case 1:
            print("Loading Chapter ", picked)
            chapterSelected = loadChapter1Files()
        case 2:
            print("Loading Chapter ", picked)
            chapterSelected = loadChapter1Files()
        case 3:
            print("Loading Chapter ", picked)
            chapterSelected = loadChapter1Files()
        case 4:
            print("Loading Chapter ", picked)
            chapterSelected = loadChapter1Files()
        case 5:
            print("Loading Chapter ", picked)
            chapterSelected = loadChapter1Files()
        default:
            return
        }
    }
    
    //chapter 1 stuff here
    func loadChapter1Files () -> [SCNNode]{
        
        var chapter1NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/AnthonyScene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "LVLContainer", recursively: true)
        storyNode.scale = SCNVector3(1, 1, 1)
        storyNode.position = SCNVector3(0, 0, 0)
        //storyNode.isHidden = true
        
        //Load Idle Animation Node
        let idleAnthonyScene = SCNScene(named: "art.scnassets/Anthony@Idle.scn")!
        for child in idleAnthonyScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.02, 0.02, 0.02)
        idleNode.position = SCNVector3(0, 0, 0)
        //idleNode.isHidden = true
        
        //Load walking Animation Node
        let walkingAnthonyScene = SCNScene(named: "art.scnassets/Anthony@Walk.scn")!
        for child in walkingAnthonyScene.rootNode.childNodes {
            walkingNode.addChildNode(child)
        }
        storyNode.addChildNode(walkingNode)
        walkingNode.position = SCNVector3(0, 0, 0)
        walkingNode.scale = SCNVector3(0.02, 0.02, 0.02)
        //walkingNode.isHidden = true
        
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
            letterANode.addChildNode(child)
        }
        letterANode.position = SCNVector3(-13.879, -1, 12)
        //letterANode.eulerAngles = SCNVector3(0, 0, 0)
        letterANode.scale = SCNVector3(1.75, 1.75, 1.75)
        //letterANode.renderingOrder = -5
        
        storyNode.childNode(withName: "LVLFloor", recursively: true)!.addChildNode(letterANode)
        
        //chapter1NodeArray.append(focusNode)
        chapter1NodeArray.append(storyNode)
        
        return chapter1NodeArray
    
        
        //build out all chapter 1 sounds
        
        //build out all chapter 1 narrations
    }
    
    //chapter 2 stuff here
    func loadChapter2Files () -> [SCNNode]{
        //var array of chapter 2 assest
        var chapter2NodeArray: [SCNNode] = []
        
        //build out all chapter 2 assests
        //load all chapter 2 assets into the assets var array
        
        
        //build out all chapter 2 sounds
        
        //build out all chapter 2 narrations
        
        return chapter2NodeArray
    }
    
    //chapter 3 stuff here
    func loadChapter3Files () -> [SCNNode]{
        //var array of chapter 3 assest
        var chapter3NodeArray: [SCNNode] = []
        
        //build out all chapter 3 assests
        //load all chapter 3 assets into the assets var array
        
        
        //build out all chapter 3 sounds
        
        //build out all chapter 3 narrations
        
         return chapter3NodeArray
    }
    
    //chapter 4 stuff here
    func loadChapter4Files () -> [SCNNode]{
        //var array of chapter 4 assest
        var chapter4NodeArray: [SCNNode] = []
        
        //build out all chapter 4 assests
        //load all chapter 4 assets into the assets var array
        
        //build out all chapter 4 sounds
        
        //build out all chapter 4 narrations
        
        return chapter4NodeArray
    }
    
    //chapter 5 stuff here
    func loadChapter5Files () -> [SCNNode]{
        //var array of chapter 5 assest
        var chapter5NodeArray: [SCNNode] = []
        
        //build out all chapter 5 assests
        //load all chapter 5 assets into the assets var array
        
        //build out all chapter 5 sounds
        
        //build out all chapter 5 narrations
        
        return chapter5NodeArray
    }
    
    //chapter 6 stuff here
    func loadChapter6Files () -> [SCNNode]{
        //var array of chapter 6 assest
        var chapter6NodeArray: [SCNNode] = []
        
        //build out all chapter 6 assests
        //load all chapter 6 assets into the assets var array
        
        //build out all chapter 6 sounds
        
        //build out all chapter 6 narrations
        
        return chapter6NodeArray
    }
    
    //chapter 7 stuff here
    func loadChapter7Files () -> [SCNNode]{
        //var array of chapter 7 assest
        var chapter7NodeArray: [SCNNode] = []
        
        //build out all chapter 7 assests
        //load all chapter 7 assets into the assets var array
        
        //build out all chapter 7 sounds
        
        //build out all chapter 7 narrations
        
        return chapter7NodeArray
    }
    
    //chapter 8 stuff here
    func loadChapter8Files () -> [SCNNode]{
        //var array of chapter 8 assest
        var chapter8NodeArray: [SCNNode] = []
        
        //build out all chapter 8 assests
        //load all chapter 8 assets into the assets var array
        
        //build out all chapter 8 sounds
        
        //build out all chapter 8 narrations
        
        return chapter8NodeArray
    }
    
    //chapter 9 stuff here
    func loadChapter9Files () -> [SCNNode]{
        //var array of chapter 9 assest
        var chapter9NodeArray: [SCNNode] = []
        
        //build out all chapter 9 assests
        //load all chapter 9 assets into the assets var array
        
        //build out all chapter 9 sounds
        
        //build out all chapter 9 narrations
        
        return chapter9NodeArray
    }
    
    //chapter 10 stuff here
    func loadChapter10Files () -> [SCNNode]{
        //var array of chapter 10 assest
        var chapter10NodeArray: [SCNNode] = []
        
        //build out all chapter 10 assests
        //load all chapter 10 assets into the assets var array
        
        //build out all chapter 10 sounds
        
        //build out all chapter 10 narrations
        
        return chapter10NodeArray
    }
}
