//
//  Single+Validation.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import RxSwift
import Alamofire

public extension PrimitiveSequenceType where Element: DataRequest, Trait == SingleTrait {

    func validate() -> Single<DataRequest> {
        return map { request -> DataRequest in
            NetworkLogger.log(request)
            request.validate { (_, response, _) -> DataRequest.ValidationResult in
                switch response.statusCode {
                case 200..<300:
                    return .success(())
                case 401:
                    return .failure(ProjectError.tokenInvalids)
                default:
                    return .failure(ProjectError.undefine)
                }
            }
            return request
        }
    }
    
}
