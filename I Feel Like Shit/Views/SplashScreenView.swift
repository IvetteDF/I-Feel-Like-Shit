//
//  SplashScreenView.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/21/22.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive: Bool = false
    @State private var size: Double = 0.8
    @State private var opacity: Double = 0.5
    
    var body: some View {
        if isActive {
            ContentView(coreDM: CoreDataManager())
        } else {
            VStack {
                Image("I Feel Like Shit")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
            }   .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
