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
    
    private var metaNumerica: Double {
        return Double(metaEntity.numeroMeta)
    }
    
    @FetchRequest(
        entity: Livros.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Livros.titulo, ascending: true)
        ],
        predicate: NSPredicate(format: "titulo != nil")
    ) var ultimosLivros: FetchedResults<Livros>
    
    var ultimosTresLivros: [Livros] {
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
            
            BarraProgresso(progresso: $progresso)
                .frame(maxWidth: 500)
           
            HStack{
                Spacer()
                NavigationLink(destination: AdicionarLivroView(livrosEntity: Livros(context: viewContext), context: viewContext, adcLivro: true)
                    .navigationBarBackButtonHidden(true)){
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
            MetaSheet(metaEntity: metaEntity, mostrarSheet: $mostrarSheetMeta, onSave: calcularMeta)
        }
        .onAppear {
            viewContext.refreshAllObjects()
            calcularMeta()
        }
        
    }
    private func salvarEVoltar() {
        calcularMeta()
        mostrarSheetMeta = false
    }
    
    private func calcularMeta() {
        print("Total de livros: \(ultimosLivros.count)")
        
        let qtdLivros = ultimosLivros.count
        let numeroMeta = Int(metaEntity.numeroMeta)
        
        progresso = numeroMeta > 0 ? Double(qtdLivros) / Double(numeroMeta) : 0.0
        
        print("Livros: \(qtdLivros), Meta: \(numeroMeta), Progresso: \(progresso)")
    }
}

#Preview {
    ContentView()
}
