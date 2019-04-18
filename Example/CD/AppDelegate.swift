//
//  AppDelegate.swift
//  CD
//
//  Created by liucaide on 12/14/2018.
//  Copyright (c) 2018 liucaide. All rights reserved.
//

import UIKit
import CD
import TabbarNavigation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var app: CD_AppDelegateComposite = {
        return CD_AppDelegateComposite([AppDelegate_VC(window),AppDelegate_UM()])
    }()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //window = UIWindow(frame: UIScreen.main.bounds)
        return app.application(application, didFinishLaunchingWithOptions:launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        app.applicationWillResignActive(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        app.applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        app.applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        app.applicationDidBecomeActive(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        app.applicationWillTerminate(application)
    }


}


