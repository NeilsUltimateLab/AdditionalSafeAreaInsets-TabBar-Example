import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBarVC(nibName: nil, bundle: nil)
            .toSwiftUI
            .edgesIgnoringSafeArea(.all)
    }
}
