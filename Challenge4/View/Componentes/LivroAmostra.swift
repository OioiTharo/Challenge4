//
//  LivroAmostra.swift
//  Challenge4
//
//  Created by THAIS RODRIGUES ANDRADE on 29/01/25.
//

import SwiftUI

struct LivroAmostra: View {
    var body: some View {
        VStack{
            Rectangle()
            .frame(width: 300, height: 440)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 5)
            .foregroundColor(Color.gray)
            Avaliado()
                .frame(width: 300)
        }
    }
}

#Preview {
    LivroAmostra()
}
