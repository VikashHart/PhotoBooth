//
//  CaptureSession.swift
//  PhotoBooth
//
//  Created by C4Q on 9/12/18.
//  Copyright © 2018 Vikash Hart. All rights reserved.
//

import UIKit

protocol PhotoCaptureable {
    
    func getPhotos(film: [UIImage]) -> [UIImage]
    
    func configurePreview(view: UIView)
}

class CaptureSession: PhotoCaptureable {
    
    func getPhotos(film: [UIImage]) -> [UIImage] {
        <#code#>
    }
    
    func configurePreview(view: UIView) {
        <#code#>
    }
}
