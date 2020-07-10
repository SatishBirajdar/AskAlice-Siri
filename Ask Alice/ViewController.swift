//
//  ViewController.swift
//  Ask Alice
//
//  Created by Satish Birajdar ACV on 2020-07-01.
//  Copyright © 2020 Satish Birajdar ACV. All rights reserved.
//

import UIKit
import IntentsUI

class ViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate {
  func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
    
  }
  
  func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
    
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    displaySiriShortcutPopup()
    
    // Do any additional setup after loading the view.
//    NotificationCenter.default.addObserver(self, selector: #selector(self.displayNotifications), name: Notification(name: Notification.Name(rawValue: "ShowNotifications")), object: nil)
    

//    NotificationCenter.default.addObserver(self, selector: #selector(self.displayNotifications), name: Notification(name: Notification.Name(rawValue: "ShowNotifications")), object: nil)
//
//    NotificationCenter.default.addObserver(self, selector: #selector(self.displayNotifications), name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition, object: .shared())
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.displayNotifications), name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)

  }

  
  @objc func displayNotifications(){
    print("Satish : display Notifications")
  }
  
  func setupIntentsForSiri() {
    let actionIdentifier = "com.acvauctions.askalice.shownotifications"
     let activity = NSUserActivity(activityType: actionIdentifier)
    activity.title = "Show Notifications"
    activity.userInfo = ["speech" : "show notifications"]
     activity.isEligibleForSearch = true
     if #available(iOS 12.0, *) {
         activity.isEligibleForPrediction = true
         activity.persistentIdentifier = NSUserActivityPersistentIdentifier(actionIdentifier)
     }
     view.userActivity = activity
     activity.becomeCurrent()
  }
  
  func displaySiriShortcutPopup() {
      if #available(iOS 12.0, *) {
          guard let userActivity = view.userActivity else { return }
          let shortcut = INShortcut(userActivity: userActivity)
          let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
          vc.delegate = self
          present(vc, animated: true, completion: nil)
      }
  }

}

