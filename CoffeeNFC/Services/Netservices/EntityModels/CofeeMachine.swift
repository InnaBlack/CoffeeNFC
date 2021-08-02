//
//  CofeeMachine.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import Foundation


// MARK: - CofeeMachine
struct CofeeMachine: Codable {
    let types: [TypeElement]
    let sizes: [SizeElement]
    let extras: [ExtraElement]
}

// MARK: - Extra
struct ExtraElement: Codable {
    let id: String
    let name: String
    let subselections: [SizeElement]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, subselections
    }
}

// MARK: - Size
struct SizeElement: Codable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let id, name: String
    let sizes, extras: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, sizes, extras
    }
}
