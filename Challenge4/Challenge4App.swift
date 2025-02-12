//import SwiftUI
//
//@main
//struct MeuApp: App {
//    let persistenceController = CoreDataManager.shared
//    
//    var body: some Scene {
//        WindowGroup {
//            BarraNavegacao(context: persistenceController.persistentContainer.viewContext)
//                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
//        }
//    }
//}


import SwiftUI

@main
struct MeuApp: App {
    let persistenceController = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            BarraNavegacao(context: persistenceController.persistentContainer.viewContext)
        }
    }
}
