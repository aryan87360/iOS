//
//  Password_ManagerApp.swift
//  Password Manager
//
//  Created by Aryan Sharma on 02/05/24.
//

import SwiftUI

@main
struct Password_ManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
