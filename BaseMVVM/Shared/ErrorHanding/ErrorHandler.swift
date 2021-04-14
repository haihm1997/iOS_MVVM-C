//
//  ErrorHandler.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 14/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import SnapKit

class ErrorHandler {
    
    static func defaultAlertBinder(title: String? = "Notification", from controller: UIViewController) -> Binder<ProjectError> {
        return Binder(controller) { (target, error) in
            let alert = UIAlertController(title: title, message: error.debugDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                switch action.style{
                case .default:
                    alert.dismiss(animated: true, completion: nil)
                case .cancel:
                    alert.dismiss(animated: true, completion: nil)
                case .destructive:
                    alert.dismiss(animated: true, completion: nil)
                }
            }))
            target.present(alert, animated: true, completion: nil)
        }
    }
    
}

