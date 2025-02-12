import SwiftUI
import SwiftData

class MetaViewModel: ObservableObject {
    private var viewContext: ModelContext
    
    @Published var meta: Int16 = 0
    
    
    init(viewContext: ModelContext) {
        self.viewContext = viewContext
       
    }
    
    func salvarMeta(){
        
        do{
            try viewContext.save()
            print("Meta salava de : \(meta)")
           
        }catch{
            print("erro a salvar")
        }
    }
}
