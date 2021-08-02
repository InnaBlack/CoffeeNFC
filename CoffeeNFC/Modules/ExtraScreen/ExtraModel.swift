//
//  CoffeeViewModel.swift
//  CoffeeNFC
//
//  Created by  inna on 01/08/2021.
//

import Foundation

struct ExtraCoffeeViewModel: CoffeeViewModelProtocol {
    let id: String
    let name: String
    let subselections: [SizeElement]
}
