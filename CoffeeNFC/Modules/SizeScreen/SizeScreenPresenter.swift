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
    func setModel(model:  [SizeElement])
}

// MARK: - SizeScreenPresenter implementation

final class SizeScreenPresenter: NSObject {
    
    weak var view: SizeScreenView!
    var delegate: AppCoordinatorCoffeeSizeOutput!
    
    var coffeeTableManager: CoffeeTableManagerProtocol?
    
    private var model: [SizeElement]?
    
    private let disposeBag = DisposeBag()
    
}

extension SizeScreenPresenter: SizeScreenPresenterProtocol {
    
    func viewDidLoad() {
        guard let model = model else {
            return
        }
        let coffeeViewModels = model.map({ typeElement in
            SizeCoffeeViewModel(id: typeElement.id,
                            name: typeElement.name)
        })
       
    self.coffeeTableManager?.updateTable(with: coffeeViewModels)
    }
}

extension SizeScreenPresenter: SizeScreenInput {
    func setModel(model:  [SizeElement]) {
        self.model = model
    }
}

extension SizeScreenPresenter: CoffeeTableManagerDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        guard let model = self.model else {
            return
        }
       
        delegate.nextScreen(choosedModel: model[indexPath.row])
    }
}


