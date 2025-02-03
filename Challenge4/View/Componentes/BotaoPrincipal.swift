import SwiftUI

struct BotaoPrincipal: View {
    @State var Texto: String
    @State var Largura: Double
    
    var body: some View {
        Button(action: {
            
        }, label: {
            ZStack{
                Rectangle()
                    .fill(Color.roxoEscuro)
                    .frame(width: self.Largura ,height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("\(Texto)")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
            }
        })

       
    }
}

#Preview {
    BotaoPrincipal(Texto: "Adicionar", Largura: 180)
}
