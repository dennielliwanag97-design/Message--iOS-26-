import Foundation
import SwiftUI

@MainActor
final class ChatStore: ObservableObject {
    @Published var chats: [Chat] = [
        Chat(name: "Ate Khym", initials: "AK", colorName: "purple",
             messages: [ChatMessage(text: "Hi! How are you? 😊", isFromCurrentUser: false),
                        ChatMessage(text: "I'm good! How about you?", isFromCurrentUser: true)]),
        Chat(name: "Family Group", initials: "FG", colorName: "orange",
             messages: [ChatMessage(text: "See you later!", isFromCurrentUser: false)]),
        Chat(name: "Best Friend", initials: "BF", colorName: "pink",
             messages: [ChatMessage(text: "Good morning 💙", isFromCurrentUser: false)])
    ]

    func send(_ text: String, to chatID: UUID) {
        guard let index = chats.firstIndex(where: { $0.id == chatID }) else { return }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        chats[index].messages.append(
            ChatMessage(text: trimmed, isFromCurrentUser: true)
        )
    }

    func addChat(name: String) {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanName.isEmpty else { return }
        let initials = cleanName.split(separator: " ").prefix(2)
            .compactMap(\.first).map(String.init).joined()
        chats.insert(Chat(name: cleanName, initials: initials.isEmpty ? "?" : initials), at: 0)
    }
}
