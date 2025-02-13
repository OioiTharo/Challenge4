import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) private var viewContext
    @Query private var livro: [Livros]
    
    @State private var mostrarSheetMeta = false
    @State private var mostrarSheetLeitura = false
    @StateObject private var metaModel: MetaProgressModel

    @Query private var metas: [Metas]

    init(modelContext: ModelContext) {
        _metaModel = StateObject(wrappedValue: MetaProgressModel(modelContext: modelContext))
    }
    
    var metaEntity: Metas {
        metas.first ?? Metas(numeroMeta: 0)
    }
    
    private var metaNumerica: Double {
        return Double(metaEntity.numeroMeta)
    }
    
    @Query(
        filter: #Predicate<Livros> {
            livro in
            livro.titulo != nil
        },
        sort: \Livros.titulo,
        order: .reverse
    ) private var ultimosLivros: [Livros]

    var ultimosTresLivros: [Livros] {
        //Array(ultimosLivros.prefix(3))
        
        let livrosValidos = ultimosLivros.filter { livro in
            guard let titulo = livro.titulo, !titulo.isEmpty,
                  let autor = livro.autor, !autor.isEmpty else {
                return false
            }
            return true
        }
        return Array(livrosValidos.prefix(3))
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(alignment: .top){
                Text("Meta Anual de Leitura:")
                    .padding(.bottom, 25)
                Spacer()
                Button(action: {
                    mostrarSheetMeta = true
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.roxoEscuro)
                        .font(.title3)
                }
            }
            .padding(.horizontal, 20).padding(.top, 25)
            
            if ultimosLivros.isEmpty{
                Spacer()
            }
            
            BarraProgresso(progresso: $metaModel.progresso)
                .frame(maxWidth: 500)
            
            HStack {
                Spacer()
                Button(action: {
                    mostrarSheetLeitura = true
                }) {
                    Text("Adicionar Leitura")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 60)
                        .background(.roxoEscuro)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, -80)
                Spacer()
            }
            
            if !ultimosLivros.isEmpty{
                Text("Últimas Leituras")
                    .padding(.leading, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(ultimosTresLivros, id: \.self) { livro in
                            LivroAmostra(livro: livro)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            } else{
                Spacer()
            }
        }
        .padding(.bottom, 50)
        .sheet(isPresented: $mostrarSheetMeta) {
            MetaSheet(
                metaEntity: metaEntity,
                mostrarSheet: $mostrarSheetMeta,
                onSave: metaModel.calcularMeta
            )
        }
        .sheet(isPresented: $mostrarSheetLeitura) {
            //            AdicionarLivroView(
            //                livrosEntity: Livros(context: viewContext),
            //                context: viewContext,
            //                adcLivro: true
            //            )
        }
        
    }
}

//#Preview {
//    ContentView(livro: livro)
//}
