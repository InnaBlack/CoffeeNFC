//
//  CoffeePresenter.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit
import RxSwift

protocol CoffeeMainScreenPresenterProtocol {
    var coffeeTableManager: CoffeeTableManagerProtocol? { get }
    func viewDidLoad()
}

protocol CoffeeMainScreenInput {
    
}

// MARK: - CoffeeMainScreenPresenter implementation

final class CoffeeMainScreenPresenter: NSObject {
    
    weak var view: CoffeeMainScreenView!
    var delegate: AppCoordinatorCoffeeMainScreenOutput!
    var networkService: CoffeeNetworkServiceProtocol!
    
    var coffeeTableManager: CoffeeTableManagerProtocol?
        
    private let disposeBag = DisposeBag()
    
}
    
extension CoffeeMainScreenPresenter: CoffeeMainScreenPresenterProtocol {
       
    func viewDidLoad() {
        guard let networkService = self.networkService else {
            return
        }
        view?.showLoader()
        networkService.obtainCofeeMachine(id: "60ba0ad8493d9eac4811a9a6")
            .observe(on: MainScheduler.instance)
            .subscribe { cofeeMachine in
                print(cofeeMachine) //todoMake ViewModel
            } onFailure: { error in
                //show error todo
            }.disposed(by: disposeBag)

    }
}

extension CoffeeMainScreenPresenter: CoffeeMainScreenInput {
    
}


