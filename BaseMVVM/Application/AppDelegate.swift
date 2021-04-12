//
//  AppDelegate.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/11/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = ServiceManager.shared
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        self.window = window
        
        return true
    }

}

class ServiceManager {
    
    static let shared = ServiceManager()
    
    func movieService() -> MovieServiceType {
        return Assembler.resolve(MovieServiceType.self)!
    }
}



