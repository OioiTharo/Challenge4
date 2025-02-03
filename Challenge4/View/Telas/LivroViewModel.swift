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
    
    func salvarLivro(){
        let novoLivro = Livros(context: context)
        novoLivro.idLivro = UUID()
        novoLivro.titulo = titulo
        novoLivro.avaliacao = avalicao
        novoLivro.comentario = comentario
        novoLivro.autor = autor
        novoLivro.imagem = imagem
        novoLivro.arrayCategorias = selecionarCategoria

        do{
            try context.save()
            print("livro salvo")
            print("titulo: \(titulo)")
            print("autor: \(autor)")
            print("comentario: \(comentario)")
            print("categorias: \(selecionarCategoria)")
            print("imagem: \(imagem)")
            print("avaliacao: \(avalicao)")



        }catch{
            print("erro a salvar")
        }
    }
}
