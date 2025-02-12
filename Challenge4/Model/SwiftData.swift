import SwiftData
import SwiftUI

@Model class Livros{
    @Attribute(.unique) var idLivro: UUID
    var titulo: String?
    var autor: String?
    var categorias: String?
    var comentario: String?
    var imagem: Data?
    var avaliacao: Double?
    
    init(titulo: String, autor: String? = nil, categorias: String? = nil, comentario: String? = nil, imagem: Data? = nil, avaliacao: Double? = nil) {
        self.idLivro = UUID()
        self.titulo = titulo
        self.autor = autor
        self.categorias = categorias
        self.comentario = comentario
        self.imagem = imagem
        self.avaliacao = avaliacao
    }
    
    var arrayCategorias: [String] {
        get {
            categorias?.components(separatedBy: ",") ?? []
        }
        set {
            categorias = newValue.joined(separator: ",")
        }
    }
    
}

@Model class Metas{
    var numeroMeta: Int16
    
    init(numeroMeta: Int16) {
        self.numeroMeta = numeroMeta
    }
}
