import SwiftUI

struct AvatarView: View {
    let initials: String
    let colorName: String

    private var avatarColor: Color {
        switch colorName.lowercased() {
        case "blue":
            return .blue
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "red":
            return .red
        case "orange":
            return .orange
        case "green":
            return .green
        case "gray":
            return .gray
        default:
            return .indigo
        }
    }

    var body: some View {
        Text(initials.uppercased())
            .font(.headline)
            .foregroundStyle(.white)
            .frame(width: 48, height: 48)
            .background(avatarColor, in: Circle())
    }
}
