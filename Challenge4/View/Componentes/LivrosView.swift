import SwiftUI
import SwiftData

struct LivrosView: View {
    @State private var textoPesquisa = ""
    @State private var categoriaSelecionada: String? = nil
    
    @Query(
        sort: \Livros.dataCriacao,
        order: .reverse
    ) private var allLivros: [Livros]
    
    var filteredLivros: [Livros] {
        allLivros.filter { livro in
            guard livro.titulo != nil, !livro.titulo!.isEmpty else {
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
            
            if allLivros.count == 0{
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Image("semLivros")
                            .resizable()
                            .frame(width: 100, height: 122)
                        Text("Adicione uma nova leitura!")
                            .opacity(0.6)
                        
                        Spacer()
                    }
                    Spacer()
                }
            } else{
                if filteredLivros.isEmpty {
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Image("livroTriste")
                                .resizable()
                                .frame(width: 100, height: 122)
                            Text("Nenhum livro encontrado")
                                .opacity(0.6)
                            
                            Spacer()
                        }
                        Spacer()
                    }
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
}
