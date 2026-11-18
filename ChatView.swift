iimport SwiftUI
import UIKit

struct ChatView: View {
    @EnvironmentObject private var store: ChatStore

    let chatID: UUID

    @State private var draft = ""

    private var chat: Chat? {
        store.chats.first { $0.id == chatID }
    }

    var body: some View {
        VStack(spacing: 0) {
            if let chat {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            Text("iMessage")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.top, 18)

                            ForEach(chat.messages) { message in
                                MessageBubble(
                                    message: message,
                                    onReply: {
                                        draft = "↩︎ \(message.text)\n"
                                    }
                                )
                                .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: chat.messages.count) { _, _ in
                        if let last = chat.messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }

                HStack(alignment: .bottom, spacing: 10) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    TextField("iMessage", text: $draft, axis: .vertical)
                        .lineLimit(1...4)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(
                            Color(.secondarySystemBackground),
                            in: Capsule()
                        )

                    Button {
                        store.send(draft, to: chatID)
                        draft = ""
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title)
                            .foregroundStyle(
                                draft.isEmpty ? .gray : .blue
                            )
                    }
                    .disabled(
                        draft.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.bar)

            } else {
                ContentUnavailableView(
                    "Conversation not found",
                    systemImage: "message"
                )
            }
        }
        .navigationTitle(chat?.name ?? "Chat")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct MessageBubble: View {
    let message: ChatMessage
    let onReply: () -> Void

    @State private var reaction: String?

    private let reactions = [
        "❤️", "👍", "😂", "😮", "😢", "😡"
    ]

    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer(minLength: 55)
            }

            VStack(alignment: message.isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .foregroundStyle(
                        message.isFromCurrentUser ? .white : .primary
                    )
                    .background(
                        message.isFromCurrentUser
                            ? Color.blue
                            : Color(.systemGray5),
                        in: RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                    )
                    .contextMenu {
                        Section("Reactions") {
                            ForEach(reactions, id: \.self) { emoji in
                                Button(emoji) {
                                    reaction = emoji
                                }
                            }
                        }

                        Button {
                            UIPasteboard.general.string = message.text
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }

                        Button {
                            onReply()
                        } label: {
                            Label("Reply", systemImage: "arrowshape.turn.up.left")
                        }

                        Button {
                            reaction = nil
                        } label: {
                            Label("Remove Reaction", systemImage: "xmark")
                        }
                    }

                HStack(spacing: 5) {
                    Text(message.date, style: .time)
                        .font(.caption2)
                        .foregroundStyle(.secondary)

                    if let reaction {
                        Text(reaction)
                            .font(.caption)
                            .padding(4)
                            .background(
                                Color(.secondarySystemBackground),
                                in: Capsule()
                            )
                    }
                }
            }

            if !message.isFromCurrentUser {
                Spacer(minLength: 55)
            }
        }
    }
}import SwiftUI
import UIKit

struct ChatView: View {
    @EnvironmentObject private var store: ChatStore

    let chatID: UUID

    @State private var draft = ""

    private var chat: Chat? {
        store.chats.first { $0.id == chatID }
    }

    var body: some View {
        VStack(spacing: 0) {
            if let chat {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            Text("iMessage")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.top, 18)

                            ForEach(chat.messages) { message in
                                MessageBubble(
                                    message: message,
                                    onReply: {
                                        draft = "↩︎ \(message.text)\n"
                                    }
                                )
                                .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: chat.messages.count) { _, _ in
                        if let last = chat.messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }

                HStack(alignment: .bottom, spacing: 10) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    TextField("iMessage", text: $draft, axis: .vertical)
                        .lineLimit(1...4)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(
                            Color(.secondarySystemBackground),
                            in: Capsule()
                        )

                    Button {
                        store.send(draft, to: chatID)
                        draft = ""
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title)
                            .foregroundStyle(
                                draft.isEmpty ? .gray : .blue
                            )
                    }
                    .disabled(
                        draft.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.bar)

            } else {
                ContentUnavailableView(
                    "Conversation not found",
                    systemImage: "message"
                )
            }
        }
        .navigationTitle(chat?.name ?? "Chat")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct MessageBubble: View {
    let message: ChatMessage
    let onReply: () -> Void

    @State private var reaction: String?

    private let reactions = [
        "❤️", "👍", "😂", "😮", "😢", "😡"
    ]

    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer(minLength: 55)
            }

            VStack(alignment: message.isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .foregroundStyle(
                        message.isFromCurrentUser ? .white : .primary
                    )
                    .background(
                        message.isFromCurrentUser
                            ? Color.blue
                            : Color(.systemGray5),
                        in: RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                    )
                    .contextMenu {
                        Section("Reactions") {
                            ForEach(reactions, id: \.self) { emoji in
                                Button(emoji) {
                                    reaction = emoji
                                }
                            }
                        }

                        Button {
                            UIPasteboard.general.string = message.text
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }

                        Button {
                            onReply()
                        } label: {
                            Label("Reply", systemImage: "arrowshape.turn.up.left")
                        }

                        Button {
                            reaction = nil
                        } label: {
                            Label("Remove Reaction", systemImage: "xmark")
                        }
                    }

                HStack(spacing: 5) {
                    Text(message.date, style: .time)
                        .font(.caption2)
                        .foregroundStyle(.secondary)

                    if let reaction {
                        Text(reaction)
                            .font(.caption)
                            .padding(4)
                            .background(
                                Color(.secondarySystemBackground),
                                in: Capsule()
                            )
                    }
                }
            }

            if !message.isFromCurrentUser {
                Spacer(minLength: 55)
            }
        }
    }
}mport SwiftUI

struct ChatView: View {
    @EnvironmentObject private var store: ChatStore
    let chatID: UUID
    @State private var draft = ""

