//
//  LearnUpApp.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 24/07/22.
//

import SwiftUI

@main
struct LearnUpApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
