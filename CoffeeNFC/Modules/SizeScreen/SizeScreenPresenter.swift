//
//  CoffeePresenter.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit
import RxSwift

protocol SizeScreenPresenterProtocol {
    
    var coffeeTableManager: CoffeeTableManagerProtocol? { get }
    func viewDidLoad()
}

protocol SizeScreenInput {
    
}

// MARK: - SizeScreenPresenter implementation

final class SizeScreenPresenter: NSObject {
    
    weak var view: SizeScreenView!
    var delegate: AppCoordinatorCoffeeSizeOutput!
    var networkService: CoffeeNetworkServiceProtocol!
    
    var coffeeTableManager: CoffeeTableManagerProtocol?
    
    private var model: CofeeMachine?
    
    private let disposeBag = DisposeBag()
    
}

extension SizeScreenPresenter: SizeScreenPresenterProtocol {
    
    func viewDidLoad() {
        guard let networkService = self.networkService else {
            return
        }
        view?.showLoader()
        networkService.obtainCofeeMachine(id: "60ba1ab72e35f2d9c786c610")
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] cofeeMachine in
                let coffeeViewModels = cofeeMachine.types.map({ typeElement in
                    CoffeeViewModel(id: typeElement.id,
                                    name: typeElement.name,
                                    sizes: typeElement.sizes,
                                    extras: typeElement.extras)
                })
                self?.model = cofeeMachine
                self?.coffeeTableManager?.updateTable(with: coffeeViewModels)
            } onFailure: { error in
                //show error todo
            }.disposed(by: disposeBag)
        
    }
}

extension SizeScreenPresenter: SizeScreenInput {
    
}

extension SizeScreenPresenter: CoffeeTableManagerDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        guard let model = self.model else {
            return
        }
        delegate.nextScreen(typeModel: model, choosedModel: model.extras[indexPath.row])
    }
}


