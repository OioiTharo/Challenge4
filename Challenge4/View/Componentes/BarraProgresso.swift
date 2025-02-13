import SwiftData
import SwiftUI

struct BarraProgresso: View {
    @Binding var progresso: Double
    @Query private var metas: [Metas]
    @Query private var livros: [Livros]
    
    let metaProgressModel = MetaProgressModel()
    
    var metaEntity: Metas {
        metaProgressModel.getMeta(metas)
    }
    
    var progressoBarra: Double {
        return metaProgressModel.calcularProgressoBarra(progresso: progresso)
    }
    
    var body: some View {
        ZStack{
            VStack {
                if livros.count == 0 {
                    Text("😕")
                        .font(.system(size: 50))
                    Text("Nenhuma leitura adicionada!")
                } else{
                    if progresso >= 1{
                        Text("🥳")
                            .font(.system(size: 50))
                        Text("Meta Alcançada")
                    }else{
                        if progresso == 0 {
                            Text("😔")
                                .font(.system(size: 50))
                            Text("Nenhuma meta adicionada!")
                        } else {
                            Text("\(Int((progresso*100).rounded()))%")
                                .font(.system(size: 50))
                            Text("Você já leu \(livros.count) de \(metaEntity.numeroMeta) livros!")
                        }
                    }
                }
            }
            .padding()
            .overlay(
                Circle()
                    .trim(from: 0.4, to: 0.9)
                    .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, dash: [10]))
                    .fill(.rosa)
                    .rotationEffect(.degrees(36.5))
                    .padding(-20)
            )
            
            Circle()
                .trim(from: 0.4, to: 0.9)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .fill(.roxoClarissimo)
                .rotationEffect(.degrees(36))
            
            Circle()
                .trim(from: 0.4, to: CGFloat(progressoBarra))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.roxoEscuro, .rosa]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .rotationEffect(.degrees(36))
            
            
        }.padding(.horizontal,50)
        
    }
}

#Preview {
    BarraProgresso(progresso: .constant(0.6))
}
