import SwiftUI
import SwiftData

class AdicionarLivroViewModel: ObservableObject {
    @Published var livro: Livros
    @Published var titulo: String
    @Published var autor: String
    @Published var imagem: Data?
    
    @Published var mostrarAlertaSalvar = false
    @Published var mostrarAlertaExcluir = false
    @Published var tituloValido = true

    private var modelContext: ModelContext

    init(livro: Livros, modelContext: ModelContext) {
        self.livro = livro
        self.modelContext = modelContext
        self.titulo = livro.titulo ?? ""
        self.autor = livro.autor ?? ""
        self.imagem = livro.imagem
    }

    func salvarLivro(dismiss: () -> Void, onChange: (() -> Void)?) {
        if titulo.isEmpty {
            tituloValido = false
            return
        }
        
        livro.titulo = titulo
        livro.autor = autor
        livro.imagem = imagem
        livro.idLivro = UUID()
        modelContext.insert(livro)

        do {
            try modelContext.save()
            dismiss()
            onChange?()
        } catch {
            print("Erro ao salvar: \(error)")
        }
    }

    func excluirLivro(dismiss: () -> Void) {
        modelContext.delete(livro)
        try? modelContext.save()
        dismiss()
    }
}
