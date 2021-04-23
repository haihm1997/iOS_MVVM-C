//
//  UIImageView+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import Kingfisher

enum PlaceholderSize: String {
    case tiny
    case small
    case medium
    case big
}


extension UIImageView {
    
    typealias ErrorLoadImageHandler = (_ imageUrl: String) -> Void
    
    func setImageByKFWithErrorHandler(imageURL: String?, errorHandler: @escaping ErrorLoadImageHandler) {
        self.contentMode = .scaleAspectFit
        let imgUrl = URL(string: imageURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        guard let rURL = imgUrl else {
            errorHandler(imageURL ?? "")
            return
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: rURL, options: [.cacheOriginalImage]) { result in
            switch result {
            case .success:
                // do anything when task done
                return
            case .failure:
                errorHandler(imageURL ?? "")
            }
        }
    }
    
    func setImageByKF(imageURL: String?, size: PlaceholderSize = .medium, contentMode: ContentMode = .scaleToFill) {
        let placeholder = UIImage(named: "no_image_\(size.rawValue)")
        self.contentMode = contentMode
        guard let imageURL = imageURL, let rURL = URL(string: imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            self.image = placeholder
            self.backgroundColor = .lightGray
            return
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: rURL, options: [.cacheOriginalImage])
    }

}
