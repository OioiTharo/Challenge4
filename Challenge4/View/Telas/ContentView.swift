import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Meta Anual de Leitura")
                .padding(.leading, 20)
                .padding(.bottom, 25)
            BarraProgresso(progresso: 0.5)
            
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Button(action: {  }) {
                        BotaoPrincipal(Texto: "Adicionar Leitura", Largura: .infinity)
                    }.padding(.vertical)
                        .padding(.horizontal, 30)
                    Spacer()
                }
                Text("Ultimas Leituras")
                    .padding(.leading, 20)
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                
                LazyVGrid(columns: columns, spacing: 5) {
                    LivroAmostra()
                    LivroAmostra()
                    LivroAmostra()
                }
                .padding(.horizontal, 20)
            }
            //TIRAR O NEGATIVO DEPOIS
            .padding(.vertical, -80 )
        }
    }
}

#Preview {
    ContentView()
}
