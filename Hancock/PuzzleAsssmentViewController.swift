//
//  PuzzleAsssmentViewController.swift
//  Hancock
//
//  Created by Lauren  Matthews on 9/27/20.
//  Copyright © 2020 Chris Ross. All rights reserved.
//

import UIKit

class PuzzleAsssmentViewController: UIViewController {
    
    // chapter to send to AssessmentSelection
    private var chapter:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // pressed a chapter to load
    @IBAction func chapterPressed(_ sender: UIButton) {
        
        // set chapter based on title of the button pressed
        switch sender.currentTitle {
            case "I, T, L, F, E, H":
                chapter = 1
            case "P, R, B, C, D, U":
                chapter = 2
            case "G, O, Q, S, J":
                chapter = 3
            case "K, V, W, M, A":
                chapter = 4
            case "N, Z, Y, X":
                chapter = 5
            case "c, a, d, g, o":
                chapter = 6
            case "u, s, v, w, i, t":
                chapter = 7
            case "l, y, k, j, e":
                chapter = 8
            case "p, r, n, m, h, b":
                chapter = 9
            case "f, q, x, z":
                chapter = 10
            default:
                chapter = 1
        }
        // load assessment now that chapter is chosen
        self.performSegue(withIdentifier: "assessmentPage", sender: self)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        // dismiss brings us back to practice page
        self.dismiss(animated: false, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if destination is to AssessmentSelection set the selectedChapter to chapter
        if let destination = segue.destination as? AssessmentSelection {
            destination.selectedChapter = chapter!
        }
    }
}

