import SwiftUI
import CoreData

struct LivrosView: View {
    
    @FetchRequest(
        entity: Livros.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Livros.titulo, ascending: true)]
    ) var livros: FetchedResults<Livros>
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            BarraPesquisa(textoPesquisa: "")
                .padding(.horizontal, 25)
                .padding(.top)
            FiltroCategorias()
                .padding(.horizontal, 20)
            Text("Sua estante")
                .padding(.horizontal, 20)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(livros, id: \.self) { livro in
                        ZStack{
                            LivroAmostra(livro: livro)
                        }
                    }
                }
            }.padding(.horizontal, 20)
        }
    }
}

#Preview {
    LivrosView()
}
