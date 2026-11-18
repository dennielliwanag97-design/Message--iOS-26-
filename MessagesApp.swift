import SwiftUI
import FirebaseCore

@main
struct MessagesApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