    private var chat: Chat? { store.chats.first { $0.id == chatID } }

    var body: some View {
        VStack(spacing: 0) {
            if let chat {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            Text("iMessage")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.top, 18)

                            ForEach(chat.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding()
                    }
import SwiftUI
import UIKit

struct ChatView: View {
    @EnvironmentObject private var store: ChatStore

    let chatID: UUID

    @State private var draft = ""

    private var chat: Chat? {
        store.chats.first { $0.id == chatID }
    }

    var body: some View {
        VStack(spacing: 0) {
            if let chat {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            Text("iMessage")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.top, 18)

                            ForEach(chat.messages) { message in
                                MessageBubble(
                                    message: message,
                                    onReply: {
                                        draft = "↩︎ \(message.text)\n"
                                    }
                                )
                                .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: chat.messages.count) { _, _ in
                        if let last = chat.messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }

                HStack(alignment: .bottom, spacing: 10) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    TextField("iMessage", text: $draft, axis: .vertical)
                        .lineLimit(1...4)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(
                            Color(.secondarySystemBackground),
                            in: Capsule()
                        )

                    Button {
                        store.send(draft, to: chatID)
                        draft = ""
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title)
                            .foregroundStyle(
                                draft.isEmpty ? .gray : .blue
                            )
                    }
                    .disabled(
                        draft.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.bar)

            } else {
                ContentUnavailableView(
                    "Conversation not found",
                    systemImage: "message"
                )
            }
        }
        .navigationTitle(chat?.name ?? "Chat")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct MessageBubble: View {
    let message: ChatMessage
    let onReply: () -> Void

    @State private var reaction: String?

    private let reactions = [
        "❤️", "👍", "😂", "😮", "😢", "😡"
    ]

    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer(minLength: 55)
            }

            VStack(alignment: message.isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .foregroundStyle(
                        message.isFromCurrentUser ? .white : .primary
                    )
                    .background(
                        message.isFromCurrentUser
                            ? Color.blue
                            : Color(.systemGray5),
                        in: RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                    )
                    .contextMenu {
                        Section("Reactions") {
                            ForEach(reactions, id: \.self) { emoji in
                                Button(emoji) {
                                    reaction = emoji
                                }
                            }
                        }

                        Button {
                            UIPasteboard.general.string = message.text
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }

                        Button {
                            onReply()
                        } label: {
                            Label("Reply", systemImage: "arrowshape.turn.up.left")
                        }

                        Button {
                            reaction = nil
                        } label: {
                            Label("Remove Reaction", systemImage: "xmark")
                        }
                    }

                HStack(spacing: 5) {
                    Text(message.date, style: .time)
                        .font(.caption2)
                        .foregroundStyle(.secondary)

                    if let reaction {
                        Text(reaction)
                            .font(.caption)
                            .padding(4)
                            .background(
                                Color(.secondarySystemBackground),
                                in: Capsule()
                            )
                    }
                }
            }

            if !message.isFromCurrentUser {
                Spacer(minLength: 55)
            }
        }
    }
}                    .onChange(of: chat.messages.count) { _, _ in
                        if let last = chat.messages.last {
                            withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                        }
                    }
                }

                HStack(alignment: .bottom, spacing: 10) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    TextField("iMessage", text: $draft, axis: .vertical)
                        .lineLimit(1...4)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Color(.secondarySystemBackground), in: Capsule())
                    Button {
                        store.send(draft, to: chatID)
                        draft = ""
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title)
                            .foregroundStyle(draft.isEmpty ? .gray : .blue)
                    }
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.bar)
            } else {
                ContentUnavailableView("Conversation not found", systemImage: "message")
            }
        }
        .navigationTitle(chat?.name ?? "Chat")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isFromCurrentUser { Spacer(minLength: 55) }
            VStack(alignment: .trailing, spacing: 4) {
                Text(message.text)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .foregroundStyle(message.isFromCurrentUser ? .white : .primary)
                    .background(
                        message.isFromCurrentUser ? Color.blue : Color(.systemGray5),
                        in: RoundedRectangle(cornerRadius: 20, style: .continuous)
                    )
                Text(message.date, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            if !message.isFromCurrentUser { Spacer(minLength: 55) }
        }
    }
}import SwiftUI

struct ChatView: View {
    @EnvironmentObject private var store: ChatStore
    let chatID: UUID
    @State private var draft = ""

    private var chat: Chat? { store.chats.first { $0.id == chatID } }

    var body: some View {
        VStack(spacing: 0) {
            if let chat {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            Text("iMessage")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.top, 18)

                            ForEach(chat.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: chat.messages.count) { _, _ in
                        if let last = chat.messages.last {
                            withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                        }
                    }
                }

                HStack(alignment: .bottom, spacing: 10) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    TextField("iMessage", text: $draft, axis: .vertical)
                        .lineLimit(1...4)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Color(.secondarySystemBackground), in: Capsule())
                    Button {
                        store.send(draft, to: chatID)
                        draft = ""
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title)
                            .foregroundStyle(draft.isEmpty ? .gray : .blue)
                    }
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.bar)
            } else {
                ContentUnavailableView("Conversation not found", systemImage: "message")
            }
        }
        .navigationTitle(chat?.name ?? "Chat")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isFromCurrentUser { Spacer(minLength: 55) }
            VStack(alignment: .trailing, spacing: 4) {
                Text(message.text)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .foregroundStyle(message.isFromCurrentUser ? .white : .primary)
                    .background(
                        message.isFromCurrentUser ? Color.blue : Color(.systemGray5),
                        in: RoundedRectangle(cornerRadius: 20, style: .continuous)
                    )
                Text(message.date, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            if !message.isFromCurrentUser { Spacer(minLength: 55) }
        }
    }
}
