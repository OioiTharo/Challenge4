import SwiftUI
import SwiftData

struct AdicionarLivroView: View {
    @Bindable var livro: Livros
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @FocusState private var isFocused: Bool
    var onChange:(() -> Void)?
    @State var editando: Bool
    @State var adcLivro: Bool
    
    @State private var titulo: String = ""
    @State private var autor: String = ""
    @State private var imagem: Data? = nil
    
    init(livro: Livros, editando: Bool = false, adcLivro: Bool = false) {
        self.livro = livro
        _titulo = State(initialValue: livro.titulo ?? "")
        _autor = State(initialValue: livro.autor ?? "")
        _imagem = State(initialValue: livro.imagem)
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
                    get: { Int(livro.avaliacao ?? 0) },
                    set: { newValue in
                        livro.avaliacao = Double(newValue)
                    }
                )).disabled(!editando && !adcLivro)
                
                BotaoCategoria(categoriasSelecionadas: Binding(
                    get: { livro.arrayCategorias },
                    set: { newValue in
                        livro.arrayCategorias = newValue
                    }
                ), editando: editando, adcLivro: adcLivro)
                .disabled(!editando && !adcLivro)
                .padding(.vertical)
                
                ZStack(alignment: .top){
                    TextEditor(text: Binding(
                        get: { livro.comentario ?? ""},
                        set: { newValue in
                            livro.comentario = newValue
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
                    if livro.comentario?.isEmpty ?? true {
                        HStack{
                            Text("Como foi sua experiência literária?")
                                .opacity(0.6)
                            Spacer()
                        }.padding(.horizontal, 35).padding(.top, 8)
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
                
                if adcLivro || editando {
                    HStack {
                        Button(action: { // botao adcionar ou salvar alteracoes
                            livro.titulo = titulo
                            livro.autor = autor
                            livro.imagem = imagem
                            print(titulo)
                            
                            if adcLivro {
                                livro.idLivro = UUID()
                                modelContext.insert(livro)
                            }
                            
                            do {
                                try? modelContext.save()
                                dismiss()
                                onChange?()
                                editando = false
                            } catch {
                                print("Erro ao salvar: \(error)")
                            }
                        }) {
                            Text(editando ? "Salvar alterações" : "Adicionar")
                                .foregroundColor(.white)
                                .frame(width: 155, height: 40)
                                .background(.roxoEscuro)
                                .cornerRadius(14)
                        }
                        .disabled(titulo.isEmpty || autor.isEmpty)
                        Spacer()
                        Button(action: {
                            dismiss()
                            editando = false
                        }){
                            Text("Cancelar")
                                .foregroundColor(.white)
                                .frame(width: 155, height: 40)
                                .background(.rosa)
                                .cornerRadius(14)
                        }
                    }.padding(.horizontal, 25).padding(.vertical)
                    
                    
                }else{
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
                            modelContext.delete(livro)
                            try? modelContext.save()
                            dismiss()
                          
                        }) {
                            Text("Deletar")
                                .foregroundColor(.white)
                                .frame(width: 155, height: 40)
                                .background(.rosa)
                                .cornerRadius(14)
                        }
                    }
                    .padding(.horizontal, 25).padding(.vertical)
                    
                    
                }
            }
            .onAppear() {
                onChange?()
            }
        }
        
    }
}
