//
//  SVGImgProcessor.swift
//  ClearQuoteSDK
//
//  Created by Abhishek on 24/4/24.
//

import UIKit
internal import Kingfisher
import SVGKit

internal struct SVGImgProcessor: ImageProcessor {
    var identifier: String = "com.appidentifier.webpprocessor"
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
