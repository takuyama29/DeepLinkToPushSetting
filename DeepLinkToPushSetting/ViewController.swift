//
//  ViewController.swift
//  DeepLinkToPushSetting
//
//  Created by 山田卓 on 2017/09/06.
//  Copyright © 2017 TakuYamada. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBAction func reloadButton(_ sender: UIButton) {
        PushNotificationSettings.shared.pushPermissionState(self)
    }
    
    @IBAction func linkToSettingButton(_ sender: UIButton) {
        PushNotificationSettings.shared.linkToSettingsScreen()
    }
    
    @IBOutlet weak var settingStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PushNotificationSettings.shared.pushNotificationRequest()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PushNotificationSettings.shared.pushPermissionState(self)
    }
}

