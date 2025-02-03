import SwiftUI

struct BotaoCategoria: View {
    @State private var categoriasSelecionadas: [String] = []
    @State private var corCategoria: [String: String] = [:]
    
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
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding(.leading, 4)
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
                HStack {
                    Text(categoriasSelecionadas.isEmpty ? "Selecionar Categorias" : "Adicionar Categorias")
                        .foregroundColor(.white)
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(height: 35)
                .background(.roxoMedio)
                .cornerRadius(25)
            }
            .padding(.horizontal)
        }
    }
    
    func parseColor(from colorString: String) -> Color {
        let rgb = colorString.split(separator: ",").map {
            Double($0.trimmingCharacters(in: .whitespaces)) ?? 0.0
        }
        
        guard rgb.count == 3 else { return Color.blue }
        
        return Color(
            red: rgb[0] / 255,
            green: rgb[1] / 255,
            blue: rgb[2] / 255
        )
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        let scanner = Scanner(string: hexSanitized)
        scanner.scanLocation = 0
        
        if scanner.scanHexInt64(&rgb) {
            let red = Double((rgb >> 16) & 0xFF) / 255.0
            let green = Double((rgb >> 8) & 0xFF) / 255.0
            let blue = Double(rgb & 0xFF) / 255.0
            
            self.init(red: red, green: green, blue: blue)
        } else {
            return nil
        }
    }
}
#Preview {
    BotaoCategoria()
}
