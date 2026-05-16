//
//  Extensions.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 10/04/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message : String, duration: ToastDuration = .short) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(
            withDuration: 1.0,
            delay: duration.rawValue,
            options: .curveEaseOut,
            animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            }
        )
    }
}
