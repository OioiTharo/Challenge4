import SwiftUI
import CoreData

struct AdicionarLivroView: View {
    @ObservedObject var livrosEntity: Livros
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var livroViewModel: LivroViewModel
    @FocusState private var isFocused: Bool
    var onChange:(() -> Void)?
    @State var editando: Bool
    @State var adcLivro: Bool
    
    @State private var titulo: String = ""
    @State private var autor: String = ""
    @State private var imagem: Data? = nil
    @State private var mostrarAlerta = false
    @State private var mostrarAlerta2 = false
    
    init(livrosEntity: Livros, context: NSManagedObjectContext, editando: Bool = false, adcLivro: Bool = false) {
        self.livrosEntity = livrosEntity
        _livroViewModel = StateObject(wrappedValue: LivroViewModel(context: context))
        _titulo = State(initialValue: livrosEntity.titulo ?? "")
        _autor = State(initialValue: livrosEntity.autor ?? "")
        _imagem = State(initialValue: livrosEntity.imagem)
        _editando = State(initialValue: editando)
        _adcLivro = State(initialValue: adcLivro)
    }
    
    var body: some View {
        ScrollView{
            VStack(){
                HStack{
                    Text(editando ? "Editar Livro" : "Sua Leitura")
                    Spacer()
                }.padding(.horizontal, 20).padding(.bottom).padding(.top)
                
                AdicionarCapa(selecionarImagem: $imagem).disabled(!editando && !adcLivro)
                
                TextField("Título", text: $titulo)
                    .disabled(!editando && !adcLivro)
                    .font(.system(.title2, weight: .bold))
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, -10)
                
                TextField("Autor", text: $autor).disabled(!editando && !adcLivro)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                
                Avaliacao(avaliacao: Binding(
                    get: { Int(livrosEntity.avaliacao) },
                    set: { newValue in
                        livrosEntity.avaliacao = Double(newValue)
                    }
                )).disabled(!editando && !adcLivro)
                
                BotaoCategoria(categoriasSelecionadas: Binding(
                    get: { livrosEntity.arrayCategorias },
                    set: { newValue in
                        livrosEntity.arrayCategorias = newValue
                    }
                ), editando: editando, adcLivro: adcLivro)
                .disabled(!editando && !adcLivro)
                .padding(.vertical)
                
                ZStack(alignment: .top){
                    TextEditor(text: Binding(
                        get: { livrosEntity.comentario ?? ""},
                        set: { newValue in
                            livrosEntity.comentario = newValue
                        }
                    ))
                    .frame(height: 100)
                    .padding(.horizontal, 10)
                    .focused($isFocused)
                    .opacity(0.6)
                    .background(.roxoClarissimo)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .scrollContentBackground(.hidden)
                    .onTapGesture {
                        isFocused = false
                    }
                    if livrosEntity.comentario?.isEmpty ?? true {
                        HStack{
                            Text("Escreva uma avaliação sobre...")
                                .opacity(0.6)
                            Spacer()
                        }.padding(.horizontal, 35).padding(.top, 8)
                    }
                    if !editando && !adcLivro{
                        HStack{
                            Text("Sua avaliação:")
                                .opacity(0.6)
                            Spacer()
                        }.padding(.horizontal, 25).padding(.top, -25)
                    }
                }
                .disabled(!editando && !adcLivro)
                if(editando || adcLivro){
                    HStack{
                        Text("* Obrigatório")
                            .font(.footnote)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding(.horizontal, 20)
                }
                
                if adcLivro{
                    HStack{
                        Button(action: {
                            livrosEntity.idLivro = UUID()
                            do {
                                try livroViewModel.salvarLivro(livro: livrosEntity)
                                presentationMode.wrappedValue.dismiss()
                                onChange?()
                                editando = false
                            } catch {
                                print("Erro ao salvar: \(error)")
                            }
                        }){
                            Text("Adicionar")
                                .foregroundColor(.white)
                                .frame(width: 155, height: 40)
                                .background(.roxoEscuro)
                                .cornerRadius(14)
                        }
                        .disabled(titulo.isEmpty || autor.isEmpty)
                        Spacer()
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            editando = false
                        }){
                            Text("Cancelar")
                                .foregroundColor(.white)
                                .frame(width: 155, height: 40)
                                .background(.rosa)
                                .cornerRadius(14)
                        }
                    }.padding(.horizontal, 25).padding(.vertical)
                }
                /*if adcLivro || editando {
                 HStack {
                 Button(action: {
                 if adcLivro {
                 livrosEntity.idLivro = UUID()
                 }
                 
                 do {
                 try livroViewModel.salvarLivro(livro: livrosEntity)
                 presentationMode.wrappedValue.dismiss()
                 onChange?()
                 editando = false
                 } catch {
                 print("Erro ao salvar: \(error)")
                 }
                 }) {
                 if editando == true{
                 Text("Salvar alterações" )
                 .foregroundColor(.white)
                 .padding(10)
                 .frame(maxWidth: .infinity)
                 .background(.roxoEscuro)
                 .cornerRadius(14)
                 .padding(.horizontal, 10)
                 .alert(isPresented: $mostrarAlerta) {
                 Alert(
                 title: Text("Cuidado!"),
                 message: Text("Tem certeza que deseja alterar essa leitura? 🤔"),
                 primaryButton: .destructive(Text("Alterar")) {
                 do {
                 try livroViewModel.deletarLivro(livro: livrosEntity)
                 presentationMode.wrappedValue.dismiss()
                 } catch {
                 print("Erro ao deletar: \(error)")
                 }
                 },
                 secondaryButton: .cancel()
                 )
                 }
                 } else{
                 Text("Adicionar")
                 .foregroundColor(.white)
                 .frame(width: 155, height: 40)
                 .background(.roxoEscuro)
                 .cornerRadius(14)
                 }
                 }
                 .disabled(titulo.isEmpty || autor.isEmpty)
                 
                 Spacer()
                 if adcLivro == true{
                 Button(action: {
                 presentationMode.wrappedValue.dismiss()
                 editando = false
                 }){
                 Text("Cancelar")
                 .foregroundColor(.white)
                 .frame(width: 155, height: 40)
                 .background(.rosa)
                 .cornerRadius(14)
                 }
                 }
                 }.padding(.horizontal, 25).padding(.vertical)
                 
                 
                 }*/else{
                     if editando{
                         Button(action: {
                             mostrarAlerta2 = true
                         }) {
                             Text("Salvar alterações" )
                                 .foregroundColor(.white)
                                 .padding(10)
                                 .frame(maxWidth: .infinity)
                                 .background(.roxoEscuro)
                                 .cornerRadius(14)
                                 .padding(.horizontal, 20)
                         }.disabled(titulo.isEmpty || autor.isEmpty)
                             .alert(isPresented: $mostrarAlerta2) {
                                 Alert(
                                    title: Text("Atençao!"),
                                    message: Text("As informações anteriores serão alteradas!"),
                                    primaryButton: .default(Text("Alterar")) {
                                        do {
                                            try livroViewModel.salvarLivro(livro: livrosEntity)
                                            presentationMode.wrappedValue.dismiss()
                                            onChange?()
                                            editando = false
                                        } catch {
                                            print("Erro ao salvar: \(error)")
                                        }
                                    },
                                    secondaryButton: .destructive(Text("Cancelar"))
                                 )
                             }
                     }
                     else{
                         HStack{
                             
                             Button(action: {
                                 editando = true
                             }){
                                 Text("Editar")
                                     .foregroundColor(.white)
                                     .frame(width: 155, height: 40)
                                     .background(.roxoEscuro)
                                     .cornerRadius(14)
                             }
                             
                             Spacer()
                             Button(action: {
                                 mostrarAlerta = true
                             }) {
                                 Text("Deletar")
                                     .foregroundColor(.white)
                                     .frame(width: 155, height: 40)
                                     .background(.rosa)
                                     .cornerRadius(14)
                             }
                             .alert(isPresented: $mostrarAlerta) {
                                 Alert(
                                    title: Text("Cuidado!"),
                                    message: Text("Tem certeza de que deseja excluir esta leitura? Esta ação não pode ser desfeita. 🤔"),
                                    primaryButton: .destructive(Text("Deletar")) {
                                        do {
                                            try livroViewModel.deletarLivro(livro: livrosEntity)
                                            presentationMode.wrappedValue.dismiss()
                                        } catch {
                                            print("Erro ao deletar: \(error)")
                                        }
                                    },
                                    secondaryButton: .cancel()
                                 )
                             }
                         }
                         .padding(.horizontal, 25).padding(.vertical)
                     }
                     
                 }
            }
            .onAppear() {
                onChange?()
            }
        }
        
    }
}
