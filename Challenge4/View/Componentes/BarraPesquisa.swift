import SwiftUI

struct BarraPesquisa: View {
    @Binding var textoPesquisa: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.roxoClarissimo)
                .frame(height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                TextField("Procure livros na sua estante", text: $textoPesquisa)
            }
            .padding(.horizontal, 15)
        }
    }
}
