//
//  BaseCoordinator.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 06/06/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit

public class BaseCoordinator: NSObject {
    public var removeChildHandler: ((BaseCoordinator, [String : Any]?) -> Void)?
    
    public var chilCoordinators: [BaseCoordinator] = []
    public var parent: BaseCoordinator?
    public let resultKey: String = "UserInfoData"
    
    public init(parent: BaseCoordinator?) {
        self.parent = parent
    }
    
    public func start() {
        
    }
    
    deinit {
        print("Released Coordinator: \(String(describing: self))")
    }
    
    func store(child: BaseCoordinator) {
        chilCoordinators.append(child)
    }
    
    func release(child: BaseCoordinator) {
        chilCoordinators.removeAll { $0 === child }
    }
    
    public func didFinish(with userInfo: [String: Any]?) {
        if let parent = parent {
            if userInfo != nil  {
                parent.removeChildHandler?(self, userInfo)
            }
            parent.release(child: self)
        }
    }
    
    public func coordinate(with coordinator: BaseCoordinator) {
        store(child: coordinator)
        coordinator.start()
    }
    
}
