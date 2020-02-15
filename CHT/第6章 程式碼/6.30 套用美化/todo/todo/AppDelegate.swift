//
//  AppDelegate.swift
//  todo
//
//  Created by lovefancy on 14-10-23.
//  Copyright (c) 2014年 eko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        print("root:\(self.window?.rootViewController)")
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Alert, UIUserNotificationType.Badge], categories: nil))
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }
    //套用中斷
    func applicationWillTerminate(application: UIApplication) {
        saveData()
    }
    //儲存資料
    func saveData(){
        todoModel.saveData()
    }

}


