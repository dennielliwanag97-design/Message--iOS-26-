import SwiftUI
import FirebaseAuth

struct RootView: View {
    @State private var user: FirebaseAuth.User?
    @State private var isCheckingAuth = true
    @State private var authListener: AuthStateDidChangeListenerHandle?

    @StateObject private var store = ChatStore()

    var body: some View {
        Group {
            if isCheckingAuth {
                ProgressView("Loading Messenger...")
            } else if user != nil {
                ChatListView()
                    .environmentObject(store)
            } else {
                LoginView()
            }
        }
        .onAppear {
            authListener = Auth.auth().addStateDidChangeListener {
                _, currentUser in
                user = currentUser
                isCheckingAuth = false
            }
        }
        .onDisappear {
            if let authListener {
                Auth.auth().removeStateDidChangeListener(authListener)
            }
        }
    }
}
