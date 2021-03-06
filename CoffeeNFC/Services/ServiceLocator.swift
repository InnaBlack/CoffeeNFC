//
//  ServiceLocator.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

public final class ServiceLocator {
    
    // MARK: Shared property
    public static let shared = ServiceLocator()
        
    private lazy var services: Dictionary<String, Any> = [:]
    
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    public func addService<T>(service: T) {
        let key = typeName(some: T.self)
        self.services[key] = service
    }
    
    public func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
    
}
