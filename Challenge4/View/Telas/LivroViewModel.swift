import SwiftUI
import PhotosUI
import CoreData

class LivroViewModel: ObservableObject {
    private var context: NSManagedObjectContext
    @Published var selecionarItem: PhotosPickerItem?
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func salvarLivro(livro: Livros) throws {
        print("Tentando salvar livro...")
        print("Título: \(livro.titulo ?? "Sem título")")
        print("Avaliaçao: \(livro.avaliacao)")
        print("Autor: \(livro.autor ?? "Desconhecido")")
        print("Comentario: \(livro.comentario ?? "Nenhum")")
        print("Imagem: \(String(describing: livro.imagem))")
        print("Categorias: \(livro.arrayCategorias)")
        
        if context.hasChanges {
            try context.save()
            print("Livro salvo com sucesso!")
        } else {
            print("Nenhuma mudança para salvar")
        }
    }
    
    func deletarLivro(livro: Livros) throws {
        context.delete(livro)
        try context.save()
        print("Livro deletado com sucesso!")
    }
}

enum LivroError: Error {
    case noChangesToSave
    
    var localizedDescription: String {
        switch self {
        case .noChangesToSave:
            return "Não há alterações para salvar"
        }
    }
}
