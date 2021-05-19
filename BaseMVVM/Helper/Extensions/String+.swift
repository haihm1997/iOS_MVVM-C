//
//  String+.swift
//  SmartPOS
//
//  Created by Hoang Hai on 10/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

extension String {
    
    func localizeWithFormat(args: CVarArg...) -> String {
        return String(format: self, locale: nil, arguments: args)
    }
    
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: self, comment: "")
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
}
