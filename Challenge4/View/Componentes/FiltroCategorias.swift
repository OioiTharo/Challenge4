import SwiftUI

struct FiltroCategorias: View {
    @State private var categoriaSelecionada: String? = nil
    
    var body: some View {
        HStack {
            Button(action: {
                categoriaSelecionada = nil
            }) {
                Text("Todas")
                    .foregroundColor(categoriaSelecionada == nil ? .white : .roxoMedio)
                    .padding()
                    .frame(height: 35)
                    .background(categoriaSelecionada == nil ? .roxoMedio : .clear)
                    .cornerRadius(25)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.roxoMedio, lineWidth: 2)
                            .frame(height: 35)
                    }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(Array(CategoriasLivros.keys), id: \.self) { categoria in
                        if let cor = CategoriasLivros[categoria],
                           let color = Color(hex: cor) {
                            let rgb = cor.split(separator: ",").map { Double($0.trimmingCharacters(in: .whitespaces)) ?? 0.0 }
                            let categoriaColor = Color(red: rgb[0] / 255, green: rgb[1] / 255, blue: rgb[2] / 255)
                            
                            Button(action: {
                                
                                categoriaSelecionada = (categoriaSelecionada == categoria) ? nil : categoria
                            }) {
                                Text(categoria)
                                    .foregroundColor(categoriaSelecionada == categoria ? .white : categoriaColor)
                                    .padding()
                                    .frame(height: 35)
                                    .background(categoriaSelecionada == categoria ? categoriaColor : .clear)
                                    .cornerRadius(25)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(categoriaColor, lineWidth: 2)
                                            .frame(height: 35)
                                    }
                            }
                        }
                    }
                }
                .padding(.vertical)
                .padding(.leading, 2)
            }
        }
    }
}

#Preview {
    FiltroCategorias()
}
