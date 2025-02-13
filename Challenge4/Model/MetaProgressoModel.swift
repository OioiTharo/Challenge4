import Foundation
import SwiftUI
import SwiftData

class MetaProgressModel: ObservableObject {
    @Published
    private var modelContext: ModelContext
    var progresso: Double = 0.0
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getMeta() -> Metas? {
        let descriptor = FetchDescriptor<Metas>()
        
        do {
            let metas = try modelContext.fetch(descriptor)
            return metas.first ?? Metas(numeroMeta: 0)
        } catch {
            print("Erro ao buscar meta: \(error)")
            return Metas(numeroMeta: 0)
        }
    }
    
    func getLivros() -> [Livros] {
        let descriptor = FetchDescriptor<Livros>(
            predicate: #Predicate<Livros> { livro in
                livro.titulo != nil
            },
            sortBy: [SortDescriptor(\Livros.titulo, order: .forward)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
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
        guard let meta = getMeta() else { return }
        
        let qtdLivros = livros.count
        let numeroMeta = Int(meta.numeroMeta)
        
        progresso = numeroMeta > 0 ? Double(qtdLivros) / Double(numeroMeta) : 0.0
        
        print("Livros: \(qtdLivros), Meta: \(numeroMeta), Progresso: \(progresso)")
    }
}
