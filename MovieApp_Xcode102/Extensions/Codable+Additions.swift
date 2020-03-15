//
//  Codable+Additions.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

public extension Decodable where Self: Codable {
    
    static var decoder: JSONDecoder { return JSONDecoder() }
    
    // Create instances of our type from JSON Data.
    init?(jsonData: Data?) {
        guard let data = jsonData,
            let anInstance = try? Self.decoder.decode(Self.self, from: data)
            else { return nil }
        self = anInstance
    }
    
    init?(jsonData2: Data?) {
        do {
            if let data = jsonData2 {
                let anInstance = try Self.decoder.decode(Self.self, from: data)
                self = anInstance
            }
            
        } catch {
            print(error)
        }
        return nil
    }
    
}

extension Encodable where Self: Codable {
    
    static var encoder: JSONEncoder { return JSONEncoder() }
    
    // Return instances as JSON Data.
    func jsonData() -> Data? {
        return try? Self.encoder.encode(self)
    }
    
}


public protocol DecodingTransformer {
    associatedtype Input
    associatedtype Output
    func transform(_ decoded: Input) throws -> Output
}

public protocol EncodingTransformer {
    associatedtype Input
    associatedtype Output
    func transform(_ encoded: Output) throws -> Input
}

public typealias CodableTransformer = DecodingTransformer & EncodingTransformer


public extension KeyedDecodingContainer {
    
    func decode<Transformer: DecodingTransformer>(_ key: KeyedDecodingContainer.Key,
                                                  transformer: Transformer) throws -> Transformer.Output where Transformer.Input : Decodable {
        let decoded: Transformer.Input = try self.decode(key)
        return try transformer.transform(decoded)
    }
    
    func decode<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
    
}

public extension KeyedEncodingContainer {
    
    mutating func encode<Transformer: EncodingTransformer>(_ value: Transformer.Output,
                                                           forKey key: KeyedEncodingContainer.Key,
                                                           transformer: Transformer) throws where Transformer.Input : Encodable {
        let transformed: Transformer.Input = try transformer.transform(value)
        try self.encode(transformed, forKey: key)
    }
    
}

