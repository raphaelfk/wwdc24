import SwiftUI



struct ContentView: View {
    @State var finishedOnboarding = false
    @ObservedObject var gameManager = GameManager()
    
    var body: some View {
        VStack {
            if finishedOnboarding {
                if gameManager.playingFirstLevel {
                    FirstLevelView()
                } else if gameManager.playingSecondLevel {
                    SecondLevelView()
                } else if gameManager.playingThirdLevel {
                    
                } else {
                    DashboardView()
                }
                
            } else {
                OnboardingView(finishedOnboarding: $finishedOnboarding)
            }
        }
        .environmentObject(gameManager)
        
    }
}

#Preview {
    ContentView()
}
