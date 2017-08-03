//
//  ViewController.swift
//  StopWatch
//
//  Created by Andrew on 8/3/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = NSTimer()
    var counter = 0
    
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.enabled = false
        stopButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerCounter(){
        counter += 1
        timeLabel.text = "\(String(format:"%02d",(counter/600)%60)):\(String(format:"%02d",(counter/10)%60)):\(String(format:"%02d",counter%10))"

    }


    @IBAction func startAction(sender: UIBarButtonItem) {
        timer = NSTimer.scheduledTimerWithTimeInterval( 0.1, target:self, selector: #selector(ViewController.timerCounter), userInfo: nil, repeats: true)
        playButton.enabled=false
        pauseButton.enabled=true
        stopButton.enabled=true
    }
    
    @IBAction func pauseAction(sender: AnyObject) {
        timer.invalidate()
        playButton.enabled=true
        pauseButton.enabled=false
        stopButton.enabled=false
    }
    
    @IBAction func stopAction(sender: AnyObject) {
        timer.invalidate()
        counter = 0
        playButton.enabled=true
        pauseButton.enabled=false
        stopButton.enabled=false
    }
    
    
}

