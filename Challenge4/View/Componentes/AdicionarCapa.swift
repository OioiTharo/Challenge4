import SwiftUI
import PhotosUI

struct AdicionarCapa: View {
    @State private var selecionarImagem: UIImage?
    @State private var selecionarItem: PhotosPickerItem?
    
    var body: some View {
        Button(action: {},
               label: {
            PhotosPicker(selection: $selecionarItem, matching: .images) {
                if let selecionarImagem {
                    Image(uiImage: selecionarImagem)
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
                                    .foregroundColor(.white)
                                Text("Adicionar Capa")
                                    .foregroundColor(.white)
                            }
                                .foregroundColor(Color(red: 0.2, green: 0.19607843137254902, blue: 0.21176470588235294))
                        )
                }
                    
            }

            .onChange(of: selecionarItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selecionarImagem = uiImage
                    }
                }
            }
        })
        
    }
}

#Preview {
    AdicionarCapa()
}
