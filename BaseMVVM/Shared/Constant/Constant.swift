//
//  Constant.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 23/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit

enum Constant {
    
    enum Size {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        static let navigationHeight: CGFloat = SafeArea.topPadding + 56
        static let tabBarHeight: CGFloat = 64
    }
    
    enum NavigationSize {
        static let shadowPathHeight: CGFloat = 2
        static let header: CGFloat = 56
        static let containerHeight: CGFloat = header + SafeArea.topPadding
        static let totalHeight = header + SafeArea.topPadding + shadowPathHeight
    }
    
    enum SafeArea {
        static var topPadding: CGFloat {
            let vsWindow = UIApplication.shared.keyWindow
            if #available(iOS 11.0, *) {
                return vsWindow?.safeAreaInsets.top ?? 0
            } else {
                return UIApplication.shared.statusBarFrame.height
            }
        }
        
        static var bottomPadding: CGFloat {
            let vsWindow = UIApplication.shared.keyWindow
            if #available(iOS 11.0, *) {
                return vsWindow?.safeAreaInsets.bottom ?? 0
            } else {
                return 0
            }
        }
        
        static var bothPadding: CGFloat {
            return topPadding + bottomPadding
        }
    }
    
}
