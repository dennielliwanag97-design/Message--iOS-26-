import SwiftUI
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false

    private let auth = Auth.auth()

    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            return
        }

        isLoading = true

        auth.signIn(withEmail: email, password: password) {
            [weak self] result, error in

            self?.isLoading = false

            if let error {
                self?.errorMessage = error.localizedDescription
                return
            }

            self?.isAuthenticated = result?.user != nil
        }
    }

    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please complete all fields."
            return
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            return
        }

        isLoading = true

        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in

            self?.isLoading = false

            if let error {
                self?.errorMessage = error.localizedDescription
                return
            }

            self?.isAuthenticated = result?.user != nil
        }
    }

    func signOut() {
        do {
            try auth.signOut()
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
