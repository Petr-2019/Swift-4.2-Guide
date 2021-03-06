public class Observable<Type> {
    
    // MARK:- Callback
    fileprivate class Callback {
        fileprivate weak var observer: AnyObject?
        fileprivate let options: [ObservableOptions]
        fileprivate let closure: (Type, ObservableOptions) -> Void
        
        fileprivate init(observer: AnyObject, options: [ObservableOptions], closure: @escaping (Type, ObservableOptions) -> Void) {
            self.observer = observer
            self.options = options
            self.closure = closure
        }
    }
    
    // MARK:- Properties
    public var value: Type
    
    // MARK:- Object Lifecycle
    public init(_ value: Type) {
        self.value = value
    }
    
    // MARK:- Managing Observers
    private var callbacks: [Callback] = []
    
    public func addObserver(_ observer: AnyObject, removeIfExists: Bool = true, options: [ObservableOptions] = [.new], closure: @escaping (Type, ObservableOptions) -> Void) {
        if removeIfExists {
            removeObserver(observer)
        }
        
        let callback = Callback(observer: observer, options: options, closure: closure)
        callbacks.append(callback)
        
        if options.contains(.initial) {
            closure(value, .initial)
        }
    }
    
    public func removeObserver(_ observer: AnyObject) {
        
    }
}

// MARK:- ObservableOptions
public struct ObservableOptions: OptionSet {
    
    public static let initial = ObservableOptions(rawValue: 1 << 0)
    public static let old = ObservableOptions(rawValue: 1 << 1)
    public static let new = ObservableOptions(rawValue: 1 << 2)
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
