//
//  AppDelegate.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 28/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootController: UINavigationController?
    
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let notification = launchOptions?[.remoteNotification] as? [String: AnyObject]
        
        let deepLink = DeeplinkPath.openScreen(param: notification)
        applicationCoordinator.start(with: deepLink)
        return true
    }
    
    /** Set Root View */
    private func makeCoordinator() -> Coordinator {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController()
        self.window?.makeKeyAndVisible()
        if let nav = self.window?.rootViewController as? UINavigationController {
            rootController = nav
        }
        let appCoordinator = ApplicationCoordinator(router: RouterImplementation(root: rootController), coordinatorFactory: CoordinatorFactoryImplem())
        return appCoordinator
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

