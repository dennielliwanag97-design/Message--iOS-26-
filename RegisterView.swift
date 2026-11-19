import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle.badge.plus")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text("Create Account")
                .font(.largeTitle.bold())

            TextField("Email address", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(.gray.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            SecureField("Password (at least 6 characters)", text: $viewModel.password)
                .padding()
                .background(.gray.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .font(.caption)
            }

            Button {
                viewModel.signUp()
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Create Account")
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .disabled(viewModel.isLoading)

            Spacer()
        }
        .padding()
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}
