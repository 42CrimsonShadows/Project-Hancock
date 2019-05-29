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
    
    var SMSUpdates: Bool = true
    var isTeacher: Bool = false
    
    @IBAction func RequestSMSInfo(_ sender: Any) {
        print("User requested more info about SMS Updates")
    }
    
    @IBAction func RequestRegistration(_ sender: Any) {
        print("Attempting to Register")
    }
    
    @IBAction func SMSUpdatesBool(_ sender: Any) {
        
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
    
    @IBAction func TeacherStudentBool(_ sender: Any) {
        
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
