//
//  ViewController.swift
//  timerOnly
//
//  Created by user on 2020/09/20.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    var startTime: TimeInterval? = nil
    var timer = Timer()
    var elapsedTime: Double = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            setButtonEnable(start:true, stop:false, reset: false)   }
            func setButtonEnable(start: Bool, stop: Bool, reset: Bool) {
            self.startButton.isEnabled = start
            self.stopButton.isEnabled = stop
            self.resetButton.isEnabled = reset   }
        
            @objc func update() {
            if let startTime = self.startTime {
            let t: Double = Date.timeIntervalSinceReferenceDate - startTime + self.elapsedTime
            let min = Int(t / 60)
            let sec = Int(t) % 60
            let msec = Int(t * 100) % 100
            let mmsec = Int(t * 100 * 100) % 100
            let mmmsec = Int(t * 100 * 100 * 100) % 100
            let mmmmsec = Int(t * 100 * 100 * 100 * 100) % 100
            let mmmmmsec = Int(t * 100 * 100 * 100 * 100 * 100) % 100
            let mmmmmmsec = Int(t * 100 * 100 * 100 * 100 * 100 * 100) % 100
            let mmmmmmmsec = Int(t * 100 * 100 * 100 * 100 * 100 * 100 * 100) % 100
            self.timerLabel.text = String(format: "%02d:%02d:%02d:%02d:%02d:%02d:%02d:%02d:%02d", min, sec, msec, mmsec, mmmsec, mmmmsec, mmmmmsec, mmmmmmsec, mmmmmmmsec)
                
                if sec == 10 && msec == 00 && mmsec == 00 && mmmsec == 00 && mmmmsec == 00 && mmmmmsec == 00 && mmmmmmsec == 00 && mmmmmmsec == 00 && mmmmmmmsec == 00 {
                    self.timerLabel.text = "おめでとう！あたりだよ！！"
                    
                } else {
                    self.timerLabel.text = String(format: "%02d:%02d:%02d:%02d:%02d:%02d:%02d:%02d:%02d", min, sec, msec, mmsec, mmmsec, mmmmsec, mmmmmsec, mmmmmmsec, mmmmmmmsec)
                    
            }
        }
     }
     
 
    @IBAction func startTimer(_ sender: Any) {
        setButtonEnable(start: false, stop: true, reset: false)
        self.startTime = Date.timeIntervalSinceReferenceDate
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)    }
    
    
    @IBAction func stopTimer(_ sender: Any) {
        setButtonEnable(start: true, stop: false, reset: true)
        if let startTime = self.startTime {
        self.elapsedTime += Date.timeIntervalSinceReferenceDate - startTime   }
        self.timer.invalidate()
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        setButtonEnable(start: true, stop: false, reset: false)
        self.startTime = nil
        self.timerLabel.text = "00:00:00:00:00:00:00:00:00"
        self.elapsedTime = 0.0
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
override func viewDidLayoutSubviews(){    // ★←この関数まるまる追記
    //  広告インスタンス作成
    var admobView = GADBannerView()
    admobView = GADBannerView(adSize:kGADAdSizeBanner)
    
    //  広告位置設定
    let safeArea = self.view.safeAreaInsets.bottom
    admobView.frame.origin = CGPoint(x:0, y:self.view.frame.size.height - safeArea - admobView.frame.height)
    admobView.frame.size = CGSize(width:self.view.frame.width, height:admobView.frame.height)
    
    //  広告ID設定
    admobView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    //  広告表示
    admobView.rootViewController = self
    admobView.load(GADRequest())
    self.view.addSubview(admobView)
}

}

