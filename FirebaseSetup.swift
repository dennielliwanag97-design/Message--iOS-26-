import Foundation
import FirebaseCore

enum FirebaseSetup {
    static func configure() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
}
