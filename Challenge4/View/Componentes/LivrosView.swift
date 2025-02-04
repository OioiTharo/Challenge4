import SwiftUI
import CoreData

struct LivrosView: View {
    @State private var textoPesquisa = ""
    @State private var categoriaSelecionada: String? = nil
    
    @FetchRequest(
        entity: Livros.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Livros.titulo, ascending: true)],
        predicate: NSPredicate(value: true)
    ) var allLivros: FetchedResults<Livros>
    
    var filteredLivros: [Livros] {
        allLivros.filter { livro in
            guard livro.titulo != nil, !livro.titulo!.isEmpty,
                  livro.autor != nil, !livro.autor!.isEmpty else {
                return false
            }
            
            let matchesSearch = textoPesquisa.isEmpty ||
                (livro.titulo?.localizedCaseInsensitiveContains(textoPesquisa) ?? false) ||
                (livro.autor?.localizedCaseInsensitiveContains(textoPesquisa) ?? false)
            
            let matchesCategory = categoriaSelecionada == nil ||
                (livro.categorias?.contains(categoriaSelecionada!) ?? false)
            
            return matchesSearch && matchesCategory
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            BarraPesquisa(textoPesquisa: $textoPesquisa)
                .padding(.horizontal, 25)
                .padding(.top)
            
            FiltroCategorias(categoriaSelecionada: $categoriaSelecionada)
                .padding(.horizontal, 20)
            
            Text("Sua estante")
                .padding(.horizontal, 20)
            
            if filteredLivros.isEmpty {
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(filteredLivros, id: \.self) { livro in
                            if let titulo = livro.titulo, !titulo.isEmpty {
                                ZStack {
                                    LivroAmostra(livro: livro)
                                }
                            }
                        }
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}
