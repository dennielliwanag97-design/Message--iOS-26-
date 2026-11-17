import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
final class ChatListViewModel: ObservableObject {

    @Published var chats: [ChatMessage] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    func listenToMessages(userId: String) {
        listener?.remove()
        isLoading = true
        errorMessage = nil

        listener = db.collection("messages")
            .whereField("participants", arrayContains: userId)
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in

                guard let self else { return }

                if let error {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let documents = snapshot?.documents else {
                    self.chats = []
                    self.isLoading = false
                    return
                }

                self.chats = documents.compactMap {
                    try? $0.data(as: ChatMessage.self)
                }

                self.isLoading = false
            }
    }

    func stopListening() {
        listener?.remove()
        listener = nil
    }

    deinit {
        listener?.remove()
    }
}
