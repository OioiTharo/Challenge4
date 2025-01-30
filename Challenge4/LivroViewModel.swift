
import CoreData
import SwiftUI
import PhotosUI

class LivroViewModel: ObservableObject{
    
    @Published var titulo: String = ""
    @Published var avalicao: Double = 0.0
    @Published var selecionarCategoria: [String] = []
    @Published var comentario: String = ""
    @Published var autor: String = ""
    @Published var imagem: Data? = nil
    @Published var selecionarItem: PhotosPickerItem?
    
    let listadeCategorias = ["Romance", "Ficção", "Drama", "Fantasia", "Ação e aventura", "terror", "Estudos", "Clássicos"]
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func carregarImagemSelecionad(){
        Task{
            if let data = try? await selecionarItem?.loadTransferable(type: Data.self){
                DispatchQueue.main.async{
                    self.imagem = data
                }
            }
        }
    }
    
    func salvarLivro(){
        let novoLivro = LivroBC(context: context)
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
        }catch{
            print("erro a salvar")
        }
    }
}


struct PersistenceController {
    static let shared = PersistenceController()
//
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Livro")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
        container.loadPersistentStores/*completionHandler:*/ { (_, error) in
            if let error = error as NSError? {
                fatalError("Erro ao carregar core data: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
