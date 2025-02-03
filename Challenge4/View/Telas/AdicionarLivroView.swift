import SwiftUI

struct AdicionarLivroView: View {
    @State private var Titulo: String = ""
    @State private var Autor: String = ""
    @State private var Comentario: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(){
            HStack{
                Text("Adicionar Leitura")
                Spacer()
            }.padding(.horizontal, 20).padding(.vertical)
            AdicionarCapa()
            TextField("Título", text: $Titulo)
                .font(.system(.title2, weight: .bold))
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
                .padding(.bottom, -10)
            TextField("Autor", text: $Autor)
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
            Avaliacao()
            BotaoCategoria()
                .padding(.vertical)
            ZStack(alignment: .top){
                TextEditor(text: $Comentario)
                    .frame(maxHeight: 100)
                    .padding(.horizontal, 10)
                    .opacity(0.6)
                    .background(.roxoClarissimo)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .scrollContentBackground(.hidden)
                if Comentario.isEmpty{
                    HStack{
                        Text("Escreva uma avaliação sobre...")
                            .opacity(0.6)
                        Spacer()
                    }.padding(.horizontal, 35).padding(.top, 8)
                }
            }
            HStack{
                Button(action: {}){
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
#Preview {
    AdicionarLivroView()
}
