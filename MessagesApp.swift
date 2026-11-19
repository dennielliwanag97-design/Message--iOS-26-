import SwiftUI

@main
struct MessagesApp: App {

    init() {
        FirebaseSetup.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
