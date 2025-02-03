import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Meta.entity(), sortDescriptors: []) var metas: FetchedResults<Meta>

    @State private var mostrarSheetMeta = false
    @State private var progresso: Double = 0.0
    
    var metaEntity: Meta {
            metas.first ?? Meta(context: viewContext)
        }
    
    private var metaNumerica: Int16? {
        return Int16(metaEntity.numeroMeta)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top){
                Text("Meta Anual de Leitura:")
                    .padding(.bottom, 25)
                Text("\(metaEntity.numeroMeta)")
                    .foregroundColor(.roxoEscuro)
                Spacer()
                Button(action: { 
                    mostrarSheetMeta = true
                }) {
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
                    NavigationLink(destination: AdicionarLivroView(livrosEntity: Livros(context: viewContext), context: viewContext)
.navigationBarBackButtonHidden(true)){
                        Text("Adicionar Leitura")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 60)
                            .background(.roxoEscuro)
                            .cornerRadius(25)
                        
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    Spacer()
                }
                
                Text("Ultimas Leituras")
                    .padding(.leading, 20)
                
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 5) {
                    ForEach(0..<3) { livro in
//                        LivroAmostra(livro: livro)
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, -80)
        }
        .padding(.bottom, 50)
        .sheet(isPresented: $mostrarSheetMeta) {
            MetaSheet(metaEntity: metaEntity, mostrarSheet: $mostrarSheetMeta, onSave: calcularMeta)
        }
    }
    
    private func salvarEVoltar() {
        calcularMeta()
        mostrarSheetMeta = false
    }
    
    private func calcularMeta() {
        if let numeroMeta = metaNumerica {
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

