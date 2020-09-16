//
//  PuzzleViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 8/17/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
    private var chapter:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func chapterPressed(_ sender: UIButton) {
        
        switch sender.currentTitle {
            case "Chapter1":
                chapter = 1
            case "Chapter2":
                chapter = 2
            case "Chapter3":
                chapter = 3
            case "Chapter4":
                chapter = 4
            case "Chapter5":
                chapter = 5
            case "Chapter6":
                chapter = 6
            case "Chapter7":
                chapter = 7
            case "Chapter8":
                chapter = 8
            case "Chapter9":
                chapter = 9
            case "Chapter10":
                chapter = 10
            default:
                chapter = 1
        }
        self.performSegue(withIdentifier: "assessmentPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AssessmentSelection {
            destination.selectedChapter = chapter!
        }
    }
}
