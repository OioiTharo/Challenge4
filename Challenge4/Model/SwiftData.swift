import SwiftData
import SwiftUI

@Model class ModelLivros{
    var titulo: String
    var autor: String?
    var categorias: String?
    var comentario: String?
    var imagem: Data?
    var avaliacao: Double?
    
    init(titulo: String, autor: String? = nil, categorias: String? = nil, comentario: String? = nil, imagem: Data? = nil, avaliacao: Double? = nil) {
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

@Model class ModelMetas{
    var numeroMeta: Int16?
    
    init(numeroMeta: Int16? = nil) {
        self.numeroMeta = numeroMeta
    }
}
