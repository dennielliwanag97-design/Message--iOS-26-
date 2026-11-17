import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                Image(systemName: "message.fill")
                    .font(.system(size: 65))
                    .foregroundColor(.blue)

                Text("Messenger")
                    .font(.largeTitle.bold())

                TextField("Email address", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button {
                    viewModel.signIn()
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Log In")
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(viewModel.isLoading)

                NavigationLink("Create New Account") {
                    RegisterView()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
