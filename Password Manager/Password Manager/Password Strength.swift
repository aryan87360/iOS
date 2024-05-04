
import Foundation

import SwiftUI

enum PasswordStrength: Int {
    case weak = 0
    case medium = 1
    case strong = 2

    var color: Color {
        switch self {
        case .weak:
            return .red
        case .medium:
            return .yellow
        case .strong:
            return .green
        }
    }
}

class PasswordChecker {
    func checkStrength(of password: String) -> PasswordStrength {
        switch password.count {
        case 0..<6:
            return .weak
        case 6..<12:
            return .medium
        default:
            return .strong
        }
    }
}
