//
//  SesionManager.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import Foundation
import Alamofire

// MARK: - SessionManagerProtocol declaration
public protocol SessionManagerProtocol: AnyObject {
    init(baseUrl: String)
    func makeRequest(url: String?, method: HTTPMethod, params: [String : Any]?, success: @escaping (_ data: Data) -> (), failure: @escaping (_ error: CError) -> ())
}

// MARK: - SessionManagerBaseURL implementation
public enum SessionManagerBaseURL {
    private static func serverAPI(key: String) -> String  {
        let dict = Bundle.main.object(forInfoDictionaryKey: "ServerAPI") as! Dictionary<String, String>
        return dict[key]! as String
    }

    public static var CoffeeIT: String = { serverAPI(key: "CoffeeIT") }()
}

// MARK: - SessionManager implementation
public class SessionManager {
    
    // MARK: Private properties
   
    private let baseUrl: String
    private let serialQueue = DispatchQueue(label: "coffee-manager-queue", qos: .background)
    
    private var headers: HTTPHeaders? {
        var possibleHeaders: HTTPHeaders?
        
            possibleHeaders = HTTPHeaders.default
            possibleHeaders?.add(.defaultUserAgent)
            possibleHeaders?.add(.defaultAcceptLanguage)

        return possibleHeaders
    }
    
    private func targetURL(with url: String?) -> String {
        self.baseURL() + (url ?? "")
    }
    
    // MARK: Lifecycle
   public required init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    // MARK: Private methods
    private func baseURL() -> String {
        
        return baseUrl
    }
   
    private func prefferedParametersEncoding(httpMethod: HTTPMethod) -> ParameterEncoding {
        switch httpMethod {
        case .get: // add other if need (POST, PUT, DELETE)
            return URLEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    private func processResponse(response: AFDataResponse<Any>, successHandler: (_ data: Data) -> (), failureHandler: (_ error: CError) -> ()) {
        
        if let error = response.error  {
            failureHandler(CError(code: response.response?.statusCode ?? 0, message: error.localizedDescription))
            return
        }
        
        // Response should contain http response?
        guard let httpResponse = response.response else {
            return
        }
        
        // Response should contains JSON
        guard let responseData = response.data else { return }
        
        switch httpResponse.statusCode {
        case 200...299:
            successHandler(responseData)
            break
        default:
            // Error with message
            guard let json = try? response.result.get() as? NSDictionary else { return }
            let message = json["message"] as? String
            let error = CError(code: httpResponse.statusCode, message: message ?? "Undefined error")
            failureHandler(error)
            break
        }
    }
}

extension SessionManager: SessionManagerProtocol {
    
    public func makeRequest(url: String?,
                            method: HTTPMethod,
                            params: [String : Any]?,
                            success: @escaping (_ data: Data) -> (),
                            failure: @escaping (_ error: CError) -> ()) {
        
        
        AF.request(self.targetURL(with: url),
                   method: method,
                   parameters: params,
                   encoding: self.prefferedParametersEncoding(httpMethod: method),
                   headers: self.headers)
            .cURLDescription(calling: { curl in
                print(curl)
            })
            .responseJSON(queue: self.serialQueue) { [weak self] response in
                self?.processResponse(response: response, successHandler: success, failureHandler: failure)
            }
    }
    
}
