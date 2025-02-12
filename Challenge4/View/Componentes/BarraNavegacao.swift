import SwiftUI
import CoreData

struct BarraNavegacao: View {
    let context: NSManagedObjectContext
    
    var body: some View {
        TabView {
            NavigationStack {
                ContentView(viewContext: context)
            }
            .tabItem {
                Label("Início", systemImage: "house")
            }
            
            NavigationStack {
                LivrosView()
            }
            .tabItem {
                Label("Leituras", systemImage: "books.vertical.fill")
            }
        }
        .environment(\.managedObjectContext, context)
    }
}
