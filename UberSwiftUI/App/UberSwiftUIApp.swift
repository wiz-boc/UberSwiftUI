//
//  UberSwiftUIApp.swift
//  UberSwiftUI
//
//  Created by wizz on 4/9/23.
//

import SwiftUI

@main
struct UberSwiftUIApp: App {
    
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
