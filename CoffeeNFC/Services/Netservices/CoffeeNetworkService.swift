//
//  CoffeeNetworkService.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import Foundation
import Alamofire
import RxSwift


protocol CoffeeNetworkServiceProtocol: AnyObject {
    func obtainCofeeMachine(id: String) -> Single<CofeeMachine?>
}

class CoffeeNetworkService {
    private let sessionManager: SessionManagerProtocol!
    private let disposeBag = DisposeBag()
    
    init() {
        self.sessionManager = SessionManager(baseUrl: SessionManagerBaseURL.CoffeeIT)
    }
    
    private func makeRequest<E: EndPointProtocol>(
        from endPoint: E,
        method: HTTPMethod,
        completion: @escaping (Result<Data, Error>) -> ()) {
        self.sessionManager.makeRequest(url: endPoint.endUrl, method: method, params: endPoint.params) { response in
            completion(.success(response))
        } failure: { error in
            completion(.failure(error))
        }
    }
}

extension CoffeeNetworkService: CoffeeNetworkServiceProtocol {

    func obtainCofeeMachine(id: String) -> Single<CofeeMachine?> {
        
        return .create{ [weak self] obsever in
            guard
                let strongSelf = self
            else {
                return Disposables.create()
            }
            self?.makeRequest(from: CoffeeEndPoints.obtainCofeeMachine(id: id), method: .get) { result in
                switch result {
                case .success(let response):
                    if let json = try? JSONSerialization.jsonObject(with: response, options: []),
                       let profile = CofeeMachine.fromJson(json) {
                        obsever(.success(profile))
                    } else {
                        obsever(.success(nil))
                    }
                case .failure(let error):
                    obsever(.error(CError(error: error)))
                }
            }
            
            return Disposables.create()
        }
    }
}



