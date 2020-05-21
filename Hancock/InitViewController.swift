//
//  Created by Casey on 5/30/19.
//

import UIKit
//import Firebase

class InitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        //if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
            
        //}
    }

}
