import SwiftUI

struct Avaliacao: View {
    @State var avaliado: Bool = false
    @Binding var avaliacao: Int
//    @Environment(\.modelContext) private var viewContext
    
    var body: some View {
        HStack{
            ForEach(1...5,  id: \.self){ index in
                Button(action: {
                    avaliacao = index
                    avaliado.toggle()
                }){
                    Image(systemName: avaliacao>=index ? "star.fill" : "star")
                        .foregroundColor(avaliacao>=index ? .amarelo : .roxoEscuro )
                }
            }
            HStack{
                Text("\(avaliacao)")
                    .padding(.trailing, -5)
                Text("/ 5")
                    .opacity(0.3)
            }
        }
    }
}
