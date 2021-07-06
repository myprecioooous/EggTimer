//
//  ViewController.swift
//  EggTimer
//
//  Created by Precious Camille De Los Reyes on 2/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var softButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        softButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: softButton.bounds.width - softButton.bounds.height)
        softButton.imageView?.layer.cornerRadius = softButton.bounds.height/2.0
        softButton.imageView?.contentMode = .scaleAspectFill
        
        mediumButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: mediumButton.bounds.width - mediumButton.bounds.height)
        mediumButton.imageView?.layer.cornerRadius = mediumButton.bounds.height/2.0
        mediumButton.imageView?.contentMode = .scaleAspectFill
        
        hardButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: hardButton.bounds.width - hardButton.bounds.height)
        hardButton.imageView?.layer.cornerRadius = hardButton.bounds.height/2.0
        hardButton.imageView?.contentMode = .scaleAspectFill
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Invoking the authorizeNotification method in NotificationService class
        NotificationService.sharedInstance.authorizeNotification()
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.orange, .font:  UIFont(name: "Marker Felt Thin", size: 30)!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        //softButton.layer.cornerRadius = softButton.bounds.size.height/2
        
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Passing data from one vc to another
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // //checking segue identifier
        if segue.identifier == "SoftToTimer" {
            
            //specifying segue destination
            let timerVC = segue.destination as! TimerViewController
            timerVC.previousButtonClicked = "Soft"
            
        }
        
        else if segue.identifier == "MediumToTimer" {
            
            let timerVC = segue.destination as! TimerViewController
            timerVC.previousButtonClicked = "Medium"
            
        }

        else if segue.identifier == "HardToTimer" {
            
            let timerVC = segue.destination as! TimerViewController
            timerVC.previousButtonClicked = "Hard"
//            timerVC.timeInSec = 720
        }
    }


}

