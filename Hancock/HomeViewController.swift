import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var upperCaseImage: UIImageView!
    @IBOutlet weak var lowerCaseImage: UIImageView!
    @IBOutlet weak var lineCaseImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up to perform segue programmatically
        let tap1 =  UITapGestureRecognizer(target: self, action: #selector(tappedUpper))
        let tap2 =  UITapGestureRecognizer(target: self, action: #selector(tappedLower))
        let tap3 =  UITapGestureRecognizer(target: self, action: #selector(tappedLine))
        upperCaseImage.isUserInteractionEnabled = true
        upperCaseImage.addGestureRecognizer(tap1)
        
        lowerCaseImage.isUserInteractionEnabled = true
        lowerCaseImage.addGestureRecognizer(tap2)
        
        lineCaseImage.isUserInteractionEnabled = true
        lineCaseImage.addGestureRecognizer(tap3)
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
        performSegue(withIdentifier: "toLinePage", sender: self)
    }
    
    @IBAction func letterMatchingTapped(_ sender: Any) {
        //action to perform segue
        performSegue(withIdentifier: "letterMatching", sender: self)
    }
    
}
