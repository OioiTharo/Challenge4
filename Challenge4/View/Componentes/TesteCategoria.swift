import SwiftUI

struct TesteCategoria: View {
    @State private var categoriaSelecionada: String = "Selecionar Categorias"
    var body: some View {
        Menu {
            ForEach(listadeCategorias, id: \.self) { categoria in
                Button(action: {
                    categoriaSelecionada = categoria
                }) {
                    Text(categoria)
                }
            }
        }
    }
}

#Preview {
    TesteCategoria()
}
