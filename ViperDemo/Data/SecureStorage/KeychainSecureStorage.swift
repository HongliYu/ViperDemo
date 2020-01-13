//
//  KeychainSecureStorage.swift
//  ViperDemo
//
//  Created by Hongli Yu on 08.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

struct KeychainSecureStorage: SecureStorage {

    enum KeychainError: Error {
        case noValue
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }

    func readValue(forKey key: String) throws -> String {
        var query = keychainQuery(withKey: key)

        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue

        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noValue }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }

        // Parse the value string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
            let valueData = existingItem[kSecValueData as String] as? Data,
            let value = String(data: valueData, encoding: String.Encoding.utf8)
            else {
                throw KeychainError.unexpectedItemData
        }

        return value
    }

    func saveValue(_ value: String, forKey key: String) throws {
        // Encode the password into an Data object.
        let encodedValue = value.data(using: String.Encoding.utf8)!

        do {
            // Check for an existing item in the keychain.
            try _ = readValue(forKey: key)

            // Update the existing item with the new password.
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedValue as AnyObject?

            let query = keychainQuery(withKey: key)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        } catch KeychainError.noValue {
            /*
             No value was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = keychainQuery(withKey: key)
            newItem[kSecValueData as String] = encodedValue as AnyObject?

            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
    }

    func deleteValue(forKey key: String) throws {
        // Delete the existing item from the keychain.
        let query = keychainQuery(withKey: key)
        let status = SecItemDelete(query as CFDictionary)

        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
    }

    // MARK: Convenience
    private func keychainQuery(withKey key: String) -> [String: Any] {
        var query: [String: Any] = [:]
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrAccount as String] = key

        return query
    }
}
