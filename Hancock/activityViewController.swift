
//MARK: -- Known Issues
/*
 
 1. User can touch the targetpoint and move on to next steps.
 */

//Mark: -- Current task
/*
 Major task: Making the activities Modular
 minor tasks:
 
 1. Moving from step to step properly.
 2. load underlays from the activity selection class
 3. setupCanvas(), setupAUnderlay(), setupGreenlines(), setupDotsImages() need to be modular
 */
import UIKit

// MARK: - Game State
public var selectedActivity = ""

public var totalCoins = 0
// total coins user can get on letter
public var coinsPossible: Int32 = 0
public var startTime = Date()

enum LetterState: Int16 {
    case P1_P2 //first line
    case P3_P4 //second
    case P5_P6 //third
    case P7_P8 //fourth
}

class activityViewController: UIViewController, UIPencilInteractionDelegate {
    
    // MARK: - VARIABLES
    
    private var useDebugDrawing = false
    public var activitySelection = ActivitySelection()
    
    private let reticleView: ReticleView = {
        let view = ReticleView(frame: CGRect.null)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        return view
    }()
    
    //New properties
    //@IBOutlet weak var debugButton: UIButton!
    //@IBOutlet weak var locationLabel: UILabel!
    //@IBOutlet weak var forceLabel: UILabel!
    //@IBOutlet weak var azimuthAngleLabel: UILabel!
    //@IBOutlet weak var azimuthUnitVectorLabel: UILabel!
    //@IBOutlet weak var altitudeAngleLabel: UILabel!
    //@IBOutlet weak var separatorView: UIView!
    
    //@IBOutlet private var gagueLabelCollection: [UILabel]!
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var antFace: UIImageView!
    @IBOutlet weak var grassImage: UIImageView!
    @IBOutlet weak var antChillImage: UIImageView!
    @IBOutlet weak var CoinCountLabel: UILabel!
    
