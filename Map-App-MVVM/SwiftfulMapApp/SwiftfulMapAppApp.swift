//
//  LocationDetailView.swift
//  SwiftfulMapApp
//
//  Created by Aryan Sharma on 12/28/23.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
