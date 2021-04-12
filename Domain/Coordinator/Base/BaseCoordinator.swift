//
//  BaseCoordinator.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public class BaseCoordinator {
    private(set) var childCoordinators: [BaseCoordinator] = []
    
    func start() {
        preconditionFailure("This methods have to be overriden by concrete subclass!")
    }
    
    func finish() {
        preconditionFailure("This methods have to be overriden by concrete subclass!")
    }
    
    final func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    final func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 == coordinator }) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It might not a child coordinator.")
        }
    }
    
    final func removeAllChildCoordinatorWith<T: BaseCoordinator>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T == false }
    }
    
    final func removeAllChildCoordinator() {
        childCoordinators.removeAll()
    }
    
}

extension BaseCoordinator: Equatable {
    
    public static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
    
}
