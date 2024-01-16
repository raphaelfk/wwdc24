import SwiftUI



struct ContentView: View {
    
    
    var body: some View {
        NavigationSplitView {
            SidebarView()

        } detail: {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
        }
    }
}

#Preview {
    ContentView()
}
