import Foundation

// MARK: - ViewModelProtocol
// Base protocol for all ViewModels
protocol ViewModelProtocol: ObservableObject {
    associatedtype State
    associatedtype Action
    
    var state: State { get }
    func handle(_ action: Action)
}

// MARK: - LoadableViewModel Protocol
// Protocol for ViewModels that load data
protocol LoadableViewModelProtocol: ViewModelProtocol {
    var isLoading: Bool { get }
    var error: String? { get }
    
    func load() async
    func retry() async
}

extension LoadableViewModelProtocol {
    func retry() async {
        await load()
    }
}

// MARK: - SelectableViewModel Protocol
// Protocol for ViewModels that handle selection
protocol SelectableViewModelProtocol: ViewModelProtocol {
    associatedtype SelectableItem
    
    var selectedItem: SelectableItem? { get }
    var selectedIndex: Int { get set }
    
    func select(_ item: SelectableItem)
    func selectAt(index: Int)
}
