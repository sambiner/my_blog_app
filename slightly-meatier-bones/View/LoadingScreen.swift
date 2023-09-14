//
//  LoadingScreen.swift
//  slightly-meatier-bones
//
//  Created by Howie Li on 4/12/23.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.blue, lineWidth: 5)
                .frame(width: 80, height: 80)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false))
                .onAppear() {
                    isLoading = true
                }
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
