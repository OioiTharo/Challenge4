import SwiftUI

/*struct LivrosView: View {
 var body: some View {
 ScrollView{
 LazyVGrid(columns: [.init(.adaptive( minimum: 50))], spacing: 20) {
 LivroAmostra()
 LivroAmostra()
 }
 }.padding()
 }
 }
 
 #Preview {
 LivrosView()
 }
 
 */
struct LivrosAmostra: Identifiable {
    let id = UUID()
    let nome: String
    let autor: String
}

struct LivrosView: View {
    let livros: [LivrosAmostra] = [
        LivrosAmostra(nome: "Livro 1", autor: "Autor A"),
        LivrosAmostra(nome: "Livro 2", autor: "Autor B"),
        LivrosAmostra(nome: "Livro 3", autor: "Autor C"),
        LivrosAmostra(nome: "Livro 4", autor: "Autor D"),
        LivrosAmostra(nome: "Livro 5", autor: "Autor E"),
        LivrosAmostra(nome: "Livro 6", autor: "Autor F")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(livros) { livro in
                    ZStack{
                        LivroAmostra()
                    }
                }
            }
        }.padding(.horizontal, 20)
    }
}

#Preview {
    LivrosView()
}
