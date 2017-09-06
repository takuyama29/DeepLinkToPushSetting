//
//  PushNotificationSettings.swift
//  DeepLinkToPushSetting
//
//  Created by 山田卓 on 2017/09/06.
//  Copyright © 2017 TakuYamada. All rights reserved.
//

import UIKit
import UserNotifications

class PushNotificationSettings: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = PushNotificationSettings()
    private override init(){}
    
    func pushNotificationRequest() {
        /* プッシュ通知許可ダイアログ */
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                
                if granted {
                    print("Allow")
                    
                    let center = UNUserNotificationCenter.current()
                    center.delegate = self
                    
                } else {
                    print("Denied")
                }
            })
            
        } else {
            // iOS 9以下
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
    
    func pushPermissionState(_ vc: UIViewController) {
        
        // 通知設定状況を取得
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            
            let targetViewController = vc as! ViewController
            
            switch settings.authorizationStatus {
            case .authorized:
                print("Allow notification")
                targetViewController.settingStatusLabel.text = "Allow notification"
                targetViewController.viewDidLoad()
                
            case .denied:
                print("Denied notification")
                targetViewController.settingStatusLabel.text = "Denied notification"
                
            case .notDetermined:
                print("Not settings")
                targetViewController.settingStatusLabel.text = "Not settings"
            }
        }
    }
    
    func linkToSettingsScreen() {
        
        // OSの通知設定画面へ遷移
        if let url = URL(string:"App-Prefs:root=NOTIFICATIONS_ID&path={YOUR_BUNDLE_ID}") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
