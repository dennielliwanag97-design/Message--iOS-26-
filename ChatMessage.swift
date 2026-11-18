import Foundation

struct ChatMessage: Id    var id: UUID = UUID(
    var text: String
    var imageURL: String?
    var createdAt: Date = Date()
    var readBy: [String] = []
    var reactions: [String: String] = [:]

    init(
        id: UUID = UUID(),
        senderId: String,
        senderName: String,
        text: String,
        imageURL: String? = nil,
        createdAt: Date = Date(),
        readBy: [String] = [],
        reactions: [String: String] = [:]
    ) {
        self.id = id
        self.senderId = senderId
        self.senderName = senderName
        self.text = text
        self.imageURL = imageURL
        self.createdAt = createdAt
        self.readBy = readBy
        self.reactions = reactions
    }
}
