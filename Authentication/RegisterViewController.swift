//
//  RegisterViewController.swift
//  Hancock
//
//  Created by Casey on 5/29/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {


    @IBOutlet weak var FirstNameField: UITextField!
    @IBOutlet weak var LastNameField: UITextField!
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    @IBOutlet weak var CPassField: UITextField!
    @IBOutlet weak var PEmailField: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    var success = false
    
    
    @IBAction func RequestRegistration(_ sender: Any) {
        print("Attempting to Register")
        if((UsernameField.text == "") || (FirstNameField.text == "") || (LastNameField.text == "") || (PassField.text == "") || (CPassField.text == "") || (PEmailField.text == ""))
        {
            print("Empty fields")
            ErrorLabel.text = "Must fill out all fields"
        }else {
            if(PassField.text != CPassField.text)
            {
                print("Passwords don't match")
                ErrorLabel.text = "Passwords need to match"
            }
            else{
                guard let username = UsernameField.text else { return }
                guard let email = PEmailField.text else { return }
                guard let password = PassField.text else { return }
                guard let first = FirstNameField.text else { return }
                guard let last = LastNameField.text else { return }
                Service.register(firstName: first, lastName: last, email: email, username: username, password: password) {(isSuccess) in self.success = isSuccess
                    DispatchQueue.main.async{
                        self.doSegue(username: username, password:password)
                    }
                }
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func doSegue(username: String, password: String)
    {
        if(success)
        {
            user = username
            pass = password
            print("REGISTER")
            ErrorLabel.text = ""
            self.performSegue(withIdentifier: "toLogin", sender: self)
        }
        else
        {
            print("Username already exists")
            ErrorLabel.text = "Username already exists"
        }
    }

}

