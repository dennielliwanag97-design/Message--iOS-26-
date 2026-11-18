import Foundation

struct Chat: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var initials: String
    var colorName: String
    var lastMessage: String
    var lastMessageDate: Date
    var messages: [ChatMessage] = []

    init(
        id: UUID = UUID(),
        name: String,
        initials: String,
        colorName: String,
        lastMessage: String = "",
        lastMessageDate: Date = Date(),
        messages: [ChatMessage] = []
    ) {
        self.id = id
        self.name = name
        self.initials = initials
        self.colorName = colorName
        self.lastMessage = lastMessage
        self.lastMessageDate = lastMessageDate
        self.messages = messages
    }
}
