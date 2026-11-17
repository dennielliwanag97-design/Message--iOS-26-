import SwiftUI

@main
struct MessagesApp: App {
    @StateObject private var store = ChatStore()

    var body: some Scene {
        WindowGroup {
            ChatListView()
                .environmentObject(store)
                .preferredColorScheme(.light)
        }
    }
}
