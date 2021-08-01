//
//  CoffeeMainScreenConfigurator.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit

protocol CoffeeMainScreenConfiguratoryProtocol {
    
}

class CoffeeMainScreenConfigurator: CoffeeMainScreenConfiguratoryProtocol {
  
    class func authModule(linkCordinator: AppCoordinatorCoffeeMainScreenOutput) -> (UIViewController, CoffeeMainScreenInput) {
        //Services
        let networkService: CoffeeNetworkServiceProtocol? = ServiceLocator.shared.getService()

        let view = CoffeeMainScreenView()
        let presenter = CoffeeMainScreenPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.delegate = linkCordinator
        presenter.networkService = networkService
        
        return (view, presenter)
    }
}
