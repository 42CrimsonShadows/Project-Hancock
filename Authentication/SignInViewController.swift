//
//  SignInViewController.swift
//  Hancock
//
//  Created by Casey on 5/29/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    
    @IBAction func ForgotPasswordPopup(_ sender: UIButton) {
        print("forgot password?")
    }
    @IBAction func Login(_ sender: Any) {
        
    print("Logging in...")
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        print("Loading Registration Forms...")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
