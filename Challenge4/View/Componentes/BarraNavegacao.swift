import SwiftUI

struct BarraNavegacao: View {
    var body: some View {
        TabView{
            NavigationStack{
                ContentView()
            }
            .tabItem { Label("Início", systemImage: "house") }
            NavigationStack{
                LivrosView()
            }
            .tabItem { Label("Leituras", systemImage: "books.vertical.fill") }
        }
    }
}

#Preview {
    BarraNavegacao()
}
