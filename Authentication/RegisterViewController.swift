//
//  RegisterViewController.swift
//  Hancock
//
//  Created by Casey on 5/29/19.
//  Copyright © 2019 Chris Ross. All rights reserved.
//

import UIKit
//import Firebase

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
    
    var SMSUpdates: Bool = true
    var isTeacher: Bool = false
    
    @IBAction func RequestSMSInfo(_ sender: Any) {
        print("User requested more info about SMS Updates")
    }
    
    @IBAction func RequestRegistration(_ sender: Any) {
        print("Attempting to Register")
        guard let username = UsernameField.text else { return }
        guard let email = PEmailField.text else { return }
        guard let pass = PassField.text else { return }
        
//        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
//            if error == nil && user != nil {
//                print("The User was Created")
//
//                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                changeRequest?.displayName = username
//                changeRequest?.commitChanges { error in
//                    if error == nil {
//                        print("displayName has been changed")
//                        self.dismiss(animated: false, completion: nil)
//                    }
//                }
//            }else {
//                print("Error Creating the user: \(error!.localizedDescription)")
//            }
//
//        }
//
//    }
    
        func SMSUpdatesBool(_ sender: Any) {
        
        if SMSUpdates {
            print("User would no longer like SMSUpdates")
            self.SMSUpdates = false
            SMSLabel.text = "No"
            SMSLabel.textColor = UIColor.gray
        }else {
            print("User would like SMSUpdates")
            self.SMSUpdates = true
            SMSLabel.text = "Yes"
            SMSLabel.textColor = UIColor.blue
        }
    }
    
    func TeacherStudentBool(_ sender: Any) {
        
        if isTeacher {
            print("The user is a Student")
            isTeacher = false
            StudentLabel.textColor = UIColor.blue
            TeacherLabel.textColor = UIColor.gray
        }else {
            print("The user is a Teacher")
            isTeacher = true
            TeacherLabel.textColor = UIColor.blue
            StudentLabel.textColor = UIColor.gray
        }
    }
    
    func viewDidLoad() {
        super.viewDidLoad()

    }

}
}
