
import UIKit

enum Chapter: Int {
    case MainMenu = 0
    case Chapter1 = 1
    case Chapter2 = 2
    case Chapter3 = 3
    case Chapter4 = 4
    case Chapter5 = 5
    case Chapter6 = 6
    case Chapter7 = 7
    case Chapter8 = 8
    case Chapter9 = 9
    case Chapter10 = 10
    case LineType1 = 11
    case LineType2 = 12
    case LineType3 = 13
    case LineType4 = 14
    case LineType5 = 15
    case LineType6 = 16
    case LineType7 = 17
    case LineType8 = 18
    case LineType9 = 19
}

var currentChapter: Chapter = .MainMenu

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
    @IBOutlet weak var chapter6Label: UIButton!
    @IBOutlet weak var chapter7Label: UIButton!
    @IBOutlet weak var chapter8Label: UIButton!
    @IBOutlet weak var chapter9Label: UIButton!
    @IBOutlet weak var chapter10Label: UIButton!
    @IBOutlet weak var linePracticeBackButton: UIButton!
    
    //not connecting the below - they make it take too long to load
    @IBOutlet weak var lineType1Label: UIButton!
    @IBOutlet weak var lineType2Label: UIButton!
    @IBOutlet weak var lineType3Label: UIButton!
    @IBOutlet weak var lineType4Label: UIButton!
    @IBOutlet weak var lineType5Label: UIButton!
    @IBOutlet weak var lineType6Label: UIButton!
    @IBOutlet weak var lineType7Label: UIButton!
    @IBOutlet weak var lineType8Label: UIButton!
    @IBOutlet weak var lineType9Label: UIButton!
        
    
//    let concept1 = UIImage (imageLiteralResourceName: "concept1")
//    let concept2 = UIImage (imageLiteralResourceName: "concept2")
    let concept3 = UIImage (imageLiteralResourceName: "concept3")
    let concept4 = UIImage (imageLiteralResourceName: "concept4")
    let concept5 = UIImage (imageLiteralResourceName: "concept5")
