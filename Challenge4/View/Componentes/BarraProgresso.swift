
import SwiftUI

struct BarraProgresso: View {
    @Binding var progresso: Double
    
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
                    Text("Alcançado")
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
