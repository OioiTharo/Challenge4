import SwiftUI
import CoreData

class MetaViewModel: ObservableObject {
    private var context: NSManagedObjectContext
    
    @Published var meta: Int16 = 0
    
    
    init(context: NSManagedObjectContext) {
        self.context = context
       
    }
    
    func salvarMeta(){
        let novaMeta = Meta(context: context)
        novaMeta.numeroMeta = meta
        
        do{
            try context.save()
            print("Meta salava de : \(meta)")
           
        }catch{
            print("erro a salvar")
        }
    }
}
