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

public struct Key<T> where T: DefaultsArchivable {
    let name: String

    init(_ name: String) {
        self.name = name
    }
}

public struct DefaultKey<T> where T: DefaultsArchivable {
    let name: String
    let defaultValue: T

    init(_ name: String, _ defaultValue: T) {
        self.name = name
        self.defaultValue = defaultValue
    }
}

extension UserDefaults {
    public func value<T>(forKey key: Key<T>) -> T? {
        return value(forKey: key.name) as? T
    }

    public func value(forKey key: Key<URL>) -> URL? {
        return url(forKey: key.name)
    }

    public func value<T: CustomDefaultsArchivable>(forKey key: Key<T>) -> T? {
        guard let jsonData = data(forKey: key.name) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }

    public func value<T>(forKey key: DefaultKey<T>) -> T {
        return value(forKey: key.name) as? T ?? key.defaultValue
    }

    public func value(forKey key: DefaultKey<URL>) -> URL {
        return url(forKey: key.name) ?? key.defaultValue
    }

    public func value<T: CustomDefaultsArchivable>(forKey key: DefaultKey<T>) -> T {
        guard let jsonData = data(forKey: key.name) else {
            return key.defaultValue
        }
        return (try? JSONDecoder().decode(T.self, from: jsonData)) ?? key.defaultValue
    }

    public func set<T>(_ value: T?, forKey key: Key<T>) {
        set(value, forKey: key.name)
    }

    public func set(_ value: URL?, forKey key: Key<URL>) {
        set(value, forKey: key.name)
    }

    public func set<T: CustomDefaultsArchivable>(_ value: T?, forKey key: Key<T>) {
        let jsonData = try? JSONEncoder().encode(value)
        set(jsonData, forKey: key.name)
    }

    public func set<T>(_ value: T?, forKey key: DefaultKey<T>) {
        set(value, forKey: key.name)
    }

    public func set(_ value: URL?, forKey key: DefaultKey<URL>) {
        set(value, forKey: key.name)
    }

    public func set<T: CustomDefaultsArchivable>(_ value: T?, forKey key: DefaultKey<T>) {
        let jsonData = try? JSONEncoder().encode(value)
        set(jsonData, forKey: key.name)
    }

    public subscript<T>(_ key: Key<T>) -> T? {
        set { set(newValue, forKey: key) }
        get { return value(forKey: key) }
    }

    public subscript<T>(_ key: DefaultKey<T>) -> T {
        set { set(newValue, forKey: key) }
        get { return value(forKey: key) }
    }
}
