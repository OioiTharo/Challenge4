import SwiftUI
import PhotosUI
import CoreData

class LivroViewModel: ObservableObject {
    private var context: NSManagedObjectContext

    @Published var selecionarItem: PhotosPickerItem?
        
    init(context: NSManagedObjectContext){
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
            do {
                try context.save()
                print("Livro salvo com sucesso!")
            } catch {
                print("Erro ao salvar livro: \(error.localizedDescription)")
            }
        }
    }
    
    func deletarLivro(livro: Livros) throws{
        do {
            context.delete(livro)
            try context.save()
            print("Livro deletado com sucesso!")
        } catch {
            print("Erro ao deletar livro: \(error.localizedDescription)")
        }
    }

}
