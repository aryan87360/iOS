//
//  ContentView.swift
//  ToDoList-SwiftUI
//
//  Created by Aryan Sharma on 13/10/23.
//

import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    
    @Published var currentUserId: String = ""
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self]_, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSigned: Bool {
        return Auth.auth().currentUser != nil
    }
}
