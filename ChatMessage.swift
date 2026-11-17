import Foundation

struct ChatMessage: Identifiable, Hashable {
    let id: UUID
    let text: String
    let date: Date
    let isFromCurrentUser: Bool
    var reaction: String?

    init(id: UUID = UUID(), text: String, date: Date = .now,
         isFromCurrentUser: Bool, reaction: String? = nil) {
        self.id = id
        self.text = text
        self.date = date
        self.isFromCurrentUser = isFromCurrentUser
        self.reaction = reaction
    }
}

struct Chat: Identifiable, Hashable {
    let id: UUID
    var name: String
    var initials: String
    var colorName: String
    var messages: [ChatMessage]

    var lastMessage: String { messages.last?.text ?? "No messages yet" }
    var lastMessageDate: Date { messages.last?.date ?? .now }

    init(id: UUID = UUID(), name: String, initials: String,
         colorName: String = "blue", messages: [ChatMessage] = []) {
        self.id = id
        self.name = name
        self.initials = initials
        self.colorName = colorName
        self.messages = messages
    }
}
