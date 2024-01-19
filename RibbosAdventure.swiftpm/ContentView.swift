import SwiftUI



struct ContentView: View {
    @State var finishedOnboarding = false
    
    var body: some View {
        NavigationView {
            if finishedOnboarding {
                DashboardView()
            } else {
                OnboardingView(finishedOnboarding: $finishedOnboarding)
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

#Preview {
    ContentView()
}
