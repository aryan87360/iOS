//
//  ContentView.swift
//  ToDoList-SwiftUI
//
//  Created by Aryan Sharma on 13/10/23.
//
import FirebaseCore
import SwiftUI

@main
struct ToDoList_SwiftUIApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
