
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
    @IBOutlet weak var loadingGifView: UIImageView!    
    @IBOutlet weak var chapter1Label: UIButton!
    @IBOutlet weak var chapter2Label: UIButton!
    @IBOutlet weak var chapter3Label: UIButton!
    @IBOutlet weak var chapter4Label: UIButton!
    @IBOutlet weak var chapter5Label: UIButton!
    
    @IBAction func cpt1Clicked(_ sender: Any) {
        chapterOne = true
        chapterTwo = false
        chapterThree = false
        chapterFour = false
        chapterFive = false
        chapterSelector.chapterLoader(picked: 1)
        tappedMe()
    }
    @IBAction func cpt2Clicked(_ sender: Any) {
        chapterOne = false
        chapterTwo = true
        chapterThree = false
        chapterFour = false
        chapterFive = false
        chapterSelector.chapterLoader(picked: 2)
        tappedMe()
    }
    @IBAction func cpt3Clicked(_ sender: Any) {
        chapterOne = false
        chapterTwo = false
        chapterThree = true
        chapterFour = false
        chapterFive = false
        chapterSelector.chapterLoader(picked: 3)
        tappedMe()
    }
    @IBAction func cpt4Clicked(_ sender: Any) {
        chapterOne = false
        chapterTwo = false
        chapterThree = false
        chapterFour = true
        chapterFive = false
        chapterSelector.chapterLoader(picked: 4)
        tappedMe()
    }
    @IBAction func cpt5Clicked(_ sender: Any) {
        chapterOne = false
        chapterTwo = false
        chapterThree = false
        chapterFour = false
        chapterFive = true
        chapterSelector.chapterLoader(picked: 5)
        tappedMe()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GifView.loadGif(name: "BookAnimation")
        
        loadingGifView.loadGif(name: "Loading")
        loadingGifView.isHidden = true
        
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
        loadingGifView.isHidden = false
        
        //self.GifView.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            let homeARView = self.storyboard?.instantiateViewController(withIdentifier: "HomeARViewController") as! ViewController
            self.present(homeARView, animated: true)
        })
    }
}
