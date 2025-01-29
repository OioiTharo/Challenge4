import SwiftUI

struct Avaliado: View {
    @State var avaliacao: Int = 2
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Título muito grande")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                Text("Autor")
                Spacer()
            }
            Spacer()
            VStack{
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.purple)
                        .font(.caption)
                    Text("\(avaliacao).0")
                        .foregroundColor(Color.purple)
                }.overlay(
                    Capsule()
                        .fill(Color.purple.opacity(0.2))
                        .frame(width: 65, height: 25)
                        .padding(10)
                ).padding(.top, 10)
                Spacer()
            }
        }.padding()
    }
}
#Preview {
    Avaliado()
}
