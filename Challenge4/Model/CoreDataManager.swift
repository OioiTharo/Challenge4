import Foundation
import CoreData

class CoreDataManager {
    let persistenteContainer: NSPersistentContainer
    
    static let shered: CoreDataManager = CoreDataManager()
    
    private init() {
        
        persistenteContainer = NSPersistentContainer(name: "Challenge4")
        persistenteContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Erro em inicializar Coredata \(error)")
            }
        }
    }
}
