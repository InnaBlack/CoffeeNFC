//
//  AppInteractor.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import Foundation
import UIKit

// MARK: - AppInteractorProtocol declaration
protocol AppInteractorProtocol: AnyObject {
    func start()
    func reStart()
}

// MARK: - AppInteractor implementation

final class AppInteractor: NSObject, AppInteractorProtocol {
    
    private var coreWindow: UIWindow?
    private var coordinator: AppCoordinatorProtocol?
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        // Services initialization
        setupServiceLocator()
    }
    
    // MARK: - Private methods
    
    private func setupServiceLocator() {
        let coffeeNetworkService = CoffeeNetworkService()
        ServiceLocator.shared.addService(service: coffeeNetworkService as CoffeeNetworkServiceProtocol)
    }
    
    // MARK: - Public methods
    
    func start() {
        
        coordinator = AppCoordinator()
        coordinator?.delegate = self
        let targetViewController = coordinator?.start()

        self.coreWindow = UIWindow(frame: UIScreen.main.bounds)
        self.coreWindow?.rootViewController = targetViewController
        self.coreWindow?.makeKeyAndVisible()
        
       //TODO managers
    }
    
    func reStart() {
        //TODO
    }
}
