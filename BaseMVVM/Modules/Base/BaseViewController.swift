//
//  BaseViewController.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import RxCocoa
import MBProgressHUD

class BaseViewController: UIViewController {
    
}

extension BaseViewController {
    
    var loadingBinder: Binder<Bool> {
        return Binder(self) { (target, isLoading) in
            if isLoading {
                MBProgressHUD.showAdded(to: target.view, animated: true)
            } else {
                MBProgressHUD.hide(for: target.view, animated: true)
            }
        }
    }
    
}
