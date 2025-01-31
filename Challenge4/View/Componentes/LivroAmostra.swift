import SwiftUI

struct LivroAmostra: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .aspectRatio(2/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading){
                    Text("Memórias póstumas de Braz Cubas")
                        .font(.system(size: 14, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(1)
                    
                    Text("Autor")
                        .font(.system(size: 10))
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        .lineLimit(1)
                        .minimumScaleFactor(0.9)
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 10))
                    
                    Text(String(format: "%.1f", 2))
                        .font(.system(size: 10, weight: .medium))
                }
                .padding(.vertical, 4)
            }
            .padding(.vertical, 8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    
}

#Preview {
    LivroAmostra()
}
