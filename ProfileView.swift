import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var displayName = ""
    @State private var email = Auth.auth().currentUser?.email ?? ""
    @State private var showLogoutAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)

                Text(displayName.isEmpty ? "My Profile" : displayName)
                    .font(.title.bold())

                VStack(alignment: .leading, spacing: 16) {
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    TextField("Enter your name", text: $displayName)
                        .textFieldStyle(.roundedBorder)

                    Text("Email")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(email)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)

                Button("Save Profile") { }
                    .buttonStyle(.borderedProminent)

                Button(role: .destructive) {
                    showLogoutAlert = true
                } label: {
                    Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
                }

                Spacer()
            }
            .padding(.top, 30)
            .navigationTitle("Profile")
            .alert("Log Out?", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Log Out", role: .destructive) {
                    try? Auth.auth().signOut()
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
        }
    }
}
