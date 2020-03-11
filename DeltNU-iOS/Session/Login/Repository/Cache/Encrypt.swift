//
//  SaltCache.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/6/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation
import CryptoSwift

class Encrypt {
    private let defaults = UserDefaults.standard
    private let keyCache = "key::key"
    private let ivCache = "key::iv"
    
    func quickEncrypt(_ str: String) -> String {
        let key = getKey()
        let iv = getIv()
        guard
            let data = str.data(using: .utf8),
            let bytes = try? ChaCha20(key: key, iv: iv).encrypt(data.bytes)
            else { return str }
        return Data(bytes).toHexString()
    }
    
    func quickDecrypt(_ str: String) -> String {
        let key = getKey()
        let iv = getIv()
        guard
            let bytes = try? ChaCha20(key: key, iv: iv).decrypt(Array<UInt8>(hex: str)),
            let decryptedString = String(data: Data(bytes), encoding: .utf8)
            else { return str }
        return decryptedString
    }
    
    func getKey() -> Array<UInt8> {
        guard let key = defaults.array(forKey: keyCache) as? Array<UInt8> else {
            return makeKey()
        }
        return key
    }
    
    func makeKey() -> Array<UInt8> {
        let arr = randomArray(length: 32)
        defaults.set(arr, forKey: keyCache)
        return arr
    }
    
    func getIv() -> Array<UInt8> {
        guard let salt = defaults.array(forKey: ivCache) as? Array<UInt8> else {
            return makeIv()
        }
        return salt
    }
    
    func makeIv() -> Array<UInt8> {
        let str = randomArray(length: 12)
        defaults.set(str, forKey: ivCache)
        return str
    }
    
    func randomArray(length: Int) -> Array<UInt8> {
        var ret: [UInt8] = Array(repeating: 0x00, count: length)
        for i in 0...(length - 1) {
            ret[i] = UInt8.random(in: 1...100)
        }
        return ret
    }
    
    func clearCredentials() {
        defaults.removeObject(forKey: keyCache)
        defaults.removeObject(forKey: ivCache)
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
