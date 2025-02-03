import SwiftUI

struct BotaoCategoria: View {
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
        } label: {
            HStack {
                Text(categoriaSelecionada)
                    .foregroundColor(.white)
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
            }
            .padding()
            .frame(width: .infinity, height: 35)
            .background(.roxoEscuro)
            .cornerRadius(25)
        }
        .padding(.horizontal)
    }
}
#Preview {
    BotaoCategoria()
}
