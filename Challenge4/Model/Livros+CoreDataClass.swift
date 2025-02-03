import Foundation
import CoreData
import UIKit

@objc(Livros)
public class Livros: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Livros> {
        return NSFetchRequest<Livros>(entityName: "Livros")
    }

    @NSManaged public var autor: String?
    @NSManaged public var avaliacao: Double
    @NSManaged public var categorias: String?
    @NSManaged public var comentario: String?
    @NSManaged public var idLivro: UUID?
    @NSManaged public var imagem: Data?
    @NSManaged public var titulo: String?

    var arrayCategorias: [String] {
        get {
            categorias?.components(separatedBy: ",") ?? []
        }
        set {
            categorias = newValue.joined(separator: ",")
        }
    }
}

extension Livros : Identifiable {

}


