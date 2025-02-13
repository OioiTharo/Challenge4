//
//  SplashView.swift
//  Challenge4
//
//  Created by THAIS RODRIGUES ANDRADE on 13/02/25.
//

import SwiftUI


struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Color.roxoClarissimo
                .ignoresSafeArea()
            VStack {
                if isActive {
                    BarraNavegacao()
                } else {
                    VStack {
                        Image("iconeSplash")
                            .resizable()
                            .frame(width:204,height:212)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                self.isActive = true
                            }
                            
                        }
                    }
                }
            }
        }
    }
}
