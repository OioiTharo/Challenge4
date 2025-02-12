import Foundation
import SwiftUI
import CoreData

class MetaProgressModel: ObservableObject {
    private var viewContext: NSManagedObjectContext
    
    @Published var progresso: Double = 0.0
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func getMeta() -> Meta {
        let fetchRequest: NSFetchRequest<Meta> = Meta.fetchRequest()
        
        do {
            let metas = try viewContext.fetch(fetchRequest)
            return metas.first ?? Meta(context: viewContext)
        } catch {
            print("Erro ao buscar meta: \(error)")
            return Meta(context: viewContext)
        }
    }
    
    func getLivros() -> [Livros] {
        let fetchRequest: NSFetchRequest<Livros> = Livros.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Livros.titulo, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "titulo != nil")
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Erro ao buscar livros: \(error)")
            return []
        }
    }
    
    func calcularProgressoBarra(progresso: Double) -> Double {
        if progresso > 1 {
            return 0.9
        } else {
            return 0.4 + (progresso * 0.5)
        }
    }
    
    func calcularMeta() {
        let livros = getLivros()
        let meta = getMeta()
        
        let qtdLivros = livros.count
        let numeroMeta = Int(meta.numeroMeta)
        
        progresso = numeroMeta > 0 ? Double(qtdLivros) / Double(numeroMeta) : 0.0
        
        print("Livros: \(qtdLivros), Meta: \(numeroMeta), Progresso: \(progresso)")
    }
}
