import SwiftUI

struct SplashScreenView: View {
    @State private var startAnimation = false
    @State private var animationCompleted = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image("rat-spoon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .offset(y: startAnimation ? 0 : UIScreen.main.bounds.height)
            
            Image("chefs-hat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 100)
                .offset(x: startAnimation ? -15 : -20, y: startAnimation ? -50 : -UIScreen.main.bounds.height)
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
            MainView()
        }
    }
}

#Preview {
    SplashScreenView()
}
