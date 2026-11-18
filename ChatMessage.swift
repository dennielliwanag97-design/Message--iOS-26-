import Foundation

struct ChatMessage: Identifiable, Codable {
    var id: UUID = UUID()
    var senderId: String
    var senderName: String
    var text: String
    var imageURL: String?
    var createdAt: Date = Date()
    var readBy: [String] = []
    var reactions: [String: String] = [:]

    var isFromCurrentUser: Bool {
        senderId == "currentUser"
    }

    var date: Date {
        createdAt
    }

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
