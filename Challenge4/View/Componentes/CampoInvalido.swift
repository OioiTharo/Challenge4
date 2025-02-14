import SwiftUI

struct CampoInvalido: View {
    var body: some View {
        Text("Por favor, informe o título do livro")
            .foregroundStyle(.red)
    }
}

#Preview {
    CampoInvalido()
}
