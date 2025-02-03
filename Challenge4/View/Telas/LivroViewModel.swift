import SwiftUI
import PhotosUI
import CoreData

class LivroViewModel: ObservableObject {
    private var context: NSManagedObjectContext
    
    @Published var titulo: String = ""
    @Published var avalicao: Double = 0.0
    @Published var selecionarCategoria: [String] = []
    @Published var comentario: String = ""
    @Published var autor: String = ""
    @Published var imagem: Data?
    @Published var selecionarItem: PhotosPickerItem?
        
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func carregarImagemSelecionad() {
        guard let selecionarItem = selecionarItem else { return }
        
        selecionarItem.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data {
                        self.imagem = data
                    }
                case .failure(let error):
                    print("Erro ao carregar imagem: \(error)")
                }
            }
        }
    }
    
    func salvarLivro(livro: Livros) throws {
        print("Tentando salvar livro...")
        print("Título: \(livro.titulo ?? "Sem título")")
        print("Avaliaçao: \(livro.avaliacao)")
        print("Autor: \(livro.autor ?? "Desconhecido")")
        print("Imagem: \(String(describing: livro.imagem))") // Verifica se há imagem
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
}
