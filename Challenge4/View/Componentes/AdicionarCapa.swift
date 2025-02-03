import SwiftUI
import PhotosUI
import CoreData
struct AdicionarCapa: View {
    @Binding var selecionarImagem: Data?
    @State private var selecionarItem: PhotosPickerItem?
    
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {

            PhotosPicker(selection: $selecionarItem, matching: .images) {
                if let data = selecionarImagem, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 5)
                        
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 220)
                        .overlay(
                            VStack {
                                Image(systemName: "photo.badge.plus")
                                Text("Adicionar Capa")
                            }
                                .foregroundColor(Color(red: 0.2, green: 0.19607843137254902, blue: 0.21176470588235294))
                        )
                }
                    
            }

            .onChange(of: selecionarItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        DispatchQueue.main.async {
                            selecionarImagem = data
                        }
                    }
                }
            }

        
    }
}

//#Preview {
//    AdicionarCapa(selecionarImagem: <#Binding<Data?>#>, livrosEntity: <#Livros#>)
//}
