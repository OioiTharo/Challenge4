import SwiftUI
import SwiftData

struct LivroAmostra: View {
    var livro: Livros
    var body: some View {
        
        NavigationLink {
            AdicionarLivroView(livro: livro)
        } label: {
            Group {
                if let titulo = livro.titulo, !titulo.isEmpty{
                    VStack {
                        if let imageData = livro.imagem, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(150/220, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .aspectRatio(2/3, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    VStack {
                                        Image(systemName: "photo")
                                            .foregroundColor(.white)
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    }
                                )
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
                                
                                Text(String(livro.avaliacao ?? 0))
                                    .font(.system(size: 10, weight: .medium))
                            }
                            .padding(.vertical, 4)
                        }
                        .padding(.vertical, 8)
                    }
                    
                }
            }
        }
    }
}
