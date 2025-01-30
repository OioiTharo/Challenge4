import SwiftUI
import PhotosUI
import UIKit
import CoreData

struct BookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: LivroViewModel

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: LivroViewModel(context: context))
    }

    var body: some View {
        VStack {
            // Exibir a capa do livro ou placeholder
            if let imageData = viewModel.imagem, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 220)
                    .overlay(Text("Selecionar Capa").foregroundColor(.gray))
            }


            // Botão para selecionar imagem
            PhotosPicker(selection: $viewModel.selecionarItem, matching: .images) {
                Text("Escolher Foto")
                    .font(.headline)
            }
            .onChange(of: viewModel.selecionarItem) { _ in
                viewModel.carregarImagemSelecionad()
            }

            // Campo de título
            TextField("Título do Livro", text: $viewModel.titulo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Slider para avaliação
            HStack {
                Text("Avaliação:")
                Slider(value: $viewModel.avalicao, in: 1...5, step: 1)
            }
            .padding()

            // Seleção de múltiplas categorias
            VStack(alignment: .leading) {
                Text("Categorias:")
                    .font(.headline)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(viewModel.listadeCategorias, id: \.self) { categorias in
                        Button(action: {
                            toggleCategory(categorias)
                        }) {
                            Text(categorias)
                                .padding()
                                .frame(minWidth: 80)
                                .background(viewModel.selecionarCategoria.contains(categorias) ? Color.blue.opacity(0.7) : Color.gray.opacity(0.3))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()

            // Campo de descrição
            TextEditor(text: $viewModel.comentario)
                .frame(height: 100)
                .border(Color.gray, width: 1)
                .padding()

            // Botão para salvar livro
            Button(action: {
                viewModel.salvarLivro()
            }) {
                Text("Salvar Livro")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }

    // Função para selecionar/deselecionar categorias
    private func toggleCategory(_ categorias: String) {
        if viewModel.selecionarCategoria.contains(categorias) {
            viewModel.selecionarCategoria.removeAll { $0 == categorias }
        } else {
            viewModel.selecionarCategoria.append(categorias)
        }
    }
}
 
