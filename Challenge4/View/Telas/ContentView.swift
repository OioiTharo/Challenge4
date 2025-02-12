//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @StateObject private var metaModel: MetaProgressModel
//    @State private var mostrarSheetMeta = false
//    
//    init(viewContext: NSManagedObjectContext) {
//        _metaModel = StateObject(wrappedValue: MetaProgressModel(viewContext: viewContext))
//    }
//    
//    var metaEntity: Meta {
//        metaModel.getMeta()
//    }
//    
//    @FetchRequest(
//        entity: Livros.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Livros.titulo, ascending: true)
//        ],
//        predicate: NSPredicate(format: "titulo != nil")
//    ) var ultimosLivros: FetchedResults<Livros>
//    
//    var ultimosTresLivros: [Livros] {
//        let livrosValidos = ultimosLivros.filter { livro in
//            guard let titulo = livro.titulo, !titulo.isEmpty,
//                  let autor = livro.autor, !autor.isEmpty else {
//                return false
//            }
//            return true
//        }
//        return Array(livrosValidos.prefix(3))
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack(alignment: .top) {
//                Text("Meta Anual de Leitura:")
//                    .padding(.bottom, 25)
//                Spacer()
//                Button(action: {
//                    mostrarSheetMeta = true
//                }) {
//                    Image(systemName: "pencil")
//                        .foregroundColor(.roxoEscuro)
//                        .font(.title3)
//                }
//            }
//            .padding(.horizontal, 20)
//            .padding(.top, 25)
//            
//            if ultimosLivros.isEmpty {
//                Spacer()
//            }
//            
//            BarraProgresso(
//                progresso: $metaModel.progresso,
//                viewContext: viewContext
//            )
//            .frame(maxWidth: 500)
//           
//            HStack {
//                Spacer()
//                NavigationLink(
//                    destination: AdicionarLivroView(
//                        livrosEntity: Livros(context: viewContext),
//                        context: viewContext,
//                        adcLivro: true
//                    )
//                    .navigationBarBackButtonHidden(true)
//                ) {
//                    Text("Adicionar Leitura")
//                        .foregroundColor(.white)
//                        .frame(width: 300, height: 60)
//                        .background(.roxoEscuro)
//                        .cornerRadius(25)
//                }
//                .padding(.horizontal, 30)
//                .padding(.vertical, -80)
//                Spacer()
//            }
//            
//            if !ultimosLivros.isEmpty {
//                Text("Últimas Leituras")
//                    .padding(.leading, 20)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 10) {
//                        ForEach(ultimosTresLivros, id: \.self) { livro in
//                            LivroAmostra(livro: livro)
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                }
//            } else {
//                Spacer()
//            }
//        }
//        .padding(.bottom, 50)
//        .sheet(isPresented: $mostrarSheetMeta) {
//            MetaSheet(
//                metaEntity: metaEntity,
//                mostrarSheet: $mostrarSheetMeta,
//                onSave: metaModel.calcularMeta
//            )
//        }
//        .onAppear {
//            viewContext.refreshAllObjects()
//            metaModel.calcularMeta()
//        }
//    }
//}
//
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var metaModel: MetaProgressModel
    @State private var mostrarSheetMeta = false
    @State private var mostrarSheetLeitura = false
    @State private var mostrarSheetLivro = false
    @State private var livroSelecionado: Livros?
    
    init(viewContext: NSManagedObjectContext) {
        _metaModel = StateObject(wrappedValue: MetaProgressModel(viewContext: viewContext))
    }
    
    var metaEntity: Meta {
        metaModel.getMeta()
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
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
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
            .padding(.horizontal, 20)
            .padding(.top, 25)
            
            if ultimosLivros.isEmpty {
                Spacer()
            }
            
            BarraProgresso(
                progresso: $metaModel.progresso,
                viewContext: viewContext
            )
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
            
            if !ultimosLivros.isEmpty {
                Text("Últimas Leituras")
                    .padding(.leading, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(ultimosTresLivros, id: \.self) { livro in
                            Button(action: {
                                livroSelecionado = livro
                                mostrarSheetLivro = true
                            }) {
                                LivroAmostra(livro: livro)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            } else {
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
            AdicionarLivroView(
                livrosEntity: Livros(context: viewContext),
                context: viewContext,
                adcLivro: true
            )
        }
        .sheet(isPresented: $mostrarSheetLivro) {
            if let livroSelecionado = livroSelecionado {
                AdicionarLivroView(
                    livrosEntity: livroSelecionado,
                    context: viewContext
                )
            }
        }
        .onAppear {
            viewContext.refreshAllObjects()
            metaModel.calcularMeta()
        }
    }
}
