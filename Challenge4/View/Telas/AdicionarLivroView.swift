import SwiftUI
import CoreData

struct AdicionarLivroView: View {
    @ObservedObject var livrosEntity: Livros
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var livroViewModel: LivroViewModel
    
    init(livrosEntity: Livros, context: NSManagedObjectContext) {
            self.livrosEntity = livrosEntity
            _livroViewModel = StateObject(wrappedValue: LivroViewModel(context: context))
        }
    
    var body: some View {
        VStack(){
            HStack{
                Text("Adicionar Leitura")
                Spacer()
            }.padding(.horizontal, 20).padding(.vertical)
            
            AdicionarCapa(selecionarImagem: Binding(
                get: { livrosEntity.imagem },
                set: { newValue in livrosEntity.imagem = newValue}
            ))
            
            TextField("Título", text: Binding(
                get: {
                    livrosEntity.titulo ?? "" },
                set: { newValue in
                        livrosEntity.titulo = newValue
                    }
            ))
                .font(.system(.title2, weight: .bold))
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
                .padding(.bottom, -10)
            TextField("Autor", text: Binding(
                get: {
                    livrosEntity.autor ?? "" },
                set: { newValue in
                        livrosEntity.autor = newValue
                    }
            ))
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
            Avaliacao()
            BotaoCategoria()
                .padding(.vertical)
            ZStack(alignment: .top){
                TextEditor(text: Binding(
                    get: {
                        livrosEntity.comentario ?? "Escrave" },
                    set: { newValue in
                            livrosEntity.comentario = newValue
                        }
                ))
                    .frame(maxHeight: 100)
                    .padding(.horizontal, 10)
                    .opacity(0.6)
                    .background(.roxoClarissimo)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .scrollContentBackground(.hidden)
//                if livrosEntity.comentario.isEmpty{
//                    HStack{
//                        Text("Escreva uma avaliação sobre...")
//                            .opacity(0.6)
//                        Spacer()
//                    }.padding(.horizontal, 35).padding(.top, 8)
//                }
            }
            HStack{
                Button(action: {
                    try? livroViewModel.salvarLivro(livro: livrosEntity)
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Adicionar")
                        .foregroundColor(.white)
                        .frame(width: 155, height: 40)
                        .background(.roxoEscuro)
                        .cornerRadius(14)
                }
                Spacer()
                Button(action: {presentationMode.wrappedValue.dismiss()}){
                    Text("Cancelar")
                        .foregroundColor(.white)
                        .frame(width: 155, height: 40)
                        .background(.rosa)
                        .cornerRadius(14)
                }
            }.padding(.horizontal, 25).padding(.vertical)
        }
    }
}
//#Preview {
//    AdicionarLivroView(livrosEntity: Livros(context: viewContext), context: viewContext)
//}
