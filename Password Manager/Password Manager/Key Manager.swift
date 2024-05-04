//
//  Key Manager.swift
//  Password Manager
//
//  Created by Aryan Sharma on 03/05/24.
//

import Foundation
import CryptoKit
import KeychainAccess

struct KeyManager {
    private let keychain = Keychain(service: "com.yourapp.keys")
    private let keyName = "SymmetricKey"

    func getExistingKey() -> SymmetricKey? {
        if let keyData = keychain[data: keyName] {
            return try? SymmetricKey(data: keyData)
        }
        return nil
    }

    func generateAndStoreNewKey() -> SymmetricKey {
        let newKey = SymmetricKey(size: .bits256)
        keychain[data: keyName] = newKey.withUnsafeBytes { Data($0) }
        return newKey
    }

    func getKey() -> SymmetricKey {
        if let existingKey = getExistingKey() {
            return existingKey
        } else {
            return generateAndStoreNewKey()
        }
    }
}
