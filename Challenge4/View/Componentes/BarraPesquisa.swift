import SwiftUI

struct BarraPesquisa: View {
    @State var textoPesquisa: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.roxoClarissimo)
                .frame(width: .infinity ,height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                TextField("", text: $textoPesquisa)
                    .placeholder(when: textoPesquisa.isEmpty) {
                        Text("Procure livros na sua estante")
                        
                    }
                Spacer()
                Image(systemName: "mic")
                    .font(.title3)
            }
            .padding(.horizontal, 15)
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}


#Preview {
    BarraPesquisa(textoPesquisa: "")
}
