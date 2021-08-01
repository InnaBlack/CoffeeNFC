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
    func nextScreen(typeModel: CofeeMachine, choosedModel: TypeElement)
}


// MARK: - AppCoordinator implementation

final class AppCoordinator: AppCoordinatorProtocol {
    
    private var navigationController: UINavigationController?
    private var coffeeNFSModel: CoffeeNFSModel?
    weak var delegate: AppInteractorProtocol? // if need restart
        
    func start() -> UIViewController? {

        self.navigationController = UINavigationController()
        //MainScreen configuration
        let (coffeeMainscreenView, coffeeMainscreenInput) = CoffeeMainScreenConfigurator.authModule(linkCordinator: self)
       
        self.navigationController?.setViewControllers([coffeeMainscreenView], animated: true)
        
        return self.navigationController
    }
}
//link output for earch screen
extension AppCoordinator: AppCoordinatorCoffeeMainScreenOutput {
    func nextScreen(typeModel: CofeeMachine, choosedModel: TypeElement) {
        
        coffeeNFSModel?.types = choosedModel
    }
}


