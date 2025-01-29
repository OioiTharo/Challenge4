import SwiftUI

struct Avaliacao: View {
    @State var avaliado: Bool = false
    @State var avaliacao: Int = 0
    
    var body: some View {
        HStack{
            ForEach(1...5,  id: \.self){ index in
                Button(action: {
                    avaliacao = index
                    avaliado.toggle()
                }){
                    Image(systemName: avaliacao>=index ? "star.fill" : "star")
                        .foregroundColor(Color.purple)
                }
            }
            HStack{
                Text("\(avaliacao).0")
                    .padding(.trailing, -5)
                Text("/ 5.0")
                    .opacity(0.3)
            }
        }
    }
}

#Preview {
    Avaliacao()
}
