import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var livro: [Livros]
    @Query private var metas: [Metas]
    @State private var mostrarSheetLeitura = false
    @State private var mostrarSheetMeta = false
    @State private var progresso: Double = 0
    @Environment(\.modelContext) private var viewContext
    
    let metaProgressModel = MetaProgressModel()
    
    var metaEntity: Metas {
        if metas.isEmpty {
            let novaMeta = Metas(numeroMeta: 0)
            viewContext.insert(novaMeta)
            try? viewContext.save()
            return novaMeta
        }
        return metaProgressModel.getMeta(metas)
    }
    
    @Query(
        sort: \Livros.dataCriacao, 
        order: .reverse
    ) private var ultimosLivros: [Livros]

    var ultimosTresLivros: [Livros] {
        let livrosValidos = ultimosLivros.filter { livro in
            guard let titulo = livro.titulo, !titulo.isEmpty else {
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
            
            BarraProgresso(progresso: $progresso)
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
            .sheet(isPresented: $mostrarSheetLeitura) {
                AdicionarLivroView(livro: Livros(titulo: ""), adcLivro: true)
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
            MetaSheet(metaEntity: metaEntity, mostrarSheet: $mostrarSheetMeta, onSave: calcularMeta)
        }
        .onAppear {
            calcularMeta()
        }
        
    }
    private func salvarEVoltar() {
        calcularMeta()
        mostrarSheetMeta = false
    }
    
    private func calcularMeta() {
        progresso = metaProgressModel.calcularMeta(livros: ultimosLivros, meta: metaEntity)
    }
}

