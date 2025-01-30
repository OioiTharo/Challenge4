import Foundation
import CoreData

@objc(LivroBC)
public class LivroBC: NSManagedObject, Identifiable {

    @NSManaged public var autor: String?
    @NSManaged public var avaliacao: Double
    @NSManaged public var comentario: String?
    @NSManaged public var idLivro: UUID
    @NSManaged public var titulo: String
    @NSManaged public var imagem: Data?
    @NSManaged public var categorias: String?
    
    var arrayCategorias: [String] {
        get {
            categorias?.components(separatedBy: ",") ?? []
        }
        set {
            categorias = newValue.joined(separator: ",")
        }
    }
}
