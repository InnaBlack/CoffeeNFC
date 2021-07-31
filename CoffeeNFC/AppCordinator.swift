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

// MARK: - AppCoordinator implementation

final class AppCoordinator: AppCoordinatorProtocol {
    
    static var shared: AppCoordinator = {
        return AppCoordinator()
    }()
    
    private var navigationController: UINavigationController?
    
    weak var delegate: AppInteractorProtocol? // if need restart
        
    func start() -> UIViewController? {
        let view: UIViewController

        self.navigationController = UINavigationController()
        //TODO
        view = UIViewController()
        self.navigationController?.setViewControllers([view], animated: true)
        return view
    }
}


