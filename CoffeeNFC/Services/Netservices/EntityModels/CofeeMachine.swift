//
//  CofeeMachine.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import Foundation

struct CofeeMachine: Codable {
    var  types: [CoffeeType] //TODO
    var  sizes: [CoffeeSize]
    var  extras: [CoffeeExtras]
}

struct CoffeeType: Codable {
    var  id: Int //TODO
    var  name: [CoffeeSize]
}

struct CoffeeSize: Codable {
    var  id: Int //TODO
    var  name: [CoffeeSize]
}

struct CoffeeExtras: Codable {
    var  id: Int //TODO
    var  name: String
    var  subselections: [Subselections]
}

struct Subselections: Codable {
    var  id: Int //TODO
    var  name: String
}
