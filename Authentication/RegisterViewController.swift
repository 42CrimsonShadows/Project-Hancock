//
//  RegisterViewController.swift
//  Hancock
//
//  Created by Casey on 5/29/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    @IBOutlet weak var CPassField: UITextField!
    @IBOutlet weak var SchoolIDField: UITextField!
    @IBOutlet weak var TeacherIDField: UITextField!
    @IBOutlet weak var PEmailField: UITextField!
    @IBOutlet weak var PNumField: UITextField!
    
    @IBOutlet weak var SMSLabel: UILabel!
    @IBOutlet weak var TeacherLabel: UILabel!
    @IBOutlet weak var StudentLabel: UILabel!
    
    @IBAction func RequestSMSInfo(_ sender: Any) {
    }
    
    @IBAction func RequestRegistration(_ sender: Any) {
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
