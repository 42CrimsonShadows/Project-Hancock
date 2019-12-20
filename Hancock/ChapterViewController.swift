
import UIKit

var chapterOne: Bool = false
var chapterTwo: Bool = false
var chapterThree: Bool = false
var chapterFour: Bool = false
var chapterFive: Bool = false

class ChapterViewController: UIViewController {
    
    let chapterSelector = ChapterSelection()
    
    //ref to the UIImageVIEW on the storyboard
    @IBOutlet weak var GifView: UIImageView!
    @IBOutlet weak var conceptView: UIImageView!
    @IBOutlet weak var loadingGifView: UIImageView!    
    @IBOutlet weak var chapter1Label: UIButton!
    @IBOutlet weak var chapter2Label: UIButton!
    @IBOutlet weak var chapter3Label: UIButton!
    @IBOutlet weak var chapter4Label: UIButton!
    @IBOutlet weak var chapter5Label: UIButton!
    
//    let concept1 = UIImage (imageLiteralResourceName: "concept1")
//    let concept2 = UIImage (imageLiteralResourceName: "concept2")
    let concept3 = UIImage (imageLiteralResourceName: "concept3")
    let concept4 = UIImage (imageLiteralResourceName: "concept4")
//    let concept5 = UIImage (imageLiteralResourceName: "concept5")
//    let concept6 = UIImage (imageLiteralResourceName: "concept6")
//    let concept7 = UIImage (imageLiteralResourceName: "concept7")
//    let concept8 = UIImage (imageLiteralResourceName: "concept8")
//    let concept9 = UIImage (imageLiteralResourceName: "concept9")
//    let concept10 = UIImage (imageLiteralResourceName: "concept10")
    
    @IBAction func cpt1Clicked(_ sender: Any) {
        chapterOne = true
        chapterTwo = false
        chapterThree = false
        chapterFour = false
        chapterFive = false
        //conceptView.image = concept1
        chapterSelector.chapterLoader(picked: 1)
        tappedMe()
    }
    @IBAction func cpt2Clicked(_ sender: Any) {
        chapterOne = false
        chapterTwo = true
        chapterThree = false
        chapterFour = false
        chapterFive = false
        //conceptView.image = concept2
        chapterSelector.chapterLoader(picked: 2)
        tappedMe()
    }
    @IBAction func cpt3Clicked(_ sender: Any) {
        chapterOne = false
        chapterTwo = false
        chapterThree = true
        chapterFour = false
        chapterFive = false
        conceptView.image = concept3
        chapterSelector.chapterLoader(picked: 3)
        tappedMe()
    }
    @IBAction func cpt4Clicked(_ sender: Any) {
        chapterOne = false
        chapterTwo = false
        chapterThree = false
        chapterFour = true
        chapterFive = false
        conceptView.image = concept4
        chapterSelector.chapterLoader(picked: 4)
        tappedMe()
    }
    @IBAction func cpt5Clicked(_ sender: Any) {
        chapterOne = false
        chapterTwo = false
        chapterThree = false
        chapterFour = false
        chapterFive = true
        //conceptView.image = concept5
        chapterSelector.chapterLoader(picked: 5)
        tappedMe()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GifView.loadGif(name: "BookAnimation")
        
        loadingGifView.loadGif(name: "Loading")
        loadingGifView.isHidden = true
        conceptView.isHidden = true
        
        chapter1Label.isHidden = true
        chapter2Label.isHidden = true
        chapter3Label.isHidden = true
        chapter4Label.isHidden = true
        chapter5Label.isHidden = true
        
        pauseAfterPlay()
    }
    
    func pauseAfterPlay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.75, execute: {
            //self.GifView.stopAnimating()
            self.GifView.image = UIImage(named: "BookOpened")
            self.chapter1Label.isHidden = false
            
            //bing bing bing bing synchronous appearance
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.chapter2Label.isHidden = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.chapter3Label.isHidden = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        self.chapter4Label.isHidden = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            self.chapter5Label.isHidden = false
                        })
                    })
                })
            })
        })
    }
    
    func tappedMe(){
        switch true {
        case chapterOne:
            //chapterOneConceptImage = true
            print("chapter 1 loaded")
        case chapterTwo:
            //chapterOneConceptImage = true
            print("chapter 2 loaded")
        case chapterThree:
            //chapterOneConceptImage = true
            print("chapter 3 loaded")
        case chapterFour:
            //chapterOneConceptImage = true
            print("chapter 4 loaded")
        case chapterFive:
            //chapterOneConceptImage = true
            print("chapter 5 loaded")
        default:
            break
        }
        conceptView.isHidden = false
        loadingGifView.isHidden = false
        
        //self.GifView.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            let homeARView = self.storyboard?.instantiateViewController(withIdentifier: "HomeARViewController") as! ViewController
            self.present(homeARView, animated: true)
        })
    }
}
