import SwiftUI
import FirebaseAuth

struct RootView: View {

    @State private var user: FirebaseAuth.User?
    @State private var isCheckingAuth = true
    @State private var authListener: AuthStateDidChangeListenerHandle?

    var body: some View {
        Group {
            if isCheckingAuth {
                ProgressView("Loading...")
            } else if user != nil {
                ChatListView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            authListener = Auth.auth().addStateDidChangeListener {
                _, currentUser in

                self.user = currentUser
                self.isCheckingAuth = false
            }
        }
        .onDisappear {
            if let authListener {
                Auth.auth().removeStateDidChangeListener(authListener)
            }
        }
    }
}
