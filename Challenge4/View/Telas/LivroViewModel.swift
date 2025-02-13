//import SwiftUI
//import PhotosUI
//import SwiftData
//
//class LivroViewModel: ObservableObject {
//    @Environment(\.modelContext) private var viewContext
////    @Query private var livro: [Livros]
//    @Published var selecionarItem: PhotosPickerItem?
//        
////    init(context: NSManagedObjectContext){
////        self.context = context
////    }
////        
//    func salvarLivro(livro: Livros) throws {
//        print("Tentando salvar livro...")
//        print("Título: \(livro.titulo ?? "Sem título")")
//        print("Avaliaçao: \(livro.avaliacao)")
//        print("Autor: \(livro.autor ?? "Desconhecido")")
//        print("Comentario: \(livro.comentario ?? "Nenhum")")
//        print("Imagem: \(String(describing: livro.imagem))")
//        print("Categorias: \(livro.arrayCategorias)")
//        
//        if viewContext.hasChanges {
//            do {
//                try viewContext.save()
//                print("Livro salvo com sucesso!")
//            } catch {
//                print("Erro ao salvar livro: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func deletarLivro(livro: Livros) throws{
//          do {
//              viewContext.delete(livro)
//              try viewContext.save()
//              print("Livro deletado com sucesso!")
//          } catch {
//              print("Erro ao deletar livro: \(error.localizedDescription)")
//          }
//      }
//}
