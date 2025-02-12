import SwiftUI
import SwiftData

@main
struct MeuApp: App {
   
    let container: ModelContainer
    
        init() {
            do {
                container = try ModelContainer(for: Livros.self, Metas.self)
            } catch {
                fatalError("Failed to initialize ModelContainer")
            }
        }
    var body: some Scene {
        WindowGroup {
            BarraNavegacao()
        }
    }
}
