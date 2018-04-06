//
//  TypesafeUserDefaults.swift
//  
//
//  Created by Andreas Kern on 28.03.18.
//

import Foundation

public protocol DefaultsArchivable {}
public protocol CustomDefaultsArchivable: DefaultsArchivable, Codable {}

extension Array: DefaultsArchivable {}
extension Bool: DefaultsArchivable {}
extension Data: DefaultsArchivable {}
extension Date: DefaultsArchivable {}
extension Dictionary: DefaultsArchivable where Key == String {}
extension Double: DefaultsArchivable {}
extension Float: DefaultsArchivable {}
extension Int: DefaultsArchivable {}
extension String: DefaultsArchivable {}
extension URL: DefaultsArchivable {}

public struct DefaultsKey<T> where T: DefaultsArchivable {
    let name: String

    public init(_ name: String) {
        self.name = name
    }
}

public struct DefaultsFallbackKey<T> where T: DefaultsArchivable {
    let name: String
    let fallbackValue: T

    public init(_ name: String, _ fallbackValue: T) {
        self.name = name
        self.fallbackValue = fallbackValue
    }
}

extension UserDefaults {
    public func value<T>(forKey key: DefaultsKey<T>) -> T? {
        return value(forKey: key.name) as? T
    }

    public func value(forKey key: DefaultsKey<URL>) -> URL? {
        return url(forKey: key.name)
    }

    public func value<T: CustomDefaultsArchivable>(forKey key: DefaultsKey<T>) -> T? {
        guard let jsonData = data(forKey: key.name) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }

    public func value<T>(forKey key: DefaultsFallbackKey<T>) -> T {
        return value(forKey: key.name) as? T ?? key.fallbackValue
    }

    public func value(forKey key: DefaultsFallbackKey<URL>) -> URL {
        return url(forKey: key.name) ?? key.fallbackValue
    }

    public func value<T: CustomDefaultsArchivable>(forKey key: DefaultsFallbackKey<T>) -> T {
        guard let jsonData = data(forKey: key.name) else {
            return key.fallbackValue
        }
        return (try? JSONDecoder().decode(T.self, from: jsonData)) ?? key.fallbackValue
    }

    public func set<T>(_ value: T?, forKey key: DefaultsKey<T>) {
        set(value, forKey: key.name)
    }

    public func set(_ value: URL?, forKey key: DefaultsKey<URL>) {
        set(value, forKey: key.name)
    }

    public func set<T: CustomDefaultsArchivable>(_ value: T?, forKey key: DefaultsKey<T>) {
        let jsonData = try? JSONEncoder().encode(value)
        set(jsonData, forKey: key.name)
    }

    public func set<T>(_ value: T?, forKey key: DefaultsFallbackKey<T>) {
        set(value, forKey: key.name)
    }

    public func set(_ value: URL?, forKey key: DefaultsFallbackKey<URL>) {
        set(value, forKey: key.name)
    }

    public func set<T: CustomDefaultsArchivable>(_ value: T?, forKey key: DefaultsFallbackKey<T>) {
        let jsonData = try? JSONEncoder().encode(value)
        set(jsonData, forKey: key.name)
    }

    public subscript<T>(_ key: DefaultsKey<T>) -> T? {
        set { set(newValue, forKey: key) }
        get { return value(forKey: key) }
    }

    public subscript<T>(_ key: DefaultsFallbackKey<T>) -> T {
        set { set(newValue, forKey: key) }
        get { return value(forKey: key) }
    }
}
