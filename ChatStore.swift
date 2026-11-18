import Foundation
import SwiftUI

@MainActor
final class ChatStore: ObservableObject {
    @Published var chats: [Chat] = []

    func send(_ text: String, to chatID: UUID) {
        guard let index = chats.firstIndex(where: { $0.id == chatID }) else {
            return
        }

        let trimmedText = text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedText.isEmpty else { return }

        let message = ChatMessage(
            senderId: "currentUser",
            senderName: "You",
            text: trimmedText
        )

        chats[index].messages.append(message)
        chats[index].lastMessage = trimmedText
        chats[index].lastMessageDate = Date()
    }

    func addReaction(
        _ reaction: String,
        to messageID: UUID,
        in chatID: UUID
    ) {
        guard let chatIndex = chats.firstIndex(where: {
            $0.id == chatID
        }) else {
            return
        }

        guard let messageIndex = chats[chatIndex].messages.firstIndex(where: {
            $0.id == messageID
        }) else {
            return
        }

        chats[chatIndex].messages[messageIndex].reactions["currentUser"] =
            reaction
    }

    func removeReaction(
        from messageID: UUID,
        in chatID: UUID
    ) {
        guard let chatIndex = chats.firstIndex(where: {
            $0.id == chatID
        }) else {
            return
        }

        guard let messageIndex = chats[chatIndex].messages.firstIndex(where: {
            $0.id == messageID
        }) else {
            return
        }

        chats[chatIndex].messages[messageIndex].reactions.removeValue(
            forKey: "currentUser"
        )
    }

    func deleteMessage(
        _ messageID: UUID,
        from chatID: UUID
    ) {
        guard let chatIndex = chats.firstIndex(where: {
            $0.id == chatID
        }) else {
            return
        }

        chats[chatIndex].messages.removeAll {
            $0.id == messageID
        }
    }
}
