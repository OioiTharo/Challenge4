import SwiftUI

struct BotaoCategoria: View {
  
    @Binding var categoriasSelecionadas: [String]
    @State private var corCategoria: [String: String] = [:]
    var editando: Bool
    var adcLivro: Bool
    
    init(categoriasSelecionadas: Binding<[String]>, editando: Bool, adcLivro: Bool) {
        self._categoriasSelecionadas = categoriasSelecionadas
        self.editando = editando
        self.adcLivro = adcLivro
        
        var cores: [String: String] = [:]
        for categoria in categoriasSelecionadas.wrappedValue {
            if let cor = CategoriasLivros[categoria] {
                cores[categoria] = cor
            }
        }
        _corCategoria = State(initialValue: cores)
    }

    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categoriasSelecionadas, id: \.self) { categoria in
                        HStack {
                            Text(categoria)
                                .foregroundColor(.white)
                            
                            Button(action: {
                                categoriasSelecionadas.removeAll { $0 == categoria }
                                corCategoria.removeValue(forKey: categoria)
                            }) {
                                if editando || adcLivro{
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .padding(.leading, 4)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(parseColor(from: corCategoria[categoria] ?? "147, 24, 255"))
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal)
            }
            
            Menu {
                ForEach(Array(CategoriasLivros), id: \.key) { categoria, cor in
                    Button(action: {
                        if !categoriasSelecionadas.contains(categoria) {
                            categoriasSelecionadas.append(categoria)
                            corCategoria[categoria] = cor
                        }
                    }) {
                        HStack {
                            Text(categoria)
                            
                            if categoriasSelecionadas.contains(categoria) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                if editando || adcLivro{
                    HStack {
                        Text(categoriasSelecionadas.isEmpty ? "Adicionar Genêro" : "Adicionar Genêro")
                            .foregroundColor(.white)
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(height: 35)
                    .background(.roxoMedio)
                    .cornerRadius(25)
                }
            }
            .padding(.horizontal)
        }
    }
    
    func parseColor(from colorString: String) -> Color {
        let rgb = colorString.split(separator: ",").map {
            Double($0.trimmingCharacters(in: .whitespaces)) ?? 0
        }
        
        guard rgb.count == 3 else { return Color.blue }
        
        return Color(
            red: rgb[0] / 255,
            green: rgb[1] / 255,
            blue: rgb[2] / 255
        )
    }
}
