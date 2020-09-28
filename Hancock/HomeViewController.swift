import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var upperCaseImage: UIImageView!
    @IBOutlet weak var lowerCaseImage: UIImageView!
    @IBOutlet weak var PracticeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lock rotation
        AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
        //set up to perform segue programmatically
        let tap1 =  UITapGestureRecognizer(target: self, action: #selector(tappedUpper))
        let tap2 =  UITapGestureRecognizer(target: self, action: #selector(tappedLower))
        let tap3 =  UITapGestureRecognizer(target: self, action: #selector(tappedLine))
        upperCaseImage.isUserInteractionEnabled = true
        upperCaseImage.addGestureRecognizer(tap1)
        
        lowerCaseImage.isUserInteractionEnabled = true
        lowerCaseImage.addGestureRecognizer(tap2)
        
        PracticeImage.isUserInteractionEnabled = true
        PracticeImage.addGestureRecognizer(tap3)
    }
    
    @IBAction func logoutHandler(_ sender: Any) {
//        try! Auth.auth().signOut()
        print("Successfully logged out")
        user = ""
        pass = ""
        performSegue(withIdentifier: "backToLogin", sender: self)
    }
    
    @objc func tappedUpper(){
        //action to perform segue
        performSegue(withIdentifier: "toChapterPageUpper", sender: self)
    }
    @objc func tappedLower(){
        //action to perform segue
        performSegue(withIdentifier: "toChapterPageLower", sender: self)
    }
    @objc func tappedLine(){
        //action to perform segue
        performSegue(withIdentifier: "toPracticePage", sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Don't forget to reset when view is being removed
//        AppDelegate.AppUtility.lockOrientation(.all)
    }

}
