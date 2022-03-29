// Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

public final class Observable<Value> {

    struct Observer<Value> {
        weak var observer: AnyObject?
        let onChange: (Value) -> Void
    }

    private var observers = [Observer<Value>]()

    public var value: Value {
        didSet { notifyObservers() }
    }

    public init(_ value: Value) {
        self.value = value
    }

    public func observe(_ observer: AnyObject, onChange: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, onChange: onChange))
        onChange(self.value)
    }

    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }

    private func notifyObservers() {
        for observer in observers {
            DispatchQueue.main.async {
                observer.onChange(self.value)
            }
        }
    }
}
