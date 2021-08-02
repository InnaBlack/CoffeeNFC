//
//  ExtraScreenConfigurator.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit

protocol ExtraScreenConfiguratoryProtocol {
    
}

class ExtraScreenConfigurator: ExtraScreenConfiguratoryProtocol {
  
    class func authModule(linkCordinator: AppCoordinatorCoffeeExtraOutput) -> (UIViewController, ExtraScreenInput) {
        //Services

        let view = ExtraScreenView()
        let presenter = ExtraScreenPresenter()
        let tableViewManager: CoffeeTableManagerProtocol? = CoffeeTableManager(withDelegate: presenter)
        view.presenter = presenter
        presenter.coffeeTableManager = tableViewManager
        presenter.view = view
        presenter.delegate = linkCordinator
        
        return (view, presenter)
    }
}
