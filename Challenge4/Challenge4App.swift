import SwiftUI

@main
struct MeuApp: App {
    let persistenceController = CoreDataManager.shered

    var body: some Scene {
        WindowGroup {
            BarraNavegacao(context: persistenceController.persistenteContainer.viewContext)
                .environment(\.managedObjectContext, persistenceController.persistenteContainer.viewContext)
        }
    }
}
