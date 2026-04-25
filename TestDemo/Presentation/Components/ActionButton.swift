import SwiftUI

// MARK: - ActionButtonConfigurable Protocol
protocol ActionButtonConfigurable {
    var buttonTitle: String { get }
    var buttonIcon: String { get }
    var buttonStyle: any AppButtonStyleProtocol { get }
}

// MARK: - ActionButton View
struct ActionButton<Style: AppButtonStyleProtocol>: View {
    private let title: String
    private let icon: String
    private let style: Style
    private let action: () -> Void
    
    init(
        title: String,
        icon: String,
        style: Style,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .foregroundColor(style.foregroundColor)
        }
        .buttonStyle(GlassButtonStyle(isProminent: style.backgroundColor != .clear))
    }
}

// MARK: - PrimaryActionButton (Convenience wrapper)
struct PrimaryActionButton: View {
    private let title: String
    private let icon: String
    private let action: () -> Void
    
    init(title: String, icon: String, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        ActionButton(title: title, icon: icon, style: PrimaryButtonStyle(), action: action)
    }
}

// MARK: - SecondaryActionButton (Convenience wrapper)
struct SecondaryActionButton: View {
    private let title: String
    private let icon: String
    private let action: () -> Void
    
    init(title: String, icon: String, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        ActionButton(title: title, icon: icon, style: SecondaryButtonStyle(), action: action)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryActionButton(title: "Play", icon: "play.fill") {}
        SecondaryActionButton(title: "Trailer", icon: "play.rectangle") {}
    }
    .padding()
    .background(Color.black)
}
