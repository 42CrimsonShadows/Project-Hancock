//
//  ChapterViewController.swift
//  Hancock
//
//  Created by Chris Ross on 6/22/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit

class ChapterViewController: UIViewController {

    @IBOutlet weak var GifView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GifView.loadGif(name: "BookAnimation")
        
        //set up to perform segue programmatically
        let tap =  UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        GifView.isUserInteractionEnabled = true
        GifView.addGestureRecognizer(tap)
    }
    
    @objc func tappedMe(){
        
        self.GifView.stopAnimating()
        
        //action to perform segue
        performSegue(withIdentifier: "toARScenePage", sender: self)
    }
    
}
