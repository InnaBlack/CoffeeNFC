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
