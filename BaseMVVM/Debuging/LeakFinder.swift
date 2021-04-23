//
//  LeakFinder.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 23/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

#if DEBUG
import Foundation
import UIKit

fileprivate class WeakRef<T: AnyObject> {
    weak var object: T?
    var typeString: String
    init(object: T) {
        self.object = object
        typeString = String(describing: type(of: object))
    }
}

class LeakFinder {
    struct Configs {
        let trackingModule: String?
        let checkingTimeInterval: TimeInterval
        
        static var `default`: Configs {
            return Configs(trackingModule: nil, checkingTimeInterval: 1)
        }
    }
    
    static let shared = LeakFinder()
    private let _lock = NSRecursiveLock()
    private var trackRefs = [WeakRef<UIViewController>]()
    private weak var timer: Timer?
    
    var configs = Configs.default
    var isEnabled = false {
        didSet {
            guard oldValue != isEnabled else { return }
            if isEnabled {
                start()
            } else {
                stop()
            }
        }
    }
    
    init() {
        swizzleMethod(of: UIViewController.self, from: #selector(UIViewController.viewDidLoad), to: #selector(UIViewController.swizzleViewDidLoad))
    }
    
    fileprivate func track(_ controller: UIViewController) {
        _lock.lock(); defer { _lock.unlock() }
        
        if let module = self.configs.trackingModule {
            let typeComponents = NSStringFromClass(type(of: controller)).components(separatedBy: ".")
            if typeComponents.count > 1 && typeComponents[0] == module {
                let ref = WeakRef(object: controller)
                trackRefs.append(ref)
                print("☕ did load: \(ref.typeString)")
            }
        } else {
            let ref = WeakRef(object: controller)
            trackRefs.append(ref)
            print("☕ did load: \(ref.typeString)")
        }
    }
    
    private func start() {
        timer = Timer.scheduledTimer(timeInterval: configs.checkingTimeInterval, target: self, selector: #selector(findPotentialLeaks), userInfo: nil, repeats: true)
    }
    
    private func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func findPotentialLeaks() {
        _lock.lock(); defer { _lock.unlock() }
        
        trackRefs = trackRefs.compactMap({ ref -> WeakRef<UIViewController>? in
            guard let object = ref.object else {
                print("☑️ \(ref.typeString) has already released!")
                return nil
            }
            if object.view.superview == nil && object.parent == nil && object.presentedViewController == nil {
                print("⚠️⚠️⚠️ Be aware memory leak for object: \(object)")
                return nil
            }
            return ref
        })
    }
}

//MARK:- Swizzling
fileprivate func swizzleMethod(of type: AnyClass, from fromSelector: Selector, to toSelector: Selector) {
    guard let originalMethod = class_getInstanceMethod(type, fromSelector),
        let swizzledMethod = class_getInstanceMethod(type, toSelector) else { return }
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

fileprivate extension UIViewController {
    @objc func swizzleViewDidLoad() {
        self.swizzleViewDidLoad()
        LeakFinder.shared.track(self)
    }
}
#endif
