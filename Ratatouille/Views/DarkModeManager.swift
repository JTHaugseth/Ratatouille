import Foundation
import Combine

class DarkModeManager: ObservableObject {
    @Published var isDarkModeEnabled: Bool = false
}
