//
//  Challenge4App.swift
//  Challenge4
//
//  Created by THAIS RODRIGUES ANDRADE on 29/01/25.
//appentry

import SwiftUI

@main
struct Challenge4App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BookView(context: persistenceController.container.viewContext)
        }
    }
}
