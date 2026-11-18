import SwiftUI

struct ChatListView: View {
    @EnvironmentObject private var store: ChatStore

    @State private var searchText = ""
    @State private var showingNewChat = false
    @State private var showingProfile = false

    private var filteredChats: [Chat] {
        guard !searchText.isEmpty else {
            return store.chats
        }

        return store.chats.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredChats) { chat in
                    NavigationLink {
                        ChatView(chatID: chat.id)
                    } label: {
                        HStack(spacing: 13) {
                            AvatarView(
                                initials: chat.initials,
                                colorName: chat.colorName
                            )

                            VStack(alignment: .leading, spacing: 5) {
                                Text(chat.name)
                                    .font(.headline)

                                Text(chat.lastMessage)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }

                            Spacer()

                            Text(chat.lastMessageDate, style: .time)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "Search")
            .navigationTitle("Messages")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showingProfile = true
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                    .accessibilityLabel("Profile")

                    Button {
                        showingNewChat = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.title3.weight(.semibold))
                    }
                    .accessibilityLabel("New message")
                }
            }
            .sheet(isPresented: $showingNewChat) {
                NewChatView()
            }
            .sheet(isPresented: $showingProfile) {
                ProfileView()
            }
        }
        .tint(.blue)
    }
}

struct AvatarView: View {
    let initials: String
    let colorName: String

    var body: some View {
        Text(initials)
            .font(.headline.weight(.semibold))
            .foregroundStyle(.white)
            .frame(width: 52, height: 52)
            .background(color, in: Circle())
    }

    private var color: Color {
        switch colorName {
        case "purple":
            .purple
        case "orange":
            .orange
        case "pink":
            .pink
        case "green":
            .green
        default:
            .blue
        }
    }
}
