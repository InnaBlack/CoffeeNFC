//
//  File.swift
//  CoffeeNFC
//
//  Created by  inna on 31/07/2021.
//

import Foundation

public extension JSONDecoder {

    static var backendDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({
            let container = try $0.singleValueContainer()
            _ = try container.decode(String.self)
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "invalid date format")
        })
        return decoder
    }
}

extension Decodable {

    /// Universal method to decode object from JSON.
    /// - parameter object: JSON object. Supported types are:
    ///   - JSON dictionary, e.g. `["field": "value"]`
    ///   - JSON array, e.g. `[ ["field1": "value1"], ["field2": "value2"] ]`
    ///   - JSON string, e.g. `"{"field": "value"}"`
    ///   - JSON binary data.
    static func fromJson(_ json: Any?, decoder: JSONDecoder? = nil) -> Self? {
        guard let json = json else { return nil }
        
        switch json {
        case let jsonDict as [String: Any]:
            return fromJsonDict(jsonDict, decoder: decoder)
            
        case let jsonArray as [Any]:
            return fromJsonArray(jsonArray, decoder: decoder)
            
        case let jsonString as String:
            return fromJsonString(jsonString, decoder: decoder)
            
        case let jsonData as Data:
            return fromJsonData(jsonData, decoder: decoder)
            
        default: return nil
        }
    }
   
    // MARK: - Private API
    
    /// Decodes object from JSON string.
    private static func fromJsonString(_ jsonString: String?, decoder: JSONDecoder? = nil) -> Self? {
        return internalFromJsonString(jsonString, decoder: decoder)
    }
    
    /// Decodes object from JSON dictionary.
    private static func fromJsonDict(_ dictionary: [String: Any]?, decoder: JSONDecoder? = nil) -> Self? {
        if let dictionary = dictionary, let jsonData = try? JSONSerialization.data(withJSONObject: dictionary) {
            return internalFromJsonData(jsonData, decoder: decoder) ?? nil
        }
        return nil
    }
    
    /// Decodes object from JSON array.
    private static func fromJsonArray(_ array: [Any]?, decoder: JSONDecoder? = nil) -> Self? {
        if let array = array, let jsonData = try? JSONSerialization.data(withJSONObject: array) {
            return internalFromJsonData(jsonData, decoder: decoder) ?? nil
        }
        return nil
    }
    
    /// Decodes object from JSON data.
    private static func fromJsonData(_ jsonData: Data?, decoder: JSONDecoder? = nil) -> Self? {
        return internalFromJsonData(jsonData, decoder: decoder) ?? nil
    }
    
    private static func internalFromJsonString<T: Decodable>(_ jsonString: String?, decoder: JSONDecoder? = nil) -> T? {
        guard let jsonString = jsonString else { return nil }
        let decoded = fromJsonData(jsonString.data(using: .utf8), decoder: decoder)
        return decoded as? T
    }
    
    private static func internalFromJsonData<T: Decodable>(_ jsonData: Data?, decoder: JSONDecoder? = nil) -> T? {
        guard let jsonData = jsonData else { return nil }
        
        do {
            return try (decoder ?? JSONDecoder.backendDecoder).decode(T.self, from: jsonData)
            
        } catch {
            print("❌ Failed to deserialize object: \(error)")
            return nil
        }
    }
    
}


