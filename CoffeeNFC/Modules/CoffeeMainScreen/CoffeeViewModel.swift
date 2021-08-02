//
//  CoffeeViewModel.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import Foundation

protocol CoffeeViewModelProtocol {
    var id: String { get }
    var name: String { get }
}

struct CoffeeViewModel: CoffeeViewModelProtocol {
    let id: String
    let name: String
    let sizes: [String]
    let extras: [String]
}
