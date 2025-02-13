import Foundation
import SwiftUI
import SwiftData

@Observable
class MetaProgressModel {
    private var progresso: Double = 0.0
    
    func getMeta(_ metas: [Metas]) -> Metas {
        return metas.first ?? Metas(numeroMeta: 0)
    }
    
    func getLivros(_ livros: [Livros]) -> [Livros] {
        return livros.filter { $0.titulo != nil }
            .sorted { $0.titulo ?? "" < $1.titulo ?? "" }
    }
    
    func calcularProgressoBarra(progresso: Double) -> Double {
        if progresso > 1 {
            return 0.9
        } else {
            return 0.4 + (progresso * 0.5)
        }
    }
    
    func calcularMeta(livros: [Livros], meta: Metas) -> Double {
        let qtdLivros = livros.count
        let numeroMeta = Int(meta.numeroMeta)
        
        let progresso = numeroMeta > 0 ? Double(qtdLivros) / Double(numeroMeta) : 0.0
        
        print("Livros: \(qtdLivros), Meta: \(numeroMeta), Progresso: \(progresso)")
        
        return progresso
    }
}
