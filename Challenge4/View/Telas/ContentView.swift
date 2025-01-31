import SwiftUI
import CoreData

struct ContentView: View {
    @State private var mostrarSheetMeta = false
    @State private var meta: String = "10"
    @State private var progresso: Double = 0.0
    
    private var metaNumerica: Int? {
        return Int(meta)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top){
                Text("Meta Anual de Leitura:")
                    .padding(.bottom, 25)
                Text("\(meta)")
                    .foregroundColor(.roxoEscuro)
                Spacer()
                Button(action: { mostrarSheetMeta = true }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.roxoEscuro)
                        .font(.title3)
                }
            }
            .padding(.horizontal, 20)
            
            BarraProgresso(progresso: $progresso)
                .frame(maxWidth: 500)
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: { }) {
                        BotaoPrincipal(Texto: "Adicionar Leitura", Largura: .infinity)
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    Spacer()
                }
                
                Text("Ultimas Leituras")
                    .padding(.leading, 20)
                
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 5) {
                    ForEach(0..<3) { _ in
                        LivroAmostra()
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, -80)
        }
        .padding(.bottom, 50)
        .sheet(isPresented: $mostrarSheetMeta) {
            MetaSheet(meta: $meta, mostrarSheet: $mostrarSheetMeta, onSave: calcularMeta)
        }
    }
    
    private func salvarEVoltar() {
        calcularMeta()
        mostrarSheetMeta = false
    }
    
    private func calcularMeta() {
        if let numeroMeta = Int(meta) {
            let qtdLivros: Int = 10
            progresso = Double(qtdLivros) / Double(numeroMeta)
        } else {
            progresso = 0.0
        }
    }
}

#Preview {
    ContentView()
}
