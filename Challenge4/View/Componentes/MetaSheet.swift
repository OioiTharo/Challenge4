import SwiftUI

struct MetaSheet: View {
    @Binding var meta: String
    @Binding var mostrarSheet: Bool
    var onSave: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Escolha sua Meta anual de Livros: ")
            TextField("Digite um número", text: $meta)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Spacer()
                Button(action: {
                    onSave()
                    mostrarSheet = false
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.roxoEscuro)
                            .frame(width: 80, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("Salvar")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 10)
                }
                .padding(.horizontal, 30)
                Spacer()
            }
        }
        .presentationDetents([.height(200)])
        .padding(.horizontal)
    }
}
