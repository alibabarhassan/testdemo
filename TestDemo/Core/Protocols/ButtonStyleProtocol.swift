import SwiftUI

// MARK: - AppButtonStyle Protocol
// Protocol for custom button styles
protocol AppButtonStyleProtocol {
    var backgroundColor: Color { get }
    var foregroundColor: Color { get }
    var borderColor: Color { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
}

extension AppButtonStyleProtocol {
    var cornerRadius: CGFloat { 4 }
    var borderWidth: CGFloat { 1 }
}

// MARK: - Primary Button Style
struct PrimaryButtonStyle: AppButtonStyleProtocol {
    var backgroundColor: Color { .orange }
    var foregroundColor: Color { .white }
    var borderColor: Color { .clear }
}

// MARK: - Secondary Button Style
struct SecondaryButtonStyle: AppButtonStyleProtocol {
    var backgroundColor: Color { .clear }
    var foregroundColor: Color { .white }
    var borderColor: Color { .gray }
}

// MARK: - IconButtonStyleProtocol
// Protocol for icon button styles
protocol IconButtonStyleProtocol {
    var iconSize: CGFloat { get }
    var circleSize: CGFloat { get }
    var selectedColor: Color { get }
    var unselectedColor: Color { get }
}

extension IconButtonStyleProtocol {
    var iconSize: CGFloat { 20 }
    var circleSize: CGFloat { 50 }
    var selectedColor: Color { .orange }
    var unselectedColor: Color { Color.gray.opacity(0.3) }
}

// MARK: - Default Icon Button Style
struct DefaultIconButtonStyle: IconButtonStyleProtocol {}
