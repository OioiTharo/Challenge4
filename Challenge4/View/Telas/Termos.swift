import SwiftUI

struct Termos: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Política de Privacidade e\nTermos de Uso - Booki")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("Última atualização: 13 de fevereiro de 2025")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 8)
                
                VStack(alignment: .leading, spacing: 24) {
                    SecaoTermos(titulo: "1. Introdução") {
                        Text("Bem-vindo ao Booki! Este documento estabelece os termos e condições para o uso do aplicativo Booki, bem como nossa política de privacidade. Ao usar nosso aplicativo, você concorda com estes termos e políticas.")
                    }
                    SecaoTermos(titulo: "2. Coleta e Uso de Dados") {
                        SubsecaoTermos(titulo: "2.1 Dados armazenados") {
                            BulletList {
                                "Informações sobre seus livros (título, autor, avaliação)"
                                "Imagens de capa selecionadas da sua galeria"
                                "Suas metas de leitura"
                                "Comentários e anotações pessoais"
                                "Categorias de livros"
                            }
                        }
                        
                        SubsecaoTermos(titulo: "2.2 Acesso à Galeria") {
                            Text("O aplicativo solicita acesso à sua galeria de fotos apenas para permitir que você selecione imagens de capa para seus livros. Estas imagens são armazenadas localmente e não são compartilhadas com terceiros.")
                        }
                        
                        SubsecaoTermos(titulo: "2.3 Não Coletamos") {
                            BulletList {
                                "Dados pessoais de identificação"
                                "Informações de localização"
                                "Dados de navegação"
                                "Informações de pagamento"
                                "Dados de uso do aplicativo"
                            }
                        }
                    }
                    
                    SecaoTermos(titulo: "3. Armazenamento e Segurança") {
                        SubsecaoTermos(titulo: "3.1 Armazenamento Local") {
                            BulletList {
                                "Todos os dados são armazenados exclusivamente no seu dispositivo"
                                "Nenhuma informação é enviada para servidores externos"
                                "Os dados permanecem seguros dentro do ambiente sandbox do iOS"
                            }
                        }
                    }
                    
                    SecaoTermos(titulo: "4. Termos de Uso") {
                        SubsecaoTermos(titulo: "4.1 Licença de Uso") {
                            Text("O Booki concede uma licença pessoal, não transferível e não exclusiva para usar o aplicativo em dispositivos iOS compatíveis.")
                        }
                        
                        SubsecaoTermos(titulo: "4.2 Uso Permitido") {
                            BulletList {
                                "Catalogar e organizar seus livros"
                                "Definir e acompanhar metas de leitura"
                                "Adicionar anotações e avaliações pessoais"
                                "Categorizar sua biblioteca pessoal"
                            }
                        }
                        
                        SubsecaoTermos(titulo: "4.3 Restrições") {
                            BulletList {
                                "Modificar, descompilar ou fazer engenharia reversa do aplicativo"
                                "Usar o aplicativo para fins ilegais"
                            }
                        }
                    }
                    
                    SecaoTermos(titulo: "5. Conteúdo do Usuário") {
                        SubsecaoTermos(titulo: "5.1 Propriedade") {
                            BulletList {
                                "Você mantém todos os direitos sobre o conteúdo que adiciona ao aplicativo"
                                "As imagens e informações que você adiciona são para seu uso pessoal"
                            }
                        }
                        
                        SubsecaoTermos(titulo: "5.2 Responsabilidade") {
                            Text("Você é responsável por: ")
                            BulletList {
                                "A precisão das informações adicionadas"
                                "Garantir que possui os direitos necessários sobre as imagens utilizadas"
                                "Manter a segurança do seu dispositivo e dos dados armazenados"
                            }
                        }
                    }
                    
                    SecaoTermos(titulo: "6. Isenções de Responsabilidade") {
                        SubsecaoTermos(titulo: "6.1 Disponibilidade") {
                            BulletList {
                                "O aplicativo é fornecido \"como está\""
                                "Podemos fazer alterações ou atualizações sem aviso prévio"
                                "Não garantimos disponibilidade ininterrupta do aplicativo"
                            }
                        }
                        
                        SubsecaoTermos(titulo: "6.2 Dados") {
                            BulletList {
                                "Você é responsável por fazer backup dos seus dados"
                                "Não nos responsabilizamos por perda de dados devido a falhas do dispositivo ou do sistema"
                            }
                        }
                    }
                    
                    SecaoTermos(titulo: "7. Alterações nos Termos") {
                        Text("Reservamo-nos o direito de modificar estes termos a qualquer momento. Alterações significativas serão comunicadas através de atualizações do aplicativo.")
                    }
                    
                    SecaoTermos(titulo: "8. Contato") {
                        Text("Para questões relacionadas a esta política ou aos termos de uso, entre em contato através de hada.stella@iCloud.com.")
                    }
                    
                    SecaoTermos(titulo: "9. Encerramento") {
                        Text("Ao usar o Booki, você confirma que leu e concorda com estes termos e política de privacidade. Se não concordar com qualquer parte deste documento, por favor, não use o aplicativo.")
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}

// Componentes auxiliares
struct SecaoTermos<Content: View>: View {
    let titulo: String
    let content: Content
    
    init(titulo: String, @ViewBuilder content: () -> Content) {
        self.titulo = titulo
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(titulo)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            content
        }
    }
}

struct SubsecaoTermos<Content: View>: View {
    let titulo: String
    let content: Content
    
    init(titulo: String, @ViewBuilder content: () -> Content) {
        self.titulo = titulo
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(.primary)
            
            content
        }
    }
}

struct BulletList: View {
    let items: [String]
    
    init(@ArrayBuilder content: () -> [String]) {
        self.items = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(items, id: \.self) { item in
                HStack(alignment: .top, spacing: 8) {
                    Text("•")
                        .foregroundColor(.secondary)
                    Text(item)
                }
            }
        }
    }
}

@resultBuilder
struct ArrayBuilder {
    static func buildBlock(_ components: String...) -> [String] {
        components
    }
}

#Preview {
    Termos()
}
