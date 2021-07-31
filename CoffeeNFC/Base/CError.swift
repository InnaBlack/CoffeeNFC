//
//  SError.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import Foundation

public class CError: Error {
 
    public let code: Int
    public let message: String
    
    
    public init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
    
    public init(message: String) {
        self.code = 0
        self.message = message
    }
    
    public init(error: Error) {
        self.code = 0
        self.message = error.localizedDescription
    }
}
