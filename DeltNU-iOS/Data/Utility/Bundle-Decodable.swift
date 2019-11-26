//
//  Bundle-Decodable.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter() //"2019-03-07T13:00:39.369-05:00"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
//        var createdAtDate: Date? {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//            let sub = String(self.createdAt.prefix(19))
//            print(sub)
//            return formatter.date(from: sub)
//        }
//
//        var formattedCreatedAtDate: String {
//            if let date = createdAtDate {
//                let formatter = DateFormatter()
//                formatter.dateStyle = .long
//                return formatter.string(from: date)
//            } else {
//                return "N/A"
//            }
//        }
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
