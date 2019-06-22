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
    }
    
}
