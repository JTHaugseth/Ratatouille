//
//  SplashScreenView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 03/12/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var startAnimation = false
    @State private var animationCompleted = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Black background

            Image("rat-spoon") // Your rat image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .offset(y: startAnimation ? 0 : UIScreen.main.bounds.height)

            Image("chefs-hat") // Your chef's hat image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 100)
                .offset(x: startAnimation ? -15 : -20, y: startAnimation ? -50 : -UIScreen.main.bounds.height)
                // Adjust the x and y offset values to position the hat correctly
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3)) {
                startAnimation = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                animationCompleted = true
            }
        }
        .fullScreenCover(isPresented: $animationCompleted) {
            MainView() // Transition to MainView
        }
    }
}

#Preview {
    SplashScreenView()
}
