import SwiftUI
import CoreData

struct BarraNavegacao: View {
   
    let context: NSManagedObjectContext
    var body: some View {
        
        TabView{
            NavigationStack{
                ContentView()
                    
            }
            .tabItem { Label("Início", systemImage: "house") }
            NavigationStack{
                LivrosView()
                    .environment(\.managedObjectContext, context)
            }
            .tabItem { Label("Leituras", systemImage: "books.vertical.fill") }
        }
    }
}
