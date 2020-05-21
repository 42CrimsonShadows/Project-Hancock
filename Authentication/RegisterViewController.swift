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
    
    
    @IBAction func RequestRegistration(_ sender: Any) {
        print("Attempting to Register")
        guard let username = UsernameField.text else { return }
        guard let email = PEmailField.text else { return }
        guard let pass = PassField.text else { return }
        guard let first = FirstNameField.text else { return }
        guard let last = LastNameField.text else { return }
        
        Service.register(firstName: first, lastName: last, email: email, username: username, password: pass)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

