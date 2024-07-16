//
//  SomeFilmsApp.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 10.07.2024.
//

import SwiftUI

@main
struct SomeFilmsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarController()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
