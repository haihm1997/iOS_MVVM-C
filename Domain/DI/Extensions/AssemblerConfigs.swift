//
//  AssemblerConfigs.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 11/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public enum AssemblerName: String {
    case movieService
    
    public var named: String {
        return self.rawValue
    }

}
