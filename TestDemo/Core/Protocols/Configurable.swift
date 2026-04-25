import Foundation

// MARK: - Configurable Protocol
// Protocol for views/components that can be configured with a model
protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}

// MARK: - Reusable Protocol
// Protocol for reusable UI components
protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

// MARK: - Loadable Protocol
// Protocol for views that can show loading state
protocol Loadable {
    var isLoading: Bool { get set }
    func showLoading()
    func hideLoading()
}

extension Loadable {
    func showLoading() {
        var mutableSelf = self
        mutableSelf.isLoading = true
    }
    
    func hideLoading() {
        var mutableSelf = self
        mutableSelf.isLoading = false
    }
}

// MARK: - Identifiable Content Protocol
// Protocol for content that needs unique identification
protocol IdentifiableContent: Identifiable {
    var contentId: String { get }
}

extension IdentifiableContent {
    var contentId: String {
        String(describing: id)
    }
}
