//
//  ContentView.swift
//  ToDoList-SwiftUI
//
//  Created by Aryan Sharma on 13/10/23.
//

import Foundation

extension Encodable {
    
    func asDictonary() -> [String: Any] {
        
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
