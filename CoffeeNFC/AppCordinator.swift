//
//  AppCordinator.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import Foundation
import UIKit

// MARK: - AppCoordinatorProtocol declaration

protocol AppCoordinatorProtocol: AnyObject {
    var delegate: AppInteractorProtocol? { get set }

    func start() -> UIViewController?
    init()
    
}


protocol AppCoordinatorCoffeeMainScreenOutput: AnyObject {
    
}


// MARK: - AppCoordinator implementation

final class AppCoordinator: AppCoordinatorProtocol {
    
    private var navigationController: UINavigationController?
    
    weak var delegate: AppInteractorProtocol? // if need restart
        
    func start() -> UIViewController? {

        self.navigationController = UINavigationController()
        
        //MainScreen configuration 
        let (coffeeMainscreenView, coffeeMainscreenInput) = CoffeeMainScreenConfigurator.authModule(linkCordinator: self)
       
        self.navigationController?.setViewControllers([coffeeMainscreenView], animated: true)
        
        return coffeeMainscreenView
    }
}
//link output for earch screen
extension AppCoordinator: AppCoordinatorCoffeeMainScreenOutput {
    func nextScreen(typeModel: CofeeMachine) {
        
    }
}


