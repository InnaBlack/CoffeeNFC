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
    let sizes: [Size]
    let extras: [Extra]
}

// MARK: - Extra
struct Extra: Codable {
    let id: Int
    let name: String
    let subselections: [Size]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, subselections
    }
}

// MARK: - Size
struct Size: Codable {
    let id: Int
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
