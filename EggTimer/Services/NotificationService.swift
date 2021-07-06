//
//  NotificationService.swift
//  EggTimer
//
//  Created by Precious Camille De Los Reyes on 07/05/21.
//

import UserNotifications
import UIKit

//a helper class that contains all the functions related to notification along with UNUserNotificationCenterDelegate methods.

class NotificationService: NSObject {
    
    //1. Singleton Class
    private override init() { }
    static let sharedInstance = NotificationService()
    
    //2. Get the current UNUserNotificationCenter
    let UNCurrentCenter = UNUserNotificationCenter.current()
    
    //MARK: - Notification
    //3. Request the user authorization to send alerts.
    func authorizeNotification() {
        
        //3.1. Setting up the options the way you want to interact with the user.
        let options:UNAuthorizationOptions = [.alert, .badge, .sound]
        
        //3.2. Requests authorization with the user to deliver notification.
        UNCurrentCenter.requestAuthorization(options: options) { (granted, error) in
             print(error ?? "No UNAuthorization error")
            
            //3.3. completionHandler falls after the user's choice(maybe or maynot be granted).
            guard granted else {
                print("User Denied the permission to receive Push")
                return
            }
            
            //3.4. Conform to UNUserNotificationCenterDelegate
            self.UNCurrentCenter.delegate = self
        }
    }
    
    //MARK: - Request Timer Notification
    func requestTimerNotification(repeatedly:Bool = false, withinterval interval:TimeInterval) {
        
        //Specifies the payload for a local notification
        let content  = UNMutableNotificationContent()
        content.title = "Time's up!"
        content.subtitle = "Please submerge the egg in icy water"
        content.sound = UNNotificationSound.init(named: .funnySong)
        
        //Setup Time Interval Trigger to notify after the time interval, and optionally repeat
        //Note: the time interval must be at least 60 if repeating else it will lead to application crash due to ‘NSInternalInconsistencyException’
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeatedly)
        
        //Setup request to schedule a local notification
        let request = UNNotificationRequest(identifier: "Notification.Timer",
                                            content: content,
                                            trigger: trigger)
        
        //Add the request to the current UNUserNotificationCenter
        self.UNCurrentCenter.add(request)
    }
    
}


//MARK: - Delegation / Extensions
//conforming to UNUserNotificationCenterDelegate
extension NotificationService: UNUserNotificationCenterDelegate {
    
    //will be called when the user responded to the notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive response")
        completionHandler()
    }
    
    //will be called if notification is presented only if the application is in the foreground state
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")
        
        let options:UNNotificationPresentationOptions = [.banner, .sound]
        completionHandler(options)
    }
}

extension UNNotificationSoundName {
    //Music: https://www.bensound.com
    static let funnySong  = UNNotificationSoundName(rawValue: "funnysong.mp3")
}
