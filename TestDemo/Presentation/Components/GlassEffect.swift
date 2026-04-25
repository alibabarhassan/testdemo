import SwiftUI

// MARK: - iOS 26+ Liquid Glass View Modifier
@available(iOS 26.0, *)
struct LiquidGlassModifier: ViewModifier {
    let cornerRadius: CGFloat
    let tintColor: Color?
    let isInteractive: Bool
    
    func body(content: Content) -> some View {
        if let tint = tintColor {
            content
                .glassEffect(
                    .regular.tint(tint).interactive(isInteractive),
                    in: .rect(cornerRadius: cornerRadius)
                )
        } else {
            content
                .glassEffect(
                    .regular.interactive(isInteractive),
                    in: .rect(cornerRadius: cornerRadius)
                )
        }
    }
}

// MARK: - Legacy Glass Effect Modifier (iOS 15+)
struct LegacyGlassModifier: ViewModifier {
    let cornerRadius: CGFloat
    let tintColor: Color?
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                    
                    if let tint = tintColor {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(tint.opacity(0.3))
                    }
                    
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(opacity),
                                    Color.white.opacity(opacity * 0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.3),
                                    Color.white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
    }
}

// MARK: - Capsule Glass Modifier for iOS 26+
@available(iOS 26.0, *)
struct LiquidGlassCapsuleModifier: ViewModifier {
    let tintColor: Color?
    let isInteractive: Bool
    
    func body(content: Content) -> some View {
        if let tint = tintColor {
            content
                .glassEffect(.regular.tint(tint).interactive(isInteractive))
        } else {
            content
                .glassEffect(.regular.interactive(isInteractive))
        }
    }
}

// MARK: - Legacy Capsule Glass Modifier
struct LegacyCapsuleGlassModifier: ViewModifier {
    let tintColor: Color?
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    Capsule()
                        .fill(.ultraThinMaterial)
                    
                    if let tint = tintColor {
                        Capsule()
                            .fill(tint.opacity(0.3))
                    }
                    
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(opacity),
                                    Color.white.opacity(opacity * 0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Capsule()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.4),
                                    Color.white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
    }
}

// MARK: - Circle Glass Modifier for iOS 26+
@available(iOS 26.0, *)
struct LiquidGlassCircleModifier: ViewModifier {
    let tintColor: Color?
    let isInteractive: Bool
    
    func body(content: Content) -> some View {
        if let tint = tintColor {
            content
                .glassEffect(.regular.tint(tint).interactive(isInteractive), in: .circle)
        } else {
            content
                .glassEffect(.regular.interactive(isInteractive), in: .circle)
        }
    }
}

// MARK: - Legacy Circle Glass Modifier
struct LegacyCircleGlassModifier: ViewModifier {
    let tintColor: Color?
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                    
                    if let tint = tintColor {
                        Circle()
                            .fill(tint.opacity(0.3))
                    }
                    
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(opacity),
                                    Color.white.opacity(opacity * 0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.4),
                                    Color.white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
    }
}

// MARK: - Glass Card Modifier
struct GlassCardModifier: ViewModifier {
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius))
        } else {
            content
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(.ultraThinMaterial)
                        
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.1),
                                        Color.clear
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                    }
                )
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        }
    }
}

// MARK: - View Extension
extension View {
    /// Applies glass background with iOS 26 Liquid Glass or fallback
    @ViewBuilder
    func glassBackground(
        cornerRadius: CGFloat = 20,
        tint: Color? = nil,
        interactive: Bool = false
    ) -> some View {
        if #available(iOS 26.0, *) {
            modifier(LiquidGlassModifier(
                cornerRadius: cornerRadius,
                tintColor: tint,
                isInteractive: interactive
            ))
        } else {
            modifier(LegacyGlassModifier(
                cornerRadius: cornerRadius,
                tintColor: tint,
                opacity: 0.15
            ))
        }
    }
    
    /// Applies capsule glass effect with iOS 26 Liquid Glass or fallback
    @ViewBuilder
    func glassCapsule(tint: Color? = nil, interactive: Bool = false) -> some View {
        if #available(iOS 26.0, *) {
            modifier(LiquidGlassCapsuleModifier(
                tintColor: tint,
                isInteractive: interactive
            ))
        } else {
            modifier(LegacyCapsuleGlassModifier(
                tintColor: tint,
                opacity: 0.15
            ))
        }
    }
    
    /// Applies circle glass effect with iOS 26 Liquid Glass or fallback
    @ViewBuilder
    func glassCircle(tint: Color? = nil, interactive: Bool = false) -> some View {
        if #available(iOS 26.0, *) {
            modifier(LiquidGlassCircleModifier(
                tintColor: tint,
                isInteractive: interactive
            ))
        } else {
            modifier(LegacyCircleGlassModifier(
                tintColor: tint,
                opacity: 0.15
            ))
        }
    }
    
    /// Applies glass card effect
    func glassCard(cornerRadius: CGFloat = 16) -> some View {
        modifier(GlassCardModifier(cornerRadius: cornerRadius))
    }
}

// MARK: - Glass Button Style with iOS 26 support
struct GlassButtonStyle: ButtonStyle {
    let isProminent: Bool
    
    init(isProminent: Bool = false) {
        self.isProminent = isProminent
    }
    
    func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 26.0, *) {
            configuration.label
                .glassEffect(
                    isProminent ? .regular.tint(.white.opacity(0.2)).interactive() : .regular.interactive(),
                    in: .rect(cornerRadius: 12)
                )
                .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
                .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
        } else {
            configuration.label
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.ultraThinMaterial)
                        
                        if isProminent {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.2))
                        }
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(isProminent ? 0.3 : 0.15),
                                        Color.white.opacity(0.05)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.4),
                                        Color.white.opacity(0.1)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    }
                )
                .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
                .opacity(configuration.isPressed ? 0.9 : 1.0)
                .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.purple, .blue, .black],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        VStack(spacing: 20) {
            Text("Glass Effect Demo")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .glassBackground()
            
            Text("Glass Card")
                .foregroundColor(.white)
                .padding()
                .frame(width: 200)
                .glassCard()
            
            Text("Tinted Glass")
                .foregroundColor(.white)
                .padding()
                .glassBackground(cornerRadius: 12, tint: .orange)
            
            Button(action: {}) {
                Text("Glass Button")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
            }
            .buttonStyle(GlassButtonStyle(isProminent: true))
        }
    }
}
