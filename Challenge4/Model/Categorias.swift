import Foundation
import SwiftUI

var CategoriasLivros: [String: String] = [
    "🏰 Fantasia": "255, 193, 69",
    "🧗‍♂️ Ação e aventura": "255, 106, 13",
    "📜 Clássicos": "138, 74, 37" ,
    "🥲 Drama": "42, 96, 211",
    "📚 Estudos": "65, 213, 203",
    "👽 Ficção": "36, 174, 15" ,
    "🔪 Terror": "169, 84, 75",
    "💛 Romance": "255, 75, 70"
]

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
