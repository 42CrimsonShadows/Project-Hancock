//
//  SignInViewController.swift
//  Hancock
//
//  Created by Casey on 5/29/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit

public var user = ""
public var pass = ""

class SignInViewController: UIViewController {

    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    var success = false
    
    @IBAction func ForgotPasswordPopup(_ sender: UIButton) {
        print("forgot password?")
    }
    @IBAction func Login(_ sender: Any) {
        
    print("Logging in...")
        guard let username = IDField.text else { return }
        guard let password = PassField.text else { return }
        
//        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
//            if error == nil && Auth.auth().currentUser != nil {
//
//                self.dismiss(animated: false, completion: nil)
//                print("Welcome", Auth.auth().currentUser?.email)
//
//            } else {
//                print("There was an issue logging in")
//
//            }
//        }
        
        Service.login(username:username, password:password) {(isSuccess) in self.success = isSuccess
            DispatchQueue.main.async{
                self.doSegue(username: username, password:password)
            }
        }
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        print("Loading Registration Forms...")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func doSegue(username: String, password: String)
    {
        if(success)
        {
            ErrorLabel.text = ""

            if(user == "" && pass == "")
            {
                user = username
                pass = password
                print("LOGIN")
                self.performSegue(withIdentifier: "toHomePage", sender: self)
            }
        }
        else
        {
            print("Invalid Username or Password")
            ErrorLabel.text = "Invalid Username or Password"
        }
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

