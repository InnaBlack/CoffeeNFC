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
    func nextScreen(typeModel: CofeeMachine, choosedModel: TypeElement) //TODO Generic
}

protocol AppCoordinatorCoffeeSizeOutput: AnyObject {
    func nextScreen(choosedModel: SizeElement)
}

protocol AppCoordinatorCoffeeExtraOutput: AnyObject {
    func nextScreen(choosedModel: ExtraElement)
}


// MARK: - AppCoordinator implementation

final class AppCoordinator: AppCoordinatorProtocol {
    
    private var navigationController: UINavigationController?
    private var coffeeNFSModel: CoffeeNFSModel?
    private var sizeVocabluary: [SizeElement]?
    private var extraVocabluary: [ExtraElement]?
    weak var delegate: AppInteractorProtocol? // if need restart
        
    func start() -> UIViewController? {

        self.navigationController = UINavigationController()
        //MainScreen configuration
        let (coffeeMainscreenView, coffeeMainscreenInput) = CoffeeMainScreenConfigurator.authModule(linkCordinator: self)
        navigationController = UINavigationController(rootViewController: coffeeMainscreenView)
        
        return self.navigationController
    }
}
//link output for earch screen
extension AppCoordinator: AppCoordinatorCoffeeMainScreenOutput {
    func nextScreen(typeModel: CofeeMachine, choosedModel: TypeElement) {
        
        //Make NFS model
        coffeeNFSModel = CoffeeNFSModel()
    
        //
        self.sizeVocabluary = typeModel.sizes
        //
        self.extraVocabluary = typeModel.extras

        //SizeScreen configuration
        let (coffeeSizescreenView, coffeeSuzeScreenInput) = SizeScreenConfigurator.authModule(linkCordinator: self)
       
        coffeeSuzeScreenInput.setModel(model: typeModel.sizes)
        self.navigationController?.pushViewController(coffeeSizescreenView, animated: true)
    }
}

extension AppCoordinator: AppCoordinatorCoffeeSizeOutput {
    func nextScreen(choosedModel: SizeElement) {
        
        coffeeNFSModel?.sizes = choosedModel
        
        //SizeScreen configuration
        let (coffeeExtraSreenView, coffeeExtraScreenInput) = ExtraScreenConfigurator.authModule(linkCordinator: self)
        guard let extraVocabluary = self.extraVocabluary else {
            return
        }
        coffeeExtraScreenInput.setModel(model: extraVocabluary)
        self.navigationController?.pushViewController(coffeeExtraSreenView, animated: true)
    }
}

extension AppCoordinator: AppCoordinatorCoffeeExtraOutput {
    func nextScreen(choosedModel: ExtraElement) {
        
        coffeeNFSModel?.extras = choosedModel
        
        //SizeScreen configuration
        let (coffeeSizecreenView, coffeeSizescreenInput) = SizeScreenConfigurator.authModule(linkCordinator: self)
       
    }
}


