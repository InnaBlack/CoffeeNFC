//
//  AppDelegate.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var interactor: AppInteractorProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup coordinator with interactor
        self.interactor = AppInteractor()
        self.interactor?.start()
        
        return true
    }
}

