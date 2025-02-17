import SwiftUI
import CoreData

struct MetaSheet: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var metaEntity: Meta
    @Binding var mostrarSheet: Bool
    var onSave: () -> Void

    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Digite sua Meta anual de Livros: ")
            TextField("Digite um número", text: Binding(
                get: {
                    String(metaEntity.numeroMeta) },
                set: {
                    metaEntity.numeroMeta = Int16($0) ?? metaEntity.numeroMeta
                }
            ))
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Spacer()
                Button(action: {
                    try? viewContext.save()
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
