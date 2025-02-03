
import SwiftUI

struct LivroAmostra: View {
    let livro: Livros  

    var body: some View {
        Button {
           
        } label: {
            VStack {
                if let imageData = livro.imagem, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(2/3, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Text(livro.titulo ?? "Sem título")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 100)
                
                Text(livro.autor ?? "Desconhecido")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