//    let concept6 = UIImage (imageLiteralResourceName: "concept6")
//    let concept7 = UIImage (imageLiteralResourceName: "concept7")
//    let concept8 = UIImage (imageLiteralResourceName: "concept8")
//    let concept9 = UIImage (imageLiteralResourceName: "concept9")
//    let concept10 = UIImage (imageLiteralResourceName: "concept10")
    
    @IBAction func linePracticeButtonTapped (_ sender: UIButton) {
        performSegue(withIdentifier: "practiceMainMenu", sender: self)
    }
    
    
    @IBAction func cpt1Clicked(_ sender: Any) {
        currentChapter = .Chapter1
        //conceptView.image = concept1
        chapterSelector.chapterLoader(picked: 1)
        tappedMe()
    }
    @IBAction func cpt2Clicked(_ sender: Any) {
        currentChapter = .Chapter2
        //conceptView.image = concept2
        chapterSelector.chapterLoader(picked: 2)
        tappedMe()
    }
    @IBAction func cpt3Clicked(_ sender: Any) {
        currentChapter = .Chapter3
        conceptView.image = concept3
        chapterSelector.chapterLoader(picked: 3)
        tappedMe()
    }
    @IBAction func cpt4Clicked(_ sender: Any) {
        currentChapter = .Chapter4
        conceptView.image = concept4
        chapterSelector.chapterLoader(picked: 4)
        tappedMe()
    }
    @IBAction func cpt5Clicked(_ sender: Any) {
        currentChapter = .Chapter5
        conceptView.image = concept5
        chapterSelector.chapterLoader(picked: 5)
        tappedMe()
    }
    @IBAction func cpt6Clicked(_ sender: Any) {
        currentChapter = .Chapter6
        //conceptView.image = concept6
        chapterSelector.chapterLoader(picked: 6)
        tappedMe()
    }
    @IBAction func cpt7Clicked(_ sender: Any) {
        currentChapter = .Chapter7
        //conceptView.image = concept7
        chapterSelector.chapterLoader(picked: 7)
        tappedMe()
    }
    @IBAction func cpt8Clicked(_ sender: Any) {
        currentChapter = .Chapter8
        //conceptView.image = concept8
        chapterSelector.chapterLoader(picked: 8)
        tappedMe()
    }
    @IBAction func cpt9Clicked(_ sender: Any) {
        currentChapter = .Chapter9
        //conceptView.image = concept9
        chapterSelector.chapterLoader(picked: 9)
        tappedMe()
    }
    @IBAction func cpt10Clicked(_ sender: Any) {
        currentChapter = .Chapter10
        //conceptView.image = concept10
        chapterSelector.chapterLoader(picked: 10)
        tappedMe()
    }
    
    
    @IBAction func lineType1Clicked(_ sender: Any) {
        currentChapter = .LineType1
        chapterSelector.chapterLoader(picked: 14)
        tappedThis()
    }
    @IBAction func lineType2Clicked(_ sender: Any) {
        currentChapter = .LineType2
        chapterSelector.chapterLoader(picked: 11)
        tappedThis()
    }
    @IBAction func lineType3Clicked(_ sender: Any) {
        currentChapter = .LineType3
        chapterSelector.chapterLoader(picked: 18)
        tappedThis()
    }
    @IBAction func lineType4Clicked(_ sender: Any) {
        currentChapter = .LineType4
        chapterSelector.chapterLoader(picked: 15)
        tappedThis()
    }
    @IBAction func lineType5Clicked(_ sender: Any) {
        currentChapter = .LineType5
        chapterSelector.chapterLoader(picked: 17)
        tappedThis()
    }
    @IBAction func lineType6Clicked(_ sender: Any) {
        currentChapter = .LineType6
        chapterSelector.chapterLoader(picked: 12)
        tappedThis()
    }
    @IBAction func lineType7Clicked(_ sender: Any) {
        currentChapter = .LineType7
        chapterSelector.chapterLoader(picked: 13)
        tappedThis()
    }
    @IBAction func lineType8Clicked(_ sender: Any) {
        currentChapter = .LineType8
        chapterSelector.chapterLoader(picked: 16)
        tappedThis()
    }
    @IBAction func lineType9Clicked(_ sender: Any) {
        currentChapter = .LineType9
        chapterSelector.chapterLoader(picked: 19)
        tappedThis()
    }
    
    
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GifView?.loadGif(name: "BookAnimation")
        
        loadingGifView?.loadGif(name: "FlowerLoading")
        loadingGifView?.isHidden = true
        conceptView?.isHidden = true
        
        chapter1Label?.isHidden = true
        chapter2Label?.isHidden = true
        chapter3Label?.isHidden = true
        chapter4Label?.isHidden = true
        chapter5Label?.isHidden = true
        chapter6Label?.isHidden = true
        chapter7Label?.isHidden = true
        chapter8Label?.isHidden = true
        chapter9Label?.isHidden = true
        chapter10Label?.isHidden = true
        lineType1Label?.isHidden = true
        lineType2Label?.isHidden = true
        lineType3Label?.isHidden = true
        lineType4Label?.isHidden = true
        lineType5Label?.isHidden = true
        lineType6Label?.isHidden = true
        lineType7Label?.isHidden = true
        lineType8Label?.isHidden = true
        lineType9Label?.isHidden = true
         
        
        pauseAfterPlay()
    }
    
    func pauseAfterPlay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.75, execute: {
            self.GifView?.stopAnimating()
           // self.GifView?.image = UIImage(named: "BookOpened")
            self.GifView?.image = UIImage(named: "LBookOpen")
            self.chapter1Label?.isHidden = false
            self.chapter6Label?.isHidden = false
            self.lineType1Label?.isHidden = false
            self.lineType2Label?.isHidden = false
            
            //bing bing bing bing synchronous appearance
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.chapter2Label?.isHidden = false
                self.chapter7Label?.isHidden = false
                self.lineType3Label?.isHidden = false
                self.lineType4Label?.isHidden = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.chapter3Label?.isHidden = false
                    self.chapter8Label?.isHidden = false
                    self.lineType5Label?.isHidden = false
                    self.lineType6Label?.isHidden = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        self.chapter4Label?.isHidden = false
                        self.chapter9Label?.isHidden = false
                        self.lineType7Label?.isHidden = false
                        self.lineType8Label?.isHidden = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            self.chapter5Label?.isHidden = false
                            self.chapter10Label?.isHidden = false
                            self.lineType9Label?.isHidden = false
                        })
                    })
                })
            })
        })
    }
    
    
    func tappedMe(){
        print("chapter " + String(currentChapter.rawValue) + " loaded")
        
        conceptView.isHidden = false
        loadingGifView.isHidden = false
        
        //self.GifView.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            let homeARView = self.storyboard?.instantiateViewController(withIdentifier: "HomeARViewController") as! ViewController
            self.present(homeARView, animated: true)
            
        })
    }
    
    func tappedThis(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            selectedActivity = chapterSelectedLetterArray![0]
            print("loadActivityLetter is loading ", chapterSelectedLetterArray![0])
            
            let activityBoardView = self.storyboard?.instantiateViewController(withIdentifier: "ActivityBoardViewController") as! activityViewController
            self.present(activityBoardView, animated: true)
        })
    }
}
