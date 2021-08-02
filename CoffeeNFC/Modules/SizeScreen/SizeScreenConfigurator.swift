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

        let view = SizeScreenView()
        let presenter = SizeScreenPresenter()
        let tableViewManager: CoffeeTableManagerProtocol? = CoffeeTableManager(withDelegate: presenter)
        view.presenter = presenter
        presenter.coffeeTableManager = tableViewManager
        presenter.view = view
        presenter.delegate = linkCordinator
        
        return (view, presenter)
    }
}
