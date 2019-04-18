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
    lazy var composite: CD_AppDelegateComposite = {
        return CD_AppDelegateComposite([AppDelegate_VC(window),AppDelegate_UM()])
    }()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return composite.application(application, didFinishLaunchingWithOptions:launchOptions)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return composite.application(app, open: url, options: options)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        composite.applicationWillResignActive(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        composite.applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        composite.applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        composite.applicationDidBecomeActive(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        composite.applicationWillTerminate(application)
    }
}


extension
