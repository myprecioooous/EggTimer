//
//  TimerViewController.swift
//  EggTimer
//
//  Created by Precious Camille De Los Reyes on 2/23/21.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer = Timer()
    var count = 0
    var timerCounting = false
    
    var previousButtonClicked: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonClicked = previousButtonClicked!
        
        //MARK: - Initial setup
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        
        if buttonClicked == "Soft" {
            timerLabel.text = makeTimeString(0, 4, 0)
        }
        
        else if buttonClicked == "Medium" {
            timerLabel.text = makeTimeString(0, 8, 0)
        }
        
        else if buttonClicked == "Hard" {
            timerLabel.text = makeTimeString(0, 12, 0)
        }
        
        
    }
    
    //MARK: - Action
    @IBAction func startStopTapped(_ sender: Any) {
        //toggle
        if timerCounting {
            timerCounting = false
            //stop timer
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
        }
        
        else {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            
            //get timer to start counting
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the timer?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //Do nothind
        }))
        
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            //reset
            self.count = 0
            self.timer.invalidate()
            //self.timerLabel.text = self.makeTimeString(0, 4, 0)
            
            let buttonClicked = self.previousButtonClicked!
            if buttonClicked == "Soft" {
                self.timerLabel.text = self.makeTimeString(0, 4, 0)
            }
            
            else if buttonClicked == "Medium" {
                self.timerLabel.text = self.makeTimeString(0, 8, 0)
            }
            
            else if buttonClicked == "Hard" {
                self.timerLabel.text = self.makeTimeString(0, 12, 0)
            }
            
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
            self.timerCounting = false
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Helper
    
    @objc func  timerCounter() {
        count += 1
        let time = secondsToHoursMinutesSeconds(count)
        let timeString = makeTimeString(time.0, time.1, time.2)
        timerLabel.text = timeString
    }
    
    func  secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        
        var calcMinutes = 0
        var calcSec = 0
        
//        calcMinutes = 3 - minutes
        calcSec = 60 - sec
        
        
        
        let buttonClicked =  previousButtonClicked!
        if buttonClicked == "Soft" {
            calcMinutes = 3 - minutes
            if calcMinutes == 0 {
                count = 0
                calcSec = 0
                calcMinutes = 4
                timer.invalidate()
                //calcSec = 0
                //timerLabel.text = makeTimeString(0, 4, 0)
                timerCounting = false
                startStopButton.setTitle("START", for: .normal)
                startStopButton.setTitleColor(UIColor.green, for: .normal)
                
            }
                    
        }
        
        else if buttonClicked == "Medium" {
            calcMinutes = 7 - minutes
            if calcMinutes == 0 {
                count = 0
                calcSec = 0
                calcMinutes = 8
                timer.invalidate()
                //calcSec = 0
                //timerLabel.text = makeTimeString(0, 4, 0)
                timerCounting = false
                startStopButton.setTitle("START", for: .normal)
                startStopButton.setTitleColor(UIColor.green, for: .normal)
                
            }
            
        }
        
        else if buttonClicked == "Hard" {
            calcMinutes = 11 - minutes
            if calcMinutes == 0 {
                count = 0
                calcSec = 0
                calcMinutes = 11
                timer.invalidate()
                //calcSec = 0
                //timerLabel.text = makeTimeString(0, 4, 0)
                timerCounting = false
                startStopButton.setTitle("START", for: .normal)
                startStopButton.setTitleColor(UIColor.green, for: .normal)
                
            }
            
        }
        
        
        //let calcSec = 60 - sec
        
        return (hours, calcMinutes, calcSec)
    }
    
    func makeTimeString(_ hours: Int, _ minutes: Int, _ seconds: Int)  -> String {
        
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    
    

    
    
    
}
