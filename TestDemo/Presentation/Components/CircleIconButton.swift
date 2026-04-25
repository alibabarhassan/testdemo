import SwiftUI

// MARK: - CircleIconButtonConfigurable Protocol
protocol CircleIconButtonConfigurable {
    var icon: String { get }
    var label: String { get }
    var isSelected: Bool { get }
}

// MARK: - CircleIconButton View
struct CircleIconButton<Style: IconButtonStyleProtocol>: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let style: Style
    let action: () -> Void
    
    init(
        icon: String,
        label: String,
        isSelected: Bool = false,
        style: Style,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.label = label
        self.isSelected = isSelected
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                circleContent
                
                Text(label)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
    
    @ViewBuilder
    private var circleContent: some View {
        if #available(iOS 26.0, *) {
            // iOS 26+ Liquid Glass
            Image(systemName: icon)
                .font(.system(size: style.iconSize))
                .foregroundColor(.white)
                .frame(width: style.circleSize, height: style.circleSize)
                .glassEffect(
                    isSelected ? .regular.tint(style.selectedColor).interactive() : .regular.interactive(),
                    in: .circle
                )
        } else {
            // Fallback for earlier versions
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: style.circleSize, height: style.circleSize)
                
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(isSelected ? 0.3 : 0.15),
                                Color.white.opacity(0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: style.circleSize, height: style.circleSize)
                
                if isSelected {
                    Circle()
                        .fill(style.selectedColor.opacity(0.5))
                        .frame(width: style.circleSize, height: style.circleSize)
                }
                
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(isSelected ? 0.5 : 0.3),
                                Color.white.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                    .frame(width: style.circleSize, height: style.circleSize)
                
                Image(systemName: icon)
                    .font(.system(size: style.iconSize))
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - Convenience Extension for Default Style
extension CircleIconButton where Style == DefaultIconButtonStyle {
    init(
        icon: String,
        label: String,
        isSelected: Bool = false,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.label = label
        self.isSelected = isSelected
        self.style = DefaultIconButtonStyle()
        self.action = action
    }
}

#Preview {
    HStack(spacing: 24) {
        CircleIconButton(icon: "plus", label: "Watchlist", action: {})
        CircleIconButton(icon: "hand.thumbsup", label: "I like it", isSelected: true, action: {})
        CircleIconButton(icon: "hand.thumbsdown", label: "I don't like it", action: {})
    }
    .padding()
    .background(Color.black)
}
