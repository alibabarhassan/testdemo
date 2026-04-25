import SwiftUI

struct ExpandableText: View {
    let text: String
    let lineLimit: Int
    
    @State private var isExpanded = false
    
    init(_ text: String, lineLimit: Int = 3) {
        self.text = text
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(text)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(isExpanded ? nil : lineLimit)
                .fixedSize(horizontal: false, vertical: true)
            
            Button(action: { isExpanded.toggle() }) {
                Text(isExpanded ? "Read Less" : "Read More")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.orange)
            }
        }
    }
}

#Preview {
    ExpandableText("A complex, intricate narrative that takes a forensic look at New York City's world of high finance. As two highly ambitious figures collide — Chuck Rhoades, the U.S. Attorney for the Southern District of New York, and Bobby Axelrod, the brilliant hedge fund king — the stakes are measured in billions of dollars.", lineLimit: 2)
        .padding()
        .background(Color.black)
}