    let BlueDotView: UIImageView = {
        //Add the Blue Dot image to the canvas
        let BlueDot = UIImage(named: "art.scnassets/DotImages/BlueDot.png")
        let BlueDotView = UIImageView(image: BlueDot)
        //this enables autolayout for our BlueDotView
        BlueDotView.translatesAutoresizingMaskIntoConstraints = false
        return BlueDotView
    }()
    var GreenDotView: UIImageView = {
        //Add the Green Dot image to the canvas
        let GreenDot = UIImage(named: "art.scnassets/DotImages/GreenDot.png")
        let GreenDotView = UIImageView(image: GreenDot)
        //this enables autolayout for our GreenDotView
        GreenDotView.translatesAutoresizingMaskIntoConstraints = false
        return GreenDotView
    }()
    let OrangeDotView: UIImageView = {
        //Add the Orange Dot image to the canvas
        let OrangeDot = UIImage(named: "art.scnassets/DotImages/OrangeDot.png")
        let OrangeDotView = UIImageView(image: OrangeDot)
        //this enables autolayout for our OrangeDotView
        OrangeDotView.translatesAutoresizingMaskIntoConstraints = false
        return OrangeDotView
    }()
    let PurpleDotView: UIImageView = {
        //Add the Purple Dot image to the canvas
        let PurpleDot = UIImage(named: "art.scnassets/DotImages/PurpleDot.png")
        let PurpleDotView = UIImageView(image: PurpleDot)
        //this enables autolayout for our PurpleDotView
        PurpleDotView.translatesAutoresizingMaskIntoConstraints = false
        return PurpleDotView
    }()
    let RedDotView: UIImageView = {
        //Add the Red Dot image to the canvas
        let RedDot = UIImage(named: "art.scnassets/DotImages/RedDot.png")
        let RedDotView = UIImageView(image: RedDot)
        //this enables autolayout for our RedDotView
        RedDotView.translatesAutoresizingMaskIntoConstraints = false
        return RedDotView
    }()
    let YellowDotView: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let YellowDot = UIImage(named: "art.scnassets/DotImages/YellowDot.png")
        let YellowDotView = UIImageView(image: YellowDot)
        //this enables autolayout for our YellowDotView
        YellowDotView.translatesAutoresizingMaskIntoConstraints = false
        return YellowDotView
    }()
    let PinkDotView: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let PinkDot = UIImage(named: "art.scnassets/DotImages/PinkDot.png")
        let PinkDotView = UIImageView(image: PinkDot)
        //this enables autolayout for our YellowDotView
        PinkDotView.translatesAutoresizingMaskIntoConstraints = false
        return PinkDotView
    }()
    let WhiteDotView: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let WhiteDot = UIImage(named: "art.scnassets/DotImages/WhiteDot.png")
        let WhiteDotView = UIImageView(image: WhiteDot)
        //this enables autolayout for our YellowDotView
        WhiteDotView.translatesAutoresizingMaskIntoConstraints = false
        return WhiteDotView
    }()
    let BlackDotView1: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let BlackDot1 = UIImage(named: "art.scnassets/UI-art/AnthonyCoin.png")
        let BlackDotView1 = UIImageView(image: BlackDot1)
        //this enables autolayout for our YellowDotView
        BlackDotView1.translatesAutoresizingMaskIntoConstraints = false
        return BlackDotView1
    }()
    let BlackDotView2: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let BlackDot2 = UIImage(named: "art.scnassets/UI-art/AnthonyCoin.png")
        let BlackDotView2 = UIImageView(image: BlackDot2)
        //this enables autolayout for our YellowDotView
        BlackDotView2.translatesAutoresizingMaskIntoConstraints = false
        return BlackDotView2
    }()
    let BlackDotView3: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let BlackDot3 = UIImage(named: "art.scnassets/UI-art/AnthonyCoin.png")
        let BlackDotView3 = UIImageView(image: BlackDot3)
        //this enables autolayout for our YellowDotView
        BlackDotView3.translatesAutoresizingMaskIntoConstraints = false
        return BlackDotView3
    }()
    let BlackDotView4: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let BlackDot4 = UIImage(named: "art.scnassets/UI-art/AnthonyCoin.png")
        let BlackDotView4 = UIImageView(image: BlackDot4)
        //this enables autolayout for our YellowDotView
        BlackDotView4.translatesAutoresizingMaskIntoConstraints = false
        return BlackDotView4
    }()
    let BlackDotView5: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let BlackDot5 = UIImage(named: "art.scnassets/UI-art/AnthonyCoin.png")
        let BlackDotView5 = UIImageView(image: BlackDot5)
        //this enables autolayout for our YellowDotView
        BlackDotView5.translatesAutoresizingMaskIntoConstraints = false
        return BlackDotView5
    }()
    let BlackDotView6: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let BlackDot6 = UIImage(named: "art.scnassets/UI-art/AnthonyCoin.png")
        let BlackDotView6 = UIImageView(image: BlackDot6)
        //this enables autolayout for our YellowDotView
        BlackDotView6.translatesAutoresizingMaskIntoConstraints = false
        return BlackDotView6
    }()
    let BlackDotView7: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let BlackDot7 = UIImage(named: "art.scnassets/UI-art/AnthonyCoin.png")
        let BlackDotView7 = UIImageView(image: BlackDot7)
        //this enables autolayout for our YellowDotView
        BlackDotView7.translatesAutoresizingMaskIntoConstraints = false
        return BlackDotView7
    }()
    let BlackDotView8: UIImageView = {
        //Add the Yellow Dot image to the canvas
        let BlackDot8 = UIImage(named: "art.scnassets/UI-art/AnthonyCoin.png")
        let BlackDotView8 = UIImageView(image: BlackDot8)
        //this enables autolayout for our YellowDotView
        BlackDotView8.translatesAutoresizingMaskIntoConstraints = false
        return BlackDotView8
    }()
    
    
    //MARK: - ACTIONS
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        print(self)
    }
    //    @IBAction func undoButton(_ sender: Any) {
    //        canvasView.lines.removeAll()
    //        canvasView.checkpointLines.removeAll()
    //        canvasView.setNeedsDisplay()
    //    }
    
    //MARK: - VIEWDIDLOAD & SETUP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.addSubview(reticleView)
        
        //to toggle on on start, uncomment this line
        //toggleDebugDrawing(debugButton)
        
        clearGagues()
        
        if #available(iOS 12.0, *) {
            let pencilInteraction = UIPencilInteraction()
            pencilInteraction.delegate = self
            view.addInteraction(pencilInteraction)
        }
        setupCoinLabel()
        setupCanvas()
        //setupGreenlines() ----- For setting up letter craked images to be shown/hidden
        loadActivity()
        setupUnderlay()
        setupDotsImages()
        setupMiddleDots()
        
        //load animations
        antChillImage.loadGif(name: "Anthony-Chillaxing") //can be set to different images for different chapters
        grassImage.loadGif(name: "Grass-Blowing")
        
        antFace.isHidden = true
        
        //antChillImage.contentMode = .scaleAspectFit
        //antChillImage.backgroundColor = UIColor.lightGray
        //grassImage.contentMode = .scaleAspectFit
        //grassImage.backgroundColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("*** ViewWillAppear()")
        
        //set the first line active
        canvasView.Line1 = true
        canvasView.Line2 = false
        canvasView.Line3 = false
        canvasView.Line4 = false
        
        //FIXME: if the chapter is one of the line chapters play the first narration
        if (selectedActivity == "-" || selectedActivity == "/" || selectedActivity == "|" || selectedActivity == "'\'" || selectedActivity == "cross+" || selectedActivity == "crossx" || selectedActivity == "square" || selectedActivity == "circle" || selectedActivity == "triangle"){
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.canvasView.playAudioNarrationFile(file: chapterSelectedSoundDict!["GreenToRed"]!, type: "mp3")
            })
        }
        
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            //play the pulsate animation for the first dot
            self.canvasView.greenDot?.pulsate(duration: 0.6)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                //play the pulsate animation for the second dot
                self.canvasView.redDot?.pulsate(duration: 0.6)
            })
        })
    }
    
    
    //MARK: -- Changes 1
    private func setupCanvas() {
        //Add the drawing canvas to the UIView
        //view.addSubview(canvas)
        canvasView.backgroundColor = UIColor(white: 0.5, alpha: 0)
        //this enables autolayout for our canvas
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        print(view.center)
        print(canvasView.center)
        canvasView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        canvasView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        canvasView.heightAnchor.constraint(equalToConstant: 900).isActive = true
    }
    
    private func setupUnderlay() {
        //Add the letter A underlay image to the UIView under the canvas
        view.insertSubview(letterUnderlay, belowSubview: canvasView)
        letterUnderlay.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
        letterUnderlay.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
        letterUnderlay.widthAnchor.constraint(equalToConstant: 600).isActive = true
        letterUnderlay.heightAnchor.constraint(equalToConstant: 900).isActive = true
    }
    
    //    public func setupGreenlines() {
    //        //Add the letter A1 green line to the UIView under the canvas
    //        view.insertSubview(A1UnderlayView, belowSubview: canvasView)
    //        A1UnderlayView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
    //        A1UnderlayView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
    //        A1UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
    //        A1UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
    //        A1UnderlayView.isHidden = true
    //
    //        canvasView.A1GreenLine = A1UnderlayView
    //
    //        //Add the letter A2 green line to the UIView under the canvas
    //        view.insertSubview(A2UnderlayView, belowSubview: canvasView)
    //        A2UnderlayView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
    //        A2UnderlayView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
    //        A2UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
    //        A2UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
    //        A2UnderlayView.isHidden = true
    //
    //        canvasView.A2GreenLine = A2UnderlayView
    //
    //        //Add the letter A3 green line to the UIView under the canvas
    //        view.insertSubview(A3UnderlayView, belowSubview: canvasView)
    //        A3UnderlayView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor).isActive = true
    //        A3UnderlayView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor).isActive = true
    //        A3UnderlayView.widthAnchor.constraint(equalToConstant: 600).isActive = true
    //        A3UnderlayView.heightAnchor.constraint(equalToConstant: 900).isActive = true
    //        A3UnderlayView.isHidden = true
    //
    //        canvasView.A3GreenLine = A3UnderlayView
    //    }
    
    
    
    
    public func setupDotsImages() {
        var greenDot1 = CGPoint(x: 600 * activityPoints[0][0], y: 900 * activityPoints[0][1])
        var redDot2 = CGPoint(x: 600 * activityPoints[3][0], y: 900 * activityPoints[3][1])
        var blueDot4: CGPoint?
        var orangeDot5: CGPoint?
        var purpleDot6: CGPoint?
        var yellowDot7: CGPoint?
        var PinkDot8: CGPoint?
        var WhiteDot9: CGPoint?
        
        let dotArraySize = activityPoints.count
        
        //if there is more than one line...
        if dotArraySize > 4 {
            blueDot4 = CGPoint(x: 600 * activityPoints[4][0], y: 900 * activityPoints[4][1])
            orangeDot5 = CGPoint(x: 600 * activityPoints[7][0], y: 900 * activityPoints[7][1])
            
            //if there is more than two lines
            if dotArraySize > 8 {
                yellowDot7 = CGPoint(x: 600 * activityPoints[8][0], y: 900 * activityPoints[8][1])
                purpleDot6 = CGPoint(x: 600 * activityPoints[11][0], y: 900 * activityPoints[11][1])
                
                //if there is more than three lines
                if dotArraySize > 12 {
                    PinkDot8 = CGPoint(x: 600 * activityPoints[12][0], y: 900 * activityPoints[12][1])
                    WhiteDot9 = CGPoint(x: 600 * activityPoints[15][0], y: 900 * activityPoints[15][1])

                }
            }
        }
        //Set up GREEN dot
        view.insertSubview(GreenDotView, belowSubview: canvasView)
        GreenDotView.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: greenDot1.x).isActive = true
        GreenDotView.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: greenDot1.y).isActive = true
        GreenDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        GreenDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        GreenDotView.isHidden = true
        canvasView.greenDot = GreenDotView
        
        //Set up RED dot
        view.insertSubview(RedDotView, belowSubview: canvasView)
        RedDotView.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: redDot2.x).isActive = true
        RedDotView.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: redDot2.y).isActive = true
        RedDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        RedDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        RedDotView.isHidden = true
        canvasView.redDot = RedDotView
        
        //Set up BLUE dot
        view.insertSubview(BlueDotView, belowSubview: canvasView)
        BlueDotView.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant:  blueDot4?.x ?? 0).isActive = true
        BlueDotView.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: blueDot4?.y ?? 0).isActive = true
        BlueDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        BlueDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        BlueDotView.isHidden = true
        canvasView.blueDot = BlueDotView
        
        ////Set up Orange dot
        view.insertSubview(OrangeDotView, belowSubview: canvasView)
        OrangeDotView.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: orangeDot5?.x ?? 0).isActive = true
        OrangeDotView.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: orangeDot5?.y ?? 0).isActive = true
        OrangeDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        OrangeDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        OrangeDotView.isHidden = true
        canvasView.orangeDot = OrangeDotView
        
        //Set up PURPLE dot
        view.insertSubview(PurpleDotView, belowSubview: canvasView)
        PurpleDotView.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: purpleDot6?.x ?? 0).isActive = true
        PurpleDotView.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: purpleDot6?.y ?? 0).isActive = true
        PurpleDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        PurpleDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        PurpleDotView.isHidden = true
        canvasView.purpleDot = PurpleDotView
        
        //Set up Yellow dot
        view.insertSubview(YellowDotView, belowSubview: canvasView)
        YellowDotView.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: yellowDot7?.x ?? 0).isActive = true
        YellowDotView.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: yellowDot7?.y ?? 0).isActive = true
        YellowDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        YellowDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        YellowDotView.isHidden = true
        canvasView.yellowDot = YellowDotView
        
        //Set up Pink dot
        view.insertSubview(PinkDotView, belowSubview: canvasView)
        PinkDotView.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: PinkDot8?.x ?? 0).isActive = true
        PinkDotView.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: PinkDot8?.y ?? 0).isActive = true
        PinkDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        PinkDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        PinkDotView.isHidden = true
        canvasView.pinkDot = PinkDotView
        
        //set up white dot
        view.insertSubview(WhiteDotView, belowSubview: canvasView)
        WhiteDotView.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: WhiteDot9?.x ?? 0).isActive = true
        WhiteDotView.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: WhiteDot9?.y ?? 0).isActive = true
        WhiteDotView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        WhiteDotView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        WhiteDotView.isHidden = true
        canvasView.whiteDot = WhiteDotView
    }
    
    public func setupMiddleDots(){
        print("******Setting up Middle Dots*******")
        
        var coin1 = CGPoint(x: 600 * activityPoints[1][0], y: 900 * activityPoints[1][1])
        var coin2 = CGPoint(x: 600 * activityPoints[2][0], y: 900 * activityPoints[2][1])
        var coin3: CGPoint?
        var coin4: CGPoint?
        var coin5: CGPoint?
        var coin6: CGPoint?
        var coin7: CGPoint?
        var coin8: CGPoint?
        
        let coinArraySize = activityPoints.count
        
        //if there is more than one line...
        if coinArraySize > 4 {
            coin3 = CGPoint(x: 600 * activityPoints[5][0], y: 900 * activityPoints[5][1])
            coin4 = CGPoint(x: 600 * activityPoints[6][0], y: 900 * activityPoints[6][1])
            
            //if there is more than two lines
            if coinArraySize > 8 {
                coin5 = CGPoint(x: 600 * activityPoints[9][0], y: 900 * activityPoints[9][1])
                coin6 = CGPoint(x: 600 * (activityPoints[10][0]), y: 900 * activityPoints[10][1])
                
                //if there is more than three lines
                if coinArraySize > 12 {
                    coin7 = CGPoint(x: 600 * activityPoints[13][0], y: 900 * activityPoints[13][1])
                    coin8 = CGPoint(x: 600 * activityPoints[14][0], y: 900 * activityPoints[14][1])
                }
            }
        }
        
        //set up black dot 1
        view.insertSubview(BlackDotView1, belowSubview: canvasView)
        BlackDotView1.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: coin1.x).isActive = true
        BlackDotView1.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: coin1.y).isActive = true
        BlackDotView1.widthAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView1.heightAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView1.isHidden = true
        canvasView.blackDot1 = BlackDotView1
        
        //set up black dot 2
        view.insertSubview(BlackDotView2, belowSubview: canvasView)
        BlackDotView2.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: coin2.x).isActive = true
        BlackDotView2.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: coin2.y).isActive = true
        BlackDotView2.widthAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView2.heightAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView2.isHidden = true
        canvasView.blackDot2 = BlackDotView2
        
        //set up black dot 3
        view.insertSubview(BlackDotView3, belowSubview: canvasView)
        BlackDotView3.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: coin3?.x ?? 0).isActive = true
        BlackDotView3.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: coin3?.y ?? 0).isActive = true
        BlackDotView3.widthAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView3.heightAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView3.isHidden = true
        canvasView.blackDot3 = BlackDotView3
        
        //set up black dot 4
        view.insertSubview(BlackDotView4, belowSubview: canvasView)
        BlackDotView4.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: coin4?.x ?? 0).isActive = true
        BlackDotView4.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: coin4?.y ?? 0).isActive = true
        BlackDotView4.widthAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView4.heightAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView4.isHidden = true
        canvasView.blackDot4 = BlackDotView4
        
        //set up black dot 5
        view.insertSubview(BlackDotView5, belowSubview: canvasView)
        BlackDotView5.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: coin5?.x ?? 0).isActive = true
        BlackDotView5.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: coin5?.y ?? 0).isActive = true
        BlackDotView5.widthAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView5.heightAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView5.isHidden = true
        canvasView.blackDot5 = BlackDotView5
        
        //set up black dot 6
        view.insertSubview(BlackDotView6, belowSubview: canvasView)
        BlackDotView6.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: coin6?.x ?? 0).isActive = true
        BlackDotView6.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: coin6?.y ?? 0).isActive = true
        BlackDotView6.widthAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView6.heightAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView6.isHidden = true
        canvasView.blackDot6 = BlackDotView6
        
        //set up black dot 7
        view.insertSubview(BlackDotView7, belowSubview: canvasView)
        BlackDotView7.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: coin7?.x ?? 0).isActive = true
        BlackDotView7.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: coin7?.y ?? 0).isActive = true
        BlackDotView7.widthAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView7.heightAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView7.isHidden = true
        canvasView.blackDot7 = BlackDotView7
        
        //set up black dot 8
        view.insertSubview(BlackDotView8, belowSubview: canvasView)
        BlackDotView8.centerXAnchor.constraint(equalTo: canvasView.leftAnchor, constant: coin8?.x ?? 0).isActive = true
        BlackDotView8.centerYAnchor.constraint(equalTo: canvasView.topAnchor, constant: coin8?.y ?? 0).isActive = true
        BlackDotView8.widthAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView8.heightAnchor.constraint(equalToConstant: 25).isActive = true
        BlackDotView8.isHidden = true
        canvasView.blackDot8 = BlackDotView8
    }
    
    func setupCoinLabel() {
        CoinCountLabel.text = "X \(totalCoins)"
    }
    
    func goBack() {
        
        //dismissItem.dismiss(animated: false, completion: nil)
        print("Go Back Was Called")
        //self.performSegue(withIdentifier: "Back To Scene", sender: self)
        //navigationController?.popToRootViewController(animated: true)
        //navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //canvasView.drawTouches(touches, withEvent: event)
        guard let firstPoint = touches.first?.location(in: canvasView) else { return }
        
        print("The distance to the startPoint: ", canvasView.CGPointDistance(from: firstPoint, to: startingPoint))
        print("My Touch Location = CGpointX", firstPoint.x / canvasView.bounds.maxX, "and CGpointY", firstPoint.y / canvasView.bounds.maxY)
        
        if canvasView.CGPointDistance(from: firstPoint, to: startingPoint) < 25 {
            // lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
            canvasView.goodTouch = true
            print("Touch was within 25 units")
            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing1"]!, type: "mp3")
            
            canvasView.drawTouches(touches, withEvent: event)
            touches.forEach { (touch) in updateGagues(with: touch)
                
                if useDebugDrawing, touch.type == .pencil {
                    reticleView.isHidden = false
                    updateReticleView(with: touch)
                    //separatorView.isHidden = true
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canvasView.goodTouch {
            canvasView.drawTouches(touches, withEvent: event)
            
            //turn on feedback if the pencil angle is good
            if reticleView.actualAzimuthAngle >= 0 && reticleView.actualAzimuthAngle <= 1 {
                self.antFace.isHidden = false
            }
            else {
                self.antFace.isHidden = true
            }
            
            //each time we move the touch...
            touches.forEach {(touch) in
                
                //check to see if we interact with coins
                if canvasView.Line1 == true {
                    if canvasView.CGPointDistance(from: touch.location(in: canvasView), to: middlePoint1) < 25 {
                        if canvasView.coin1Collected == false {
                            canvasView.coin1Collected = true
                            canvasView.blackDot1?.isHidden = true
                            totalCoins += 1
                            setupCoinLabel()
                            print("***DINGDING***")
                            //TODO: add one to the Coin tally
                            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing2"]!, type: "mp3")
                            
                        }
                    }
                    if canvasView.CGPointDistance(from: touch.location(in: canvasView), to: middlePoint2) < 25 {
                        if canvasView.coin2Collected == false {
                            canvasView.coin2Collected = true
                            canvasView.blackDot2?.isHidden = true
                            totalCoins += 1
                            setupCoinLabel()
                            print("***DINGDING***")
                            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing3"]!, type: "mp3")
                        }
                    }
                }
                //**************
                if canvasView.Line2 == true {
                    if canvasView.CGPointDistance(from: touch.location(in: canvasView), to: middlePoint1) < 25 {
                        if canvasView.coin1Collected == false {
                            canvasView.coin1Collected = true
                            canvasView.blackDot3?.isHidden = true
                            totalCoins += 1
                            setupCoinLabel()
                            print("***DINGDING***")
                            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing2"]!, type: "mp3")
                        }
                    }
                    if canvasView.CGPointDistance(from: touch.location(in: canvasView), to: middlePoint2) < 25 {
                        if canvasView.coin2Collected == false {
                            canvasView.coin2Collected = true
                            canvasView.blackDot4?.isHidden = true
                            totalCoins += 1
                            setupCoinLabel()
                            print("***DINGDING***")
                            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing3"]!, type: "mp3")
                        }
                    }
                }
                //*************
                if canvasView.Line3 == true {
                    if canvasView.CGPointDistance(from: touch.location(in: canvasView), to: middlePoint1) < 25 {
                        if canvasView.coin1Collected == false {
                            canvasView.coin1Collected = true
                            canvasView.blackDot5?.isHidden = true
                            totalCoins += 1
                            setupCoinLabel()
                            print("***DINGDING***")
                            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing2"]!, type: "mp3")
                        }
                    }
                    if canvasView.CGPointDistance(from: touch.location(in: canvasView), to: middlePoint2) < 25 {
                        if canvasView.coin2Collected == false {
                            canvasView.coin2Collected = true
                            canvasView.blackDot6?.isHidden = true
                            totalCoins += 1
                            setupCoinLabel()
                            print("***DINGDING***")
                            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing3"]!, type: "mp3")
                        }
                    }
                }
                //************
                if canvasView.Line4 == true {
                    if canvasView.CGPointDistance(from: touch.location(in: canvasView), to: middlePoint1) < 25 {
                        if canvasView.coin1Collected == false {
                            canvasView.coin1Collected = true
                            canvasView.blackDot7?.isHidden = true
                            totalCoins += 1
                            setupCoinLabel()
                            print("***DINGDING***")
                            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing2"]!, type: "mp3")
                        }
                    }
                    if canvasView.CGPointDistance(from: touch.location(in: canvasView), to: middlePoint2) < 25 {
                        if canvasView.coin2Collected == false {
                            canvasView.coin2Collected = true
                            canvasView.blackDot8?.isHidden = true

                            totalCoins += 1
                            setupCoinLabel()
                            self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing3"]!, type: "mp3")
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //only able to end the line if the start was good (no touching last CGpoint to continue)
        if canvasView.goodTouch == true {
            //turn off feedback
            self.antFace.isHidden = true
            
            canvasView.drawTouches(touches, withEvent: event)
            canvasView.endTouches(touches, cancel: false)
            canvasView.goodTouch = false
            
            //guard let lastPoint = touches.first?.location(in: canvasView) else { return }
            
            touches.forEach { (touch) in clearGagues()
                if useDebugDrawing, touch.type == .pencil {
                    reticleView.isHidden = true
                    //separatorView.isHidden = true
                }
            }
            // adding total amount of coins possible to get
            coinsPossible += 2
            
            if canvasView.letterComplete == true {
                //play last ding
                self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["CoinDing4"]!, type: "mp3")
                
                //play cheer
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.canvasView.playAudioFXFile(file: chapterSelectedSoundDict!["LetterComplete"]!, type: "wav")
                    
                    // send character data to db with user credentials from login
                    Service.updateCharacterData(username: user, password: pass, letter: selectedActivity, score: Int32(totalCoins), timeToComplete: Service.TimeSinceActive(lastActive: startTime), totalPointsEarned: Int32(totalCoins), totalPointsPossible: coinsPossible)
                    //dismiss activity view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        self.dismiss(animated: false, completion: nil)
                        })
                    })
                }
            
            //removing coins from total if the line was not completed
            guard let lastPoint = touches.first?.location(in: canvasView) else { return }
            if canvasView.CGPointDistance(from: lastPoint, to: targetPoint) > 25 {
                if canvasView.coin1Collected == true {
                    totalCoins -= 1
                    setupCoinLabel()
                    
                    if canvasView.coin2Collected == true {
                        totalCoins -= 1
                        setupCoinLabel()
                    }
                }
                // subtracting total amount of coins possible if line wasn't finished
                coinsPossible -= 2
            }
            //reset collected booleans
            canvasView.coin1Collected = false
            canvasView.coin2Collected = false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { (touch) in
            clearGagues()
            
            if useDebugDrawing, touch.type == .pencil {
                reticleView.isHidden = true
            }
        }
    }
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        canvasView.updateEstimatedPropertiesForTouches(touches)
    }
    
    //MARK: Actions
    
    @IBAction func clearView(_ sender: Any) {
        canvasView.clear()
    }
    
    @IBAction func toggleDebugDrawing(_ sender: UIButton) {
        canvasView.isDebuggingEnabled = !canvasView.isDebuggingEnabled
        useDebugDrawing.toggle()
        sender.isSelected = canvasView.isDebuggingEnabled
    }
    
    @IBAction func toggleUsePreciseLocations(_ sender: UIButton) {
        canvasView.usePreciseLocations = !canvasView.usePreciseLocations
        sender.isSelected = canvasView.usePreciseLocations
    }
    
    //MARK: Convenience
    
    /// - Tag: PencilProperties
    
    private func updateReticleView(with touch: UITouch, isPredicted: Bool = false){
        guard touch.type == .pencil else { return }
        
        reticleView.predictedDotLayer.isHidden = !isPredicted
        reticleView.predictedLineLayer.isHidden = !isPredicted
        
        let azimuthAngle = touch.azimuthAngle(in: canvasView)
        let azimuthUnitVector = touch.azimuthUnitVector(in: canvasView)
        let altitudeAngle = touch.altitudeAngle
        
        if isPredicted {
            reticleView.predictedAzimuthAngle = azimuthAngle
            reticleView.predictedAzimuthUnitVector = azimuthUnitVector
            reticleView.predictedAltitudeAngle = altitudeAngle
        } else {
            let location = touch.preciseLocation(in: canvasView)
            reticleView.center = location
            reticleView.actualAzimuthAngle = azimuthAngle
            reticleView.actualAzimuthUnitVector = azimuthUnitVector
            reticleView.actualAltitudeAngle  = altitudeAngle
        }
    }
    
    private func updateGagues(with touch: UITouch) {
        //forceLabel.text = touch.force.valueFormattedForDisplay ?? ""
        
        //let azimuthUnitVector = touch.azimuthUnitVector(in: canvasView)
        //azimuthUnitVectorLabel.text = azimuthUnitVector.valueFormattedForDisplay ?? ""
        
        //let azimuthAngle = touch.azimuthAngle(in: canvasView)
        //azimuthAngleLabel.text = azimuthAngle.valueFormattedForDisplay ?? ""
        
        //altitudeAngleLabel.text = touch.altitudeAngle.valueFormattedForDisplay ?? ""
    }
    
    private func clearGagues() {
        //        gagueLabelCollection.forEach { (label) in
        //            label.text = ""
        //        }
    }
    
    @available(iOS 12.0, *)
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        guard UIPencilInteraction.preferredTapAction == .switchPrevious else { return }
        
        //toggleDebugDrawing(debugButton)
    }
    
    private func loadActivity(){
        startTime = Date()
        switch selectedActivity {
        case "A":
            activitySelection.loadActivityA()
        case "B":
            activitySelection.loadActivityB()
        case "C":
            activitySelection.loadActivityC()
        case "D":
            activitySelection.loadActivityD()
        case "E":
            activitySelection.loadActivityE()
        case "F":
            activitySelection.loadActivityF()
        case "G":
            activitySelection.loadActivityG()
        case "H":
            activitySelection.loadActivityH()
        case "I":
            activitySelection.loadActivityI()
        case "J":
            activitySelection.loadActivityJ()
        case "K":
            activitySelection.loadActivityK()
        case "L":
            activitySelection.loadActivityL()
        case "M":
            activitySelection.loadActivityM()
        case "N":
            activitySelection.loadActivityN()
        case "O":
            activitySelection.loadActivityO()
        case "P":
            activitySelection.loadActivityP()
        case "Q":
            activitySelection.loadActivityQ()
        case "R":
            activitySelection.loadActivityR()
        case "S":
            activitySelection.loadActivityS()
        case "T":
            activitySelection.loadActivityT()
        case "U":
            activitySelection.loadActivityU()
        case "V":
            activitySelection.loadActivityV()
        case "W":
            activitySelection.loadActivityW()
        case "X":
            activitySelection.loadActivityX()
        case "Y":
            activitySelection.loadActivityY()
        case "Z":
            activitySelection.loadActivityZ()
        case "a":
            activitySelection.loadActivitya()
        case "b":
            activitySelection.loadActivityb()
        case "c":
            activitySelection.loadActivityc()
        case "d":
            activitySelection.loadActivityd()
        case "e":
            activitySelection.loadActivitye()
        case "f":
            activitySelection.loadActivityf()
        case "g":
            activitySelection.loadActivityg()
        case "h":
            activitySelection.loadActivityh()
        case "i":
            activitySelection.loadActivityi()
        case "j":
            activitySelection.loadActivityj()
        case "k":
            activitySelection.loadActivityk()
        case "l":
            activitySelection.loadActivityl()
        case "m":
            activitySelection.loadActivitym()
        case "n":
            activitySelection.loadActivityn()
        case "o":
            activitySelection.loadActivityo()
        case "p":
            activitySelection.loadActivityp()
        case "q":
            activitySelection.loadActivityq()
        case "r":
            activitySelection.loadActivityr()
        case "s":
            activitySelection.loadActivitys()
        case "t":
            activitySelection.loadActivityt()
        case "u":
            activitySelection.loadActivityu()
        case "v":
            activitySelection.loadActivityv()
        case "w":
            activitySelection.loadActivityw()
        case "x":
            activitySelection.loadActivityx()
        case "y":
            activitySelection.loadActivityy()
        case "z":
            activitySelection.loadActivityz()
        case "-":
            activitySelection.loadActivityHorizontal()
        case "/":
            activitySelection.loadActivityDiagonalRight()
        case "|":
            activitySelection.loadActivityVertical()
        case "'\'":
            activitySelection.loadActivityDiagonalLeft()
        case "cross+":
            activitySelection.loadActivityPerpendicularCross()
        case "crossx":
            activitySelection.loadActivityDiagonalCross()
        case "square":
            activitySelection.loadActivitySquare()
        case "circle":
            activitySelection.loadActivityCircle()
        case "triangle":
            activitySelection.loadActivityTriangle()
        default: return
        }
    }
}
