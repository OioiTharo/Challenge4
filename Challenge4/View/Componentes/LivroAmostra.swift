
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
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .aspectRatio(2/3, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading){
                        Text(livro.titulo ?? "Sem título")
                            .font(.system(size: 14, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(1)
                        
                        Text(livro.autor ?? "Desconhecido")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                    }
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 10))
                        
                        Text(String(format: "%.1f", livro.avaliacao))
                            .font(.system(size: 10, weight: .medium))
                    }
                    .padding(.vertical, 4)
                }
                .padding(.vertical, 8)
            }
        }
    }
}
