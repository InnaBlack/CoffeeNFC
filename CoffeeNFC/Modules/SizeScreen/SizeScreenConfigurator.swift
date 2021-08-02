//
//  SizeScreenConfigurator.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit

protocol SizeScreenConfiguratoryProtocol {
    
}

class SizeScreenConfigurator: SizeScreenConfiguratoryProtocol {
  
    class func authModule(linkCordinator: AppCoordinatorCoffeeSizeOutput) -> (UIViewController, SizeScreenInput) {
        //Services
        let networkService: CoffeeNetworkServiceProtocol? = ServiceLocator.shared.getService()
        let tableViewManager: CoffeeTableManagerProtocol? = CoffeeTableManager()

        let view = SizeScreenView()
        let presenter = SizeScreenPresenter()
        view.presenter = presenter
        presenter.coffeeTableManager = tableViewManager
        presenter.view = view
        presenter.delegate = linkCordinator
        presenter.networkService = networkService
        
        return (view, presenter)
    }
}
