//
//  CacheDisk.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import Foundation

final class CacheDisk<Value: Codable> {
    private let cacheDirectory: URL
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval

    init(dateProvider: @escaping () -> Date = Date.init, entryLifetime: TimeInterval = 4 * 60 * 60) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to access Documents directory")
        }
        self.cacheDirectory = documentsDirectory
        do {
            try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            fatalError("Error creating cache directory: \(error)")
        }
        
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }

    func value(forKey key: String) -> Entry? {
        guard let entry = loadFromDisk(forKey: key) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            deleteFromDisk(forKey: key)
            return nil
        }
        
        return entry
    }
    
    func save(_ value: Value, forKey key: String) {
        saveToDisk(value, forKey: key)
    }
    
    func deleteFromDisk(forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Error deleting from disk: \(error)")
        }
    }
    
    func deleteAll() {
        let fileManager = FileManager.default
        do {
            let url = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            if let enumerator = fileManager.enumerator(at: url, includingPropertiesForKeys: nil) {
                while let fileURL = enumerator.nextObject() as? URL {
                    try fileManager.removeItem(at: fileURL)
                }
            }
        }  catch  {
            print(error)
        }
    }
    
    func isValid(forEntry entry: Entry) -> Bool {
        return dateProvider() < entry.expirationDate
    }

    private func saveToDisk(_ value: Value, forKey key: String) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(key: key, value: value, expirationDate: date)
        let fileURL = cacheDirectory.appendingPathComponent(key)
        
        do {
            let data = try JSONEncoder().encode(entry)
            try data.write(to: fileURL)
        } catch {
            print("Error encoding to disk: \(error)")
        }
    }

    private func loadFromDisk(forKey key: String) -> Entry? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        do {
            let data = try Data(contentsOf: fileURL)
            
            return try JSONDecoder().decode(Entry.self, from: data)
        } catch {
            return nil
        }
    }

    final class Entry: Codable {
        let key: String
        let value: Value
        let expirationDate: Date

        init(key: String, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}
