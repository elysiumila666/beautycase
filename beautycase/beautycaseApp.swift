//
//  beautycaseApp.swift
//  beautycase
//
//  Created by 何顺子 on 2025/8/11.
//

import SwiftUI

@main
struct beautycaseApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.light)
        }
    }
}
