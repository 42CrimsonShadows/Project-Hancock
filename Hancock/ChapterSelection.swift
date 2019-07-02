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

class ChapterSelection {
    
    var storyNode: SCNNode!
    var groundNode: SCNNode!
    let maskingNode = SCNNode()
    let idleNode = SCNNode()
    let walkingNode = SCNNode()
    let animationNode = SCNNode()
    let letterANode = SCNNode()
    
    
    //chapter 1 stuff here
    func loadChapter1Files () -> [SCNNode]{
        
        var chapter1NodeArray: [SCNNode] = []
        
        // Load StoryScene Node
        let storyScene = SCNScene(named: "art.scnassets/AnthonyScene.scn")!
        storyNode = storyScene.rootNode.childNode(withName: "anthony", recursively: true)
        storyNode.scale = SCNVector3(1, 1, 1)
        storyNode.position = SCNVector3(0, -10, 0)
        storyNode.isHidden = true
        
        //Load Idle Animation Node
        let idleAnthonyScene = SCNScene(named: "art.scnassets/Anthony@Idle.scn")!
        for child in idleAnthonyScene.rootNode.childNodes {
            idleNode.addChildNode(child)
        }
        storyNode.addChildNode(idleNode)
        idleNode.scale = SCNVector3(0.02, 0.02, 0.02)
        walkingNode.position = SCNVector3(0, 0, 0)
        idleNode.isHidden = true
        
        //Load walking Animation Node
        let walkingAnthonyScene = SCNScene(named: "art.scnassets/Anthony@Walk.scn")!
        for child in walkingAnthonyScene.rootNode.childNodes {
            walkingNode.addChildNode(child)
        }
        storyNode.addChildNode(walkingNode)
        walkingNode.position = SCNVector3(0, 0, 0)
        walkingNode.scale = SCNVector3(0.02, 0.02, 0.02)
        walkingNode.isHidden = true
        
        //Load Scene Mask so we only see immidate area
        let maskingScene = SCNScene(named: "art.scnassets/MaskScene.scn")!
        for child in maskingScene.rootNode.childNodes {
            maskingNode.addChildNode(child)
        }
        //maskingNode.position = SCNVector3(0, 0, 0)
        //maskingNode.scale = SCNVector3(1, 1, 1)
        maskingNode.renderingOrder = -2
        storyNode.addChildNode(maskingNode)
        
        //Load the shattering A scn into the BugScene
        let shatterAScene = SCNScene(named: "art.scnassets/LetterA@Shatter.scn")!
        for child in shatterAScene.rootNode.childNodes {
            letterANode.addChildNode(child)
        }
        letterANode.position = SCNVector3(-13.879, -1, 12)
        //letterANode.eulerAngles = SCNVector3(0, 0, 0)
        letterANode.scale = SCNVector3(1.75, 1.75, 1.75)
        //letterANode.renderingOrder = -5
        
        storyNode.childNode(withName: "BUGScene", recursively: true)!.addChildNode(letterANode)
        
        //chapter1NodeArray.append(focusNode)
        chapter1NodeArray.append(storyNode)
        chapter1NodeArray.append(maskingNode)
        
        return chapter1NodeArray
        
        //build out all chapter 1 sounds
        
        //build out all chapter 1 narrations
    }
    
    //chapter 2 stuff here
    func loadChapter2Files (){
        //var array of chapter 2 assest
        
        //build out all chapter 2 assests
        //load all chapter 2 assets into the assets var array
        
        //build out all chapter 2 sounds
        
        //build out all chapter 2 narrations
    }
    
    //chapter 3 stuff here
    func loadChapter3Files (){
        //var array of chapter 3 assest
        
        //build out all chapter 3 assests
        //load all chapter 3 assets into the assets var array
        
        //build out all chapter 3 sounds
        
        //build out all chapter 3 narrations
    }
    
    //chapter 4 stuff here
    func loadChapter4Files (){
        //var array of chapter 4 assest
        
        //build out all chapter 4 assests
        //load all chapter 4 assets into the assets var array
        
        //build out all chapter 4 sounds
        
        //build out all chapter 4 narrations
    }
    
    //chapter 5 stuff here
    func loadChapter5Files (){
        //var array of chapter 5 assest
        
        //build out all chapter 5 assests
        //load all chapter 5 assets into the assets var array
        
        //build out all chapter 5 sounds
        
        //build out all chapter 5 narrations
    }
    
    //chapter 6 stuff here
    func loadChapter6Files (){
        //var array of chapter 6 assest
        
        //build out all chapter 6 assests
        //load all chapter 6 assets into the assets var array
        
        //build out all chapter 6 sounds
        
        //build out all chapter 6 narrations
    }
    
    //chapter 7 stuff here
    func loadChapter7Files (){
        //var array of chapter 7 assest
        
        //build out all chapter 7 assests
        //load all chapter 7 assets into the assets var array
        
        //build out all chapter 7 sounds
        
        //build out all chapter 7 narrations
    }
    
    //chapter 8 stuff here
    func loadChapter8Files (){
        //var array of chapter 8 assest
        
        //build out all chapter 8 assests
        //load all chapter 8 assets into the assets var array
        
        //build out all chapter 8 sounds
        
        //build out all chapter 8 narrations
    }
    
    //chapter 9 stuff here
    func loadChapter9Files (){
        //var array of chapter 9 assest
        
        //build out all chapter 9 assests
        //load all chapter 9 assets into the assets var array
        
        //build out all chapter 9 sounds
        
        //build out all chapter 9 narrations
    }
    
    //chapter 10 stuff here
    func loadChapter10Files (){
        //var array of chapter 10 assest
        
        //build out all chapter 10 assests
        //load all chapter 10 assets into the assets var array
        
        //build out all chapter 10 sounds
        
        //build out all chapter 10 narrations
    }
}
