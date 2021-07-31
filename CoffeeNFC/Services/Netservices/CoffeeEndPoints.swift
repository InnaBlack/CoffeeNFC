//
//  ProfileEndPoints.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//


import Foundation


public protocol EndPointProtocol {
    
    var locale: String { get }
    
    var region: String { get }
    
    var endUrl: String { get }
    
    var params: [String : Any]? { get }
}

public extension EndPointProtocol {
    var locale: String {
        return Locale.current.languageCode ?? "en"
    }
    
    var region: String {
        return Locale.current.regionCode ?? "us"
    }
}

enum CoffeeEndPoints{
    case obtainCofeeMachine(id: String)
}

extension CoffeeEndPoints: EndPointProtocol {
    var endUrl: String {
        switch self {
        case .obtainCofeeMachine(id: let id):
            return "/coffee-machine/\(id)"
        }
    }
    
    var params: [String : Any]? {
        switch self {

        case .obtainCofeeMachine :
            return nil
       // other case if with parameter
        }
    }
}


