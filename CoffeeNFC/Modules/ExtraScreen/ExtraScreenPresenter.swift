//
//  CoffeePresenter.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import UIKit
import RxSwift

protocol ExtraScreenPresenterProtocol {
    
    var coffeeTableManager: CoffeeTableManagerProtocol? { get }
    func viewDidLoad()
}

protocol ExtraScreenInput {
    func setModel(model:  [ExtraElement])
}

// MARK: - ExtraScreenPresenter implementation

final class ExtraScreenPresenter: NSObject {
    
    weak var view: ExtraScreenView!
    var delegate: AppCoordinatorCoffeeExtraOutput!
    
    var coffeeTableManager: CoffeeTableManagerProtocol?
    
    private var model: [ExtraElement]?
    
    private let disposeBag = DisposeBag()
    
}

extension ExtraScreenPresenter: ExtraScreenPresenterProtocol {
    
    func viewDidLoad() {
        guard let model = model else {
            return
        }
        let coffeeViewModels = model.map({ typeElement in
            ExtraCoffeeViewModel(id: typeElement.id,
                                 name: typeElement.name,
                                 subselections: typeElement.subselections)
        })
       
    self.coffeeTableManager?.updateTable(with: coffeeViewModels)
    }
}

extension ExtraScreenPresenter: ExtraScreenInput {
    func setModel(model:  [ExtraElement]) {
        self.model = model
    }
}

extension ExtraScreenPresenter: CoffeeTableManagerDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        guard let model = self.model else {
            return
        }
       
        delegate.nextScreen(choosedModel: model[indexPath.row])
    }
}


