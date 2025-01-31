import SwiftUI

struct BotaoPrincipal: View {
    @State var Texto: String
    @State var Largura: Double
    
    var body: some View {
        Text("\(Texto)")
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold))
            .frame(width: self.Largura, height: 60)
            .background(.roxoEscuro)
            .cornerRadius(25)
    }
}

#Preview {
    BotaoPrincipal(Texto: "Adicionar", Largura: 180)
}
