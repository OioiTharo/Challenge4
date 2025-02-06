
import SwiftUI

struct BarraProgresso: View {
    @Binding var progresso: Double
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Meta.entity(), sortDescriptors: []) var metas: FetchedResults<Meta>
    
    var metaEntity: Meta {
        metas.first ?? Meta(context: viewContext)
    }
    
    @FetchRequest(
        entity: Livros.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Livros.titulo, ascending: true)
        ],
        predicate: NSPredicate(format: "titulo != nil")
    ) var ultimosLivros: FetchedResults<Livros>
    
    var progressoBarra: Double{
        if progresso > 1{
            return 0.9
        }
        else{
            return 0.4 + (progresso * 0.5)
        }
    } 
    
    var body: some View {
        ZStack{
            VStack {
                if progresso >= 1{
                    Text("🥳")
                        .font(.system(size: 50))
                    Text("Meta Alcançada")
                }else{
                    Text("\(Int((progresso*100).rounded()))%")
                        .font(.system(size: 50))
                    Text("Você já leu \(ultimosLivros.count) de \(metaEntity.numeroMeta) livros!")
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
    BarraProgresso(progresso: .constant(1))
}
