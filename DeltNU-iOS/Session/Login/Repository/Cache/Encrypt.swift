//
//  SaltCache.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/6/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import Foundation

class SaltCache {
    private let defaults = UserDefaults.standard
    private let saltKey = "key::salt"
    private let saltLength = 10
    
    func quickEncrypt(_ str: String) -> String {
        let salt = getSalt()
        var retStr = ""
        var index = 0;
        
        for char in str {
            retStr.append(
                Character(
                    UnicodeScalar(
                        ((Int(char.asciiValue!) + (salt / (10 ^ index))) + 256) % 128
                    )!
                )
            )
            index = (index + 1) % 10
        }
        
        return retStr
    }
    
    func quickDecrypt(_ str: String) -> String {
        let salt = getSalt()
        var retStr = ""
        var index = 0;
        
        for char in str {
            retStr.append(
                Character(
                    UnicodeScalar(
                        ((Int(char.asciiValue!) - (salt / (10 ^ index))) + 256) % 128
                    )!
                )
            )
            index = (index + 1) % 10
        }
        
        return retStr
    }
    
    func getSalt() -> Int {
        let salt = defaults.integer(forKey: saltKey)
        if salt == 0 {
            return makeSalt()
        }
        return salt
    }
    
    func makeSalt() -> Int {
        let str = randomInt(length: saltLength)
        defaults.set(str, forKey: saltKey)
        return str
    }
    
    func randomInt(length: Int) -> Int {
        var ret = 0;
        for i in 0...length {
            ret = ret + 10 ^ i * Int.random(in: 1...9)
        }
        return ret
    }
    
    func clearCredentials() {
        defaults.removeObject(forKey: saltKey)
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
