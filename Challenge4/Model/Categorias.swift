import Foundation

var listadeCategorias = ["❤️ Romance", "👽 Ficção", "🥲 Drama", "🏰 Fantasia", "🧗‍♂️ Ação e aventura", "🔪 Terror", "📚 Estudos", "📜 Clássicos"]


var CategoriasLivros: [String: String] = [
    "🏰 Fantasia": "255, 193, 69",
    "🧗‍♂️ Ação e aventura": "255, 106, 13",
    "📜 Clássicos": "138, 74, 37" ,
    "🥲 Drama": "42, 96, 211",
    "📚 Estudos": "65, 213, 203",
    "👽 Ficção": "36, 174, 15" ,
    "🔪 Terror": "169, 84, 75",
    "❤️ Romance": "255, 75, 70"
]

/*
 if let color = Color(hex: categoria.cor) { // Convertendo a cor
                                         let corAtual = categoria.cor
                                         let rgb = corAtual.split(separator: ",").map { Double($0.trimmingCharacters(in: .whitespaces)) ?? 0.0 }
                                         let color = Color(red: rgb[0] / 255, green: rgb[1] / 255, blue: rgb[2] / 255)
                                         
                                         Circle()
                                             .fill(color)
                                             .frame(width: 25)
                                     }
 */



