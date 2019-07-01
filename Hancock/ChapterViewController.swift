//
//  ChapterViewController.swift
//  Hancock
//
//  Created by Chris Ross on 6/22/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//
import UIKit

class ChapterViewController: UIViewController {
    
    //ref to the UIImageVIEW on the storyboard
    @IBOutlet weak var GifView: UIImageView!
    @IBOutlet weak var loadingGifView: UIImageView!    
    @IBOutlet weak var chapter1Label: UIButton!
    @IBOutlet weak var chapter2Label: UIButton!
    @IBOutlet weak var chapter3Label: UIButton!
    @IBOutlet weak var chapter4Label: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GifView.loadGif(name: "BookAnimation")
        
        loadingGifView.loadGif(name: "Loading")
        loadingGifView.isHidden = true
        
        chapter1Label.isHidden = true
        chapter2Label.isHidden = true
        chapter3Label.isHidden = true
        chapter4Label.isHidden = true
        
        //set up to perform segue programmatically
        let tap =  UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        chapter1Label.isUserInteractionEnabled = true
        chapter1Label.addGestureRecognizer(tap)
        
        pauseAfterPlay()
    }
    
    func pauseAfterPlay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.75, execute: {
            //self.GifView.stopAnimating()
            self.GifView.image = UIImage(named: "BookOpened")
            self.chapter1Label.isHidden = false
            
            //bing bing bing bing synchronous appearance
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.chapter2Label.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.chapter3Label.isHidden = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        self.chapter4Label.isHidden = false
                    })
                })
            })
        })
    }
    
    @objc func tappedMe(){
        
        loadingGifView.isHidden = false
        
        //self.GifView.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.performSegue(withIdentifier: "toARScenePage", sender: self)
        })
    }
}
